From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: How to update a cloned git repository
Date: Tue, 11 Sep 2012 14:48:29 +0200
Message-ID: <007101cd901b$bea9d3d0$3bfd7b70$@schmitz-digital.de>
References: <k2n4v2$88t$1@ger.gmane.org> <vpq7gs0es4f.fsf@bauges.imag.fr>	<006f01cd900e$fce59a60$f6b0cf20$@schmitz-digital.de>	<vpqy5kgdctm.fsf@bauges.imag.fr>	<007001cd9016$8f980f80$aec82e80$@schmitz-digital.de> <vpq4nn4d968.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'git'" <git@vger.kernel.org>
To: "'Matthieu Moy'" <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 11 14:48:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBPtX-0000G8-Cr
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 14:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748Ab2IKMsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 08:48:36 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:64375 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275Ab2IKMsf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 08:48:35 -0400
Received: from DualCore (dsdf-4db532aa.pool.mediaWays.net [77.181.50.170])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MErYk-1TLowy2kVG-00FWHI; Tue, 11 Sep 2012 14:48:34 +0200
In-Reply-To: <vpq4nn4d968.fsf@bauges.imag.fr>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQKMBvoOU6gFyfWBzbsL0abxuS38eAGIfo3NAn/3ZEkBI0tT7gGZb1rsAnF9OYqVvnOnQA==
Content-Language: de
X-Provags-ID: V02:K0:F0RZF1uxvLfwMahDhZBaGUJLnZY95WguIHoJnT224nb
 42UOKr4Q8ro09ZHtzSoTqoL1iCDmXiNT8SIUXpmqM3xtU5xNNU
 S0ffTVx+hbhuVUhcgwpBC2PMwaGLkq7DMnku3skMO4MDna0HRS
 FnjToZYMTmZpaqGXVkykbmZK3pS4Q4zppPV+i7zMJpmNu7GMMG
 nP2Cn2h0xMiibPX1FsLfb0+3nTWvG3Fu+C6whM3gEcRx57cJMT
 G8QND5tFIM3jnDnAIIwZZUZ45hSZa+hsfJ/aAlmD9M2mN73Z3Q
 ihjDwAxm0vt695M9E9sTUJYX2VKrQNrWB/MyPRm+ooY/ZXS2pO
 N5teUzPB7tSMPMzYXfQrNvZpDXtvLXEZaX0uYWRBoTJPLIaYfR
 IGuvOP+ZOtTIw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205226>

> From: Matthieu Moy [mailto:Matthieu.Moy@grenoble-inp.fr]
> Sent: Tuesday, September 11, 2012 2:41 PM
> To: Joachim Schmitz
> Cc: git
> Subject: Re: How to update a cloned git repository
> 
> [ Re-adding git@vger in Cc, I guess it was meant to be so ]


Oops, yes it was meant to.

> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> >> Then, work on the tip of the topic branch you depend on instead of pu.
> >> These are more stable, as they will be rewritten only if this particular
> >> topic branch changes.
> >
> > These are not available from git hub. Or are they? How?
> 
> I think they exist in some of the repos junio pushes to, but I don't
> remember how/which one.
> 
> Anyway, you can easily get it from the commit that merges the branch
> (it's the-merge-commit^1).
> 
> >> > Like this?
> >> > git pull --rebase HEAD~42
> >>
> >> That would be "git fetch" and then "git rebase", as I don't think "git
> >> pull --rebase" would allow you to specify the starting point for rebase.
> >
> > OK, I'll try that next time then. Like this?
> > 	git fetch;git rebase HEAD~42 --onto origin/pu
> 
> That should work, yes.
> 
> In general, when you have a somehow complex workflow, I recommand
> fetch+(merge|rebase) over pull. It gives you more flexibility, and the
> opportunity to check what you fetched before starting the merge.

OK, thanks.

I'm sure I'll have more questions later though ;-)
