From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: How to start well for a special git construction
Date: Thu, 18 Mar 2010 16:48:52 -0400
Message-ID: <32541b131003181348j1e7d5dfamec09bed2c81916d8@mail.gmail.com>
References: <e8be804e1003181226y20328151s75641f4341ca12d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: bruno le hyaric <bruno.lehyaric@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 21:55:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsMk8-000678-MT
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 21:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060Ab0CRUyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 16:54:55 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:62367 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773Ab0CRUyy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 16:54:54 -0400
Received: by gwaa12 with SMTP id a12so1063032gwa.19
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 13:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=YeYpsH2AnBtU3uYFEVzXVzfCjebsruAEs1p43lEOySg=;
        b=IXD/nFXTUpPnxw0Epb7vybH36QVeoi1r0A1zC4V0lMls9yzBPV47zn9P8AwDRAwJOz
         crj+/04av8Ch8pWXqO1QrtBgzX/E1Tkhk7Inh0mqrqgWhsSFhD+bUj4LKkEk53pm7caN
         NIr6/paqmDYf1vMFsY9AfD7wlqYCcsnFovNR4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Bt78+rJJZR0RzCOzSEo3KP3aMa2HArt5MxZr4dgevuErak06NolYskGqhR0yuPXAZq
         72KFVa2t0pb20Jo/DcAd+VTnUz++ji6ymF90myF2PXEZooBKXxaLdt1XpWVJE65GDAgU
         bRkWXSWbk2dZ+3fOOJDW2FNXCbhQkGrCB89Hs=
Received: by 10.91.19.3 with SMTP id w3mr2686207agi.60.1268945352306; Thu, 18 
	Mar 2010 13:49:12 -0700 (PDT)
In-Reply-To: <e8be804e1003181226y20328151s75641f4341ca12d8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142518>

On Thu, Mar 18, 2010 at 3:26 PM, bruno le hyaric
<bruno.lehyaric@gmail.com> wrote:
> On the left hand, I use one framework : Spree ;
> on the other hand , I use Flex generation with another framework : RestfulX;
> on my third hand ^^, I want to merge both in a third directory.

I think you might have skipped past describing your problem and jumped
straight to describing your solution.

Do you actually have multiple projects that you're working on, or are
you the maintainer of an application that uses other people's
projects?  Do you want to make patches to these other subprojects
(Spree and RestfulX) and distribute them upstream, or do you just want
to use their upstream versions verbatim?  Do you want to patch their
projects and *not* distribute your patches upstream?  Do you expect to
update your copies of those projects frequently or rarely?

Are you planning to distribute copies of your source code, your
finished product, or both?  Ruby on Rails apps usually don't have
anything *but* the source code, but in that case, I'm not sure why you
mention Clearcase and not including the source code in release
streams.

There are a lot of variables here and it's hard to give good advice
unless we have a clearer understanding of what you actually want to
accomplish.

Have fun,

Avery
