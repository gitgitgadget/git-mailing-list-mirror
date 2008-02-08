From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Minor annoyance with git push
Date: Fri, 8 Feb 2008 17:50:36 +1300
Message-ID: <46a038f90802072050s46ffe305mcffffa068511e3b8@mail.gmail.com>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 08 05:51:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNLCh-0006jb-Ui
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 05:51:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbYBHEuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 23:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760502AbYBHEui
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 23:50:38 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:24509 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760215AbYBHEuh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 23:50:37 -0500
Received: by ug-out-1314.google.com with SMTP id z38so824710ugc.16
        for <git@vger.kernel.org>; Thu, 07 Feb 2008 20:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=aFT33qgdGvvmZ/z3ZUsXp3Jer/YkHKfDNUZMFIl9mXk=;
        b=iQty07PRipxnfzW5pofYzATe9c4Q3NIa3yYaJG4ksBIXCRldkGulVI2y5IizuP6+iWMUN9+Rv+XrE8GmQCrZ4S7zQ1rzX/sRfUtVfegr19wIChbigHHtZ+cAT5a1ClquK89KjDM7NNoU66GIje7IztRANYgmmteIVhVZSRrx03U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jzvtaDN1oxGSDKHoNiDJXHTn55NylCkhcm8z7uUwXuT2RIDZDVevy//YjJRa7TNODDxfSNpmnXTpghxgatINEFx1fOgR17oc/meTL4eYcWHZDoCrBEtmVfkL4nNDXAXzj9wptgGi8pdlSuOIEeVwaETlBUVKZMC/6xpfJPeuF9U=
Received: by 10.66.252.18 with SMTP id z18mr4938297ugh.37.1202446236225;
        Thu, 07 Feb 2008 20:50:36 -0800 (PST)
Received: by 10.66.250.13 with HTTP; Thu, 7 Feb 2008 20:50:36 -0800 (PST)
In-Reply-To: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73039>

On Feb 8, 2008 5:44 PM, Martin Langhoff <martin.langhoff@gmail.com> wrote:
>  None of these "rejected" branches have anything _new_, they
> are just stale. Nothing new to say.

And I guess the natural follow up question is: would it make sense to
tell git pull to do a "merge" for not-checked-out branches where we
can safely tell that the resulting "merge" will actually be a
fast-forward?

Would that be unsafe in any way?

Because when I "git checkout bla-stale-branch" to help a fellow
developer again, I have to remember to "git merge
origin/bla-stale-branch" to get a much needed fast-forward before
starting to work.

[ Or we could be more proactive at deleting unused local heads. But
that's a bit of silly maintenance just to keep things tidy, that git
could keep tidy ;-) ... ]

cheers,


m
