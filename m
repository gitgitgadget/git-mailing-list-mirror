From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: English/German terminology, git.git's de.po, and pro-git
Date: Mon, 13 May 2013 18:30:30 +0200
Message-ID: <CAN0XMOK=A2yp3eL7BEUyiEaMUwnxeH4TezcUKS=8uap_nkH9Fg@mail.gmail.com>
References: <87k3n36nvo.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Stimming <stimming@tuhh.de>,
	Sven Fuchs <svenfuchs@artweb-design.de>,
	Ralph Haussmann <ralph@scanmyfood.de>,
	git <git@vger.kernel.org>, Jan Engelhardt <jengelh@inai.de>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon May 13 18:30:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubve1-0003tH-Bz
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 18:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526Ab3EMQad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 12:30:33 -0400
Received: from mail-we0-f173.google.com ([74.125.82.173]:38849 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375Ab3EMQac (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 12:30:32 -0400
Received: by mail-we0-f173.google.com with SMTP id q54so6287549wes.4
        for <git@vger.kernel.org>; Mon, 13 May 2013 09:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=rd2DOR5zz2vpvLhuj0ebtuLgi4DKlgxq+nDvo9Oizro=;
        b=G7ZE3EdzbONRcCdiZ8eVNr1C0ZN4//Ad48JHAevCoUARAby9I72IsNhO2fXP5M0sN9
         0H3Q5HwAbrMC1vWzPBP5T6o6TKf4LpMcqVm0DPQjPR4R7Lc9SFBOpEWHh+n9eNuf7pHC
         a0fYUrsGd1hlCoBkzprqMCNsQEvxb+GnX228KP88wc13Itmt0u8jzkVxyJ5NE0cSz35D
         O8DFxo5ziQIB+CnAsUhTt5E8ELNAN1EW7csxR3t2dChrTS5VbITjtNy3VSJ1AgVAvC3v
         2JWW0g91d9mCbhhXnvAi3QCoM+ZmZnROi11d40YkPZt5p7agcgyWWG4T8nOTGCJ90ZFe
         hv0Q==
X-Received: by 10.180.86.38 with SMTP id m6mr20253427wiz.25.1368462630364;
 Mon, 13 May 2013 09:30:30 -0700 (PDT)
Received: by 10.194.82.41 with HTTP; Mon, 13 May 2013 09:30:30 -0700 (PDT)
In-Reply-To: <87k3n36nvo.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224178>

2013/5/13 Thomas Rast <trast@inf.ethz.ch>:
> Hi
>
> I hope I got together a Cc list that pretty much represents everyone
> involved in git core and pro-git book translation into German.
>
> As I am sure you are all aware, there are two main religions as to how
> one can translate technical material into German: leave the technical
> terms mostly in English, or translate them to an appropriate
> corresponding word.  I'll denote them G+E and Ger, respectively.  I
> would really like to avoid rehashing that entire discussion in this
> thread, if at all possible; we've flogged that horse enough.  See
> e.g. [1] for previous threads on the git list about the transation.
>
> However, an unfortunate and unsatisfactory situation has developed:
> Christian Stimming's git-gui de.po uses a Ger translation, and Ralf
> Thielow built core git's de.po on top of it, so it's also Ger.
>
> Meanwhile, and independently, Sven Fuchs and Ralph Haussmann wrote a
> translation of pro-git (which is also quite mature at this point, having
> apparently begun in 2009), and as you probably guessed by now, it's G+E.
>
> So that leaves us at a point where "the" libre Git book (and also the
> one that happens to be hosted on git-scm.com, the official site) does
> not match the terminology used by German git.
>
> Like, at all.  They're not even remotely near each other.
>
> Therefore, a total newbie would find at least one of those two totally
> useless.  I haven't done a comprehensive survey yet, but it is my
> impression that the commercial git books are also G+E, so the
> hypothetical newbie would be stuck learning the English terms in one of
> the two regardless.
>
> So where to go from this mess?
>
> Obviously -- unless the agreement is that the status quo should persist
> -- we'd first have to sort out what the preferable translation should
> be.  And I'm a bit scared of trying, except that a straw poll on IRC
> gave me some hope that a simple majority vote could help settle it.
>
> My vote is G+E.
>

My vote is G+E, too. IMO the users should read the same terms in Git
messages as they read in the majority of German Git-books/blogs/etc.
(I don't know one of them where Git terms are translated.) I think that
would make users life easier and less confusing.

> After that, we should create a unified glossary.  Even in the G+E case,
> a few terms would presumably be translated fully and some others might
> have partial translations (checkout -> auschecken?).  The current
> glossary for git's de.po is [2].  I have no idea what Sven and Ralph do.
> Perhaps a github wiki page would be fine for everyone?
>
> Finally, converting the existing translation will require some manpower.
> I'll help review things, as I have previously done for translation
> updates of core git de.po; perhaps with a few more volunteers it can be
> done pretty quickly.
>
> Thanks for your time.
>
> - Thomas
>
>
>
> [1]  http://thread.gmane.org/gmane.comp.version-control.git/58315
>      http://thread.gmane.org/gmane.comp.version-control.git/156226/focus=156373
>      http://thread.gmane.org/gmane.comp.version-control.git/196779/focus=196792
>
> [2]  https://github.com/ralfth/git-po-de/wiki/Glossary
>
> --
> Thomas Rast
> trast@{inf,student}.ethz.ch
