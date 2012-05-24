From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 2/2] completion: split __git_ps1 into a separate script
Date: Thu, 24 May 2012 22:49:48 +0200
Message-ID: <20120524204948.GA9028@goldbirke>
References: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com>
	<1337719600-7361-3-git-send-email-felipe.contreras@gmail.com>
	<4FBC0019.6030702@in.waw.pl>
	<7v4nr72bim.fsf@alter.siamese.dyndns.org>
	<CAMP44s0aKi+8WHPXYLQ+iSMkj9iV88JGTabrpBRNBWb7upAMiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org, Ted Pavlic <ted@tedpavlic.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Kerrick Staley <mail@kerrickstaley.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Ville =?iso-8859-1?Q?Skytt=E4?= <ville.skytta@iki.fi>,
	Dan McGee <dan@archlinux.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 24 22:50:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXeyz-00023Y-MX
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 22:50:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759230Ab2EXUt7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 May 2012 16:49:59 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:63713 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759219Ab2EXUt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 16:49:59 -0400
Received: from localhost6.localdomain6 (p5B13046B.dip0.t-ipconnect.de [91.19.4.107])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0M7Fkw-1S9uzz3Oha-00xKFy; Thu, 24 May 2012 22:49:50 +0200
Content-Disposition: inline
In-Reply-To: <CAMP44s0aKi+8WHPXYLQ+iSMkj9iV88JGTabrpBRNBWb7upAMiQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:o6lx8sYPIPB8mTA3SChT/Y2FnRZrGoeAm2fuiVu4bWV
 4GrpEix0rGuu2hhGbrVYNXPK+SO6S2KGGPd7G2U+rNQG25FKK3
 8xENwm6xG03pPy3R3Dc4+pnpfNMazevuZB5A731EJNavmlZZoj
 xJqxwSqbmcqZ4hx2DDcZ6kckUZLISdRaz00BPYBgqPCxQdYjus
 b6dUKZE+IV3G+ibi/6ozUfQzSvw6uXuT/EvMx/K1Kr2EjV3jhQ
 kff3W/+mHkjdeDYu4relxh2h/gomwh8baLXieGKQLDpydlT4Lz
 qu2sv0K7zF+j4DNiVgpjaLQkh7d7ALSUgM0CzCOXKLO4KJXeRF
 NShV8scRvaSKTT1xC/kM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198425>

On Wed, May 23, 2012 at 05:40:46PM +0200, Felipe Contreras wrote:
> What do we gain by this incredible user annoyance? Less maintenance
> burden of __gitdir() which barely changes anyway?

I happen to have a topic in the works which changes __gitdir() and
adds some helper functions to it, so the diffstat of all
__gitdir()-related changes is this:

 1 file changed, 71 insertions(+), 6 deletions(-)


G=E1bor
