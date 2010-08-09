From: Joshua Juran <jjuran@gmail.com>
Subject: Re: workflow with blessed, lieutenant, and developers
Date: Mon, 9 Aug 2010 00:42:16 -0700
Message-ID: <172AD488-0169-440A-89FB-DD78584D244A@gmail.com>
References: <20100809092152.5f32646a@packard.rktmb.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mihamina Rakotomandimby <mihamina@gulfsat.mg>
X-From: git-owner@vger.kernel.org Mon Aug 09 09:42:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiN07-0004lA-RM
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 09:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755462Ab0HIHmV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 03:42:21 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50258 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab0HIHmU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Aug 2010 03:42:20 -0400
Received: by pwj7 with SMTP id 7so1172606pwj.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 00:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=QWyCz1bNQi+jca+NvFWoqXFpX3X0k730RAtfgC5dEPs=;
        b=XMt4PjhE8X+sTdSsnCZ00fmz0/d0bFRExvGfmpeyAXyQ2JkJTuohgK1KVSTDfyITmy
         v5JckY3JKPJ9/rJKuhv5E3FCwdLQCtPyZRnPJJ17ijAAnLDaX1tiqoFgUP25YsH+WBZ6
         629cvM0sNg0Fc2si3Nc8h6ZrfxwlN/EZht2Ac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=fX6mdrbRYbNleH4D2VqClRRaAnTW+69a1rn1FOCyCD6wleSy/nE7+X6qORxDCzjMS/
         9J/TloxgCQWyYKMasF1I0wVdJLP+B3q72q11vDoLPv5lMsdUjG6bkSOyQNy1t3/OrsyW
         XiIMvPxfJ7upFfNxBKwJfopHjkw2UKf0VSMHI=
Received: by 10.142.211.6 with SMTP id j6mr13369216wfg.98.1281339739618;
        Mon, 09 Aug 2010 00:42:19 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id w27sm6263421wfd.17.2010.08.09.00.42.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 00:42:18 -0700 (PDT)
In-Reply-To: <20100809092152.5f32646a@packard.rktmb.org>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152953>

On Aug 8, 2010, at 11:21 PM, Mihamina Rakotomandimby wrote:

> I would like to setup a similar thing but with
> - Only one lieutenant (me)

In Linux terminology, you would be the benevolent dictator, not the =20
lieutenant.  The lieutenants are those you trust to submit good patches=
=2E

> - A blessed repository where I am the only one to push to

Okay, though I might use the term 'official'.

> - Developers who push to me (the lieutenant)

Developers shouldn't push directly into your working repo.  If you =20
don't want to use pull requests (where a developer tells you when a =20
branch is ready for you to pull into your own repo) then you can have =20
a centralized bare Git repository for them to push to.  Either they =20
will push completed branches which you then merge into mainline (which =
=20
is essentially the same as the pull request model, except the =20
developers are sharing a repo for this purpose), or the developers =20
themselves will do the merging in the developer repo, which you then =20
pull into your working repo, and after vetting it push to the offical =20
repo.

> Developers pull/clone from the blessed repository.
> I initially clone from the blessed repository.
>
> 1=B0) What command line do developers use to push to me but not to th=
e
> blessed (origin)?
> 2=B0) After they pushed to me, I have the choice to "approve" or =20
> "reject"
> a commit: what is the keyword and git option for that?
> 3=B0) I push the merge of approved commits to the blessed repository:
> what keywords and git options?

If you're going to manage a project, you need to spend enough time =20
learning how Git works that you can answer these questions yourself.  =20
There are multiple good resources online.  I suggest starting with a =20
tutorial, and then experimenting to see what works and what doesn't =20
before you actually try to start working for real.  Along the way =20
you'll find Google very helpful.

Josh
