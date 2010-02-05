From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: reverting vs resetting
Date: Fri, 5 Feb 2010 01:48:07 -0500
Message-ID: <32541b131002042248x5461d904r276b184533ac492a@mail.gmail.com>
References: <20100205091223.6b4cffb1@pbmiha.malagasy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Mihamina Rakotomandimby <mihamina@gulfsat.mg>
X-From: git-owner@vger.kernel.org Fri Feb 05 11:05:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdL3Y-0003Bj-Et
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 11:04:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933234Ab0BEGs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 01:48:29 -0500
Received: from mail-yw0-f189.google.com ([209.85.211.189]:55839 "EHLO
	mail-yw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933055Ab0BEGs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 01:48:27 -0500
Received: by ywh27 with SMTP id 27so3108841ywh.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 22:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=Cpx7/GYS7+adcnIgbCCjrBkQJ4hjcYeu9vaOooetqvk=;
        b=Yumamo2Iu5H6Iasy1PwMhq/gxis/otjjI80byNmQuPN45xK3tX99APwIPtO7bAYTTh
         iWfBV7CKvO1+yxJGKoqf8mmSavZ1bD/Qg7IpLL0epZinb7yzuRKYd9T75oB/84mZ+CN+
         QFOWPf5QAFVO2vGDRQeuSLl8DenGe0XG5aLBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ftWDgPJO4lwQfTcWmJtTDfU+XbhsnhySchdNIOuTKNgg7w3Z/humo4a9whDi7Nbrls
         VW39vFLM4gqo+89c/PBTKlUvq8x34Xlq3vvSsSgJjWqCSn+yJblvGTsPuL6Rsx8+xvVt
         p/28TMR7q7EvBM6271NBDqip8UNsSStjukWdo=
Received: by 10.150.2.5 with SMTP id 5mr3528803ybb.197.1265352507088; Thu, 04 
	Feb 2010 22:48:27 -0800 (PST)
In-Reply-To: <20100205091223.6b4cffb1@pbmiha.malagasy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139030>

On Fri, Feb 5, 2010 at 1:12 AM, Mihamina Rakotomandimby
<mihamina@gulfsat.mg> wrote:
> When we decided to giveup, we decided to get back to the configuration
> before Bob broke it. But it would be interesting to see Andy's history.
>
> Reverting or resetting?

Try this:

    git checkout HEAD~5 .
    git commit -m "reverted back to the version before this mess"

Replace HEAD~5 with the revision you want it to look like.  But don't
forget the "." in the checkout line!  All the magic is in there.  When
you specify a path ("."), git won't change the revision HEAD points
to, but it will change all the files and the index to the ones from
the specified version.  Then you can commit these files, producing
effectively a single commit that undoes a bunch of previous ones.

Have fun,

Avery
