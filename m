From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: emacs and git...
Date: Sat, 24 Mar 2007 16:12:02 +0100
Message-ID: <38b2ab8a0703240812g9c6ad73p960684c13545af74@mail.gmail.com>
References: <38b2ab8a0703220753s67809e87l76ffc57adb725898@mail.gmail.com>
	 <86lkhpmftt.fsf@blue.stonehenge.com>
	 <38b2ab8a0703230029h7f3faa95u1e2ccb6a9ee4be5e@mail.gmail.com>
	 <864poch0xl.fsf@blue.stonehenge.com>
	 <38b2ab8a0703230132j64cf0b94x7c210593f3f31387@mail.gmail.com>
	 <7vtzwcqqf9.fsf@assigned-by-dhcp.cox.net>
	 <38b2ab8a0703230256l5be8a558oe1daa6c5cd2ea16f@mail.gmail.com>
	 <7vwt17kls8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 24 16:12:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HV7ue-000201-Pk
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 16:12:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923AbXCXPMK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 11:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753148AbXCXPMJ
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 11:12:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:32652 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923AbXCXPMG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Mar 2007 11:12:06 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1255085uga
        for <git@vger.kernel.org>; Sat, 24 Mar 2007 08:12:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AMiY++K4iTMSSEVhDJGPtnxGo5mnOiX6d79dAssYe3JkjStSxgwGUlYkBU8KkmM/vWruVYNQA7z4EtmnJ0S29CWOUfeYPnKFoVGvCmIxJvJ9erIaNjJDvgUydHX4Yrs2pVS36d/5POeZ7puR9H0s1PwUhaQ2rKc2GQXznJ5QN60=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dt+zFQ64HCZ1p/TrxSLdGEX3wBYIl+Utu22lubSU0Ftui+ugFkAxauD5OmiUbcSxrhWNteWTAaNuZph3hWuEnvvxfGQLVKz51MX7l/ZYPz92qYSkttwB2xMZ3tpDSa5jGbwM1scIGTn0GT+/0ej/IFCEXQwz+VSAZGeyvxQhDFc=
Received: by 10.114.183.1 with SMTP id g1mr1736612waf.1174749122939;
        Sat, 24 Mar 2007 08:12:02 -0700 (PDT)
Received: by 10.114.38.12 with HTTP; Sat, 24 Mar 2007 08:12:02 -0700 (PDT)
In-Reply-To: <7vwt17kls8.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43004>

On 3/24/07, Junio C Hamano <junkio@cox.net> wrote:
> "Francis Moreau" <francis.moro@gmail.com> writes:
>
> > On 3/23/07, Junio C Hamano <junkio@cox.net> wrote:
> >> "Francis Moreau" <francis.moro@gmail.com> writes:
> >>
> >> > Can't git make 'cat' the default pager when run on a dumb terminal ?
> >>
> >> IIRC, `more` works on a dumb terminal.
> >
> > BTW why not making 'more' the default on a dumb term instead of 'less' ?
>
> Isn't that so 80'ish?
>
>

It simply avoids this kind of output when running `git-diff` from
shell mode for example:

+[m
+Basic bisect commands: start, bad, good[m
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~[m
 [m
 The way you use it is:[m
 [m
 ------------------------------------------------[m
 $ git bisect start[m
-$ git bisect bad                       # Current version is bad[m
-$ git bisect good v2.6.13-rc2          # v2.6.13-rc2 was the last version[m
-                                       # tested that was good[m
+$ git bisect bad                 # Current version is bad[m
+$ git bisect good v2.6.13-rc2    # v2.6.13-rc2 was the last version[m
+                                 # tested that was good[m
 ------------------------------------------------[m
 [m
-When you give at least one bad and one good versions, it will[m
-bisect the revision tree and say something like:[m
+When you give at least one bad and one good versions, it will bisect[m
+the revision tree and say something like:[m
 [m
-- 
Francis
