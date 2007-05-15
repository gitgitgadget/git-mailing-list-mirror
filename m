From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Mon, 14 May 2007 17:57:30 -0700
Message-ID: <87wszagayt.fsf@morpheus.local>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> <8b65902a0705070440t40889af0p1fb8dbf7e2a072e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 15 08:22:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnqQE-00027O-5h
	for gcvg-git@gmane.org; Tue, 15 May 2007 08:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761868AbXEOGVi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 15 May 2007 02:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755478AbXEOGVi
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 02:21:38 -0400
Received: from main.gmane.org ([80.91.229.2]:50400 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761868AbXEOGVh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 02:21:37 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HnqPa-0000x3-EG
	for git@vger.kernel.org; Tue, 15 May 2007 08:21:30 +0200
Received: from adsl-71-131-20-72.dsl.sntc01.pacbell.net ([71.131.20.72])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 May 2007 08:21:30 +0200
Received: from davidk by adsl-71-131-20-72.dsl.sntc01.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 May 2007 08:21:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-71-131-20-72.dsl.sntc01.pacbell.net
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:KFef9T0O9EvVB+Zn8aUWLCyCHis=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47317>

"Guilhem Bonnefille" <guilhem.bonnefille@gmail.com> writes:

> In order to improve my productivity with Git, and in order to avoid
> traps around moving from SVN to Git, I often use the Git Emacs mode.
> It is really usefull for beginners as it works similarly for CVS, SVN
> and Git: synthetic view of all modifications, easy selection of what
> will be commited... The biggest drawback of this "porcelain": using
> it, you do not understand the Git's index philosophy.

And it's broken as well.  If you "update" in the emacs mode you cannot
do a "git commit" in a terminal without manually running "git
update-index" first.

I think an emacs-mode that is closer to git-gui would be better, and
closer to the git philosophy

--=20
David K=C3=A5gedal
