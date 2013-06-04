From: Matt McClure <matthewlmcclure@gmail.com>
Subject: Re: Can `git blame` show the date that each line was merged?
Date: Tue, 4 Jun 2013 13:26:59 -0400
Message-ID: <CAJELnLFy_by_7qmEqAyaNxV128ASN5VYoewwftWEt3ege3++zA@mail.gmail.com>
References: <CAJELnLEiK1C9PeimSwDoJoy=wFbFF0+KoK3jhXSAV4b2DsBKqw@mail.gmail.com>
	<20130604155605.GA15953@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 04 19:27:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujv0p-00069q-56
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 19:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754235Ab3FDR1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 13:27:01 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:54569 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754061Ab3FDR1A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 13:27:00 -0400
Received: by mail-pd0-f176.google.com with SMTP id r11so553412pdi.21
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 10:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8sGZob+FLW/CcBaR9sNK5POhtrZam5AYV5YutX1/CzI=;
        b=Wglkotho9q9KyLTUSEiL8jQcPErMW6dPGCqB710ZfDOhBLxq+kXnq2LvF4bvzcimQ/
         coN9Vcdlb6QRO9a/dZFnuRZhJaqaCtrPNJTnSErdaaRIyIHD3KKGz2GR4zGzprjSgSlR
         +qih+X3caTFqOgd/mAoENG7/sndeeWmKrTU0R/2joPZeheJGJWbyGz+EqEpJMki1cUcJ
         Ru1LbbCPUOEMIahs6Jj15OroOLqgZK1IiP52GoLskwCuPMGxppIQXsRLRCtmA8Vtd0/d
         G97IE5RhQRZqZUGC3BNdK45ySuExfFdU+Nni5aZTnkL+kARqev2x8eK3rFwjWF3r0fgN
         d3+Q==
X-Received: by 10.68.225.100 with SMTP id rj4mr29366443pbc.109.1370366819211;
 Tue, 04 Jun 2013 10:26:59 -0700 (PDT)
Received: by 10.68.254.232 with HTTP; Tue, 4 Jun 2013 10:26:59 -0700 (PDT)
In-Reply-To: <20130604155605.GA15953@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226381>

On Tue, Jun 4, 2013 at 11:56 AM, Jeff King <peff@peff.net> wrote:
>> Aside: in some trial and error I notice this oddity:
>>
>>     $ git blame --merges
>>     usage: git blame [options] [rev-opts] [rev] [--] file
>>
>>         [rev-opts] are documented in git-rev-list(1)
>>     ...
>
> Your problem is not the presence of "--merges" here, but that you forgot
> the necessary "file" argument. Try "git blame --merges foo.c".

Oops. Thanks.


-- 
Matt McClure
http://matthewlmcclure.com
http://www.mapmyfitness.com/profile/matthewlmcclure
