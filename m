From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5] Add another option for receive.denyCurrentBranch
Date: Tue, 2 Dec 2014 17:51:57 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412021750340.13845@s15462909.onlinehome-server.info>
References: <cover.1417033080.git.johannes.schindelin@gmx.de> <cover.1417041787.git.johannes.schindelin@gmx.de> <ff9c17b14b4418ae9743a094989d5478dab19701.1417041788.git.johannes.schindelin@gmx.de> <xmqqr3wjnd65.fsf@gitster.dls.corp.google.com>
 <xmqqk32aoowa.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412020909020.13845@s15462909.onlinehome-server.info> <xmqqzjb6m3a2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	=?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 17:52:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvqgK-0006VR-F5
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 17:52:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbaLBQwD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 11:52:03 -0500
Received: from mout.gmx.net ([212.227.17.21]:49790 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932252AbaLBQwC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 11:52:02 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0Lx5hl-1XxXkN3skL-016cBp;
 Tue, 02 Dec 2014 17:51:58 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqzjb6m3a2.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:PIEC9ZpxgmuaGsOOTtHL1HtBHEnocJgX2TWyEDxPo/nMcr/1n2Z
 uQGO/5gtD+X9M7bQk9FfH6HwPP/6DGK62HL0oMOffSDnIG3IZU8yYqgv1Eps353RxohWw0+
 t1e+RJVVOyMTvDapfdHj+4B/MRnqMiZSnq5f7F8NnwI0wTIKjggxcuTnKOqa0oec3Wke44p
 PmXmFQzBTEM+Nn2zOsA3A==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260575>

Hi Junio,

On Tue, 2 Dec 2014, Junio C Hamano wrote:

> This feature [...] needs to be documented with an entry in the BUGS
> section, saying that it will not work in a repository that is tied to
> its working tree via the "gitdir:" mechanism.

Fair enough. But which BUGS section? Should I add one to `git-push.txt` or
`git-receive-pack.txt`? Technically, it should be the latter, but nobody's
gonna find it there...

Ciao,
Johannes
