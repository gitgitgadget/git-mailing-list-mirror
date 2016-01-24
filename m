From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] merge-file: consider core.crlf when writing merge
 markers
Date: Sun, 24 Jan 2016 11:39:58 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601241138460.2964@virtualbox>
References: <cover.1453482052.git.johannes.schindelin@gmx.de> <c0c775ea7a9ba3244748b784241de685cefc73b1.1453482052.git.johannes.schindelin@gmx.de> <56A31E56.9040700@web.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-67032652-1453632001=:2964"
Cc: Junio C Hamano <gitster@pobox.com>, Beat Bolli <dev+git@drbeat.li>,
	git@vger.kernel.org
To: =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Jan 24 11:40:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNI5o-0000yP-FD
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 11:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbcAXKkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 05:40:21 -0500
Received: from mout.gmx.net ([212.227.17.21]:59832 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751380AbcAXKkT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 05:40:19 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Me4Ly-1al1FH0I8c-00Pvv3; Sun, 24 Jan 2016 11:40:01
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <56A31E56.9040700@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:KeZ0CTaUx344eTAYXfcErEuVpKOW5is7bTZxwTPJ3k75S5EVim/
 q5qo5OrxocOjcvvxL0U37RyEtRq32SBaL5+2zbwa+HSsrSpg1XBFoqQIhhSPuFG/FlYm0Hk
 iw+rR5cVRTQ3AU5LPQb1sgXAG7i0PtHgBEd4PY5idJF2vHm7pn0WfMoE1MbuV/LfAZmYYU4
 ZaBwgd/3FTJzLGAYs6lvw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mdL6ZSs9msg=:HoHFnsXDHvmGY2hrJ8C43Q
 NrJTewBKGr9a7Udo3/F3ZXhubjYZVO60GuGK9ncVVD7ZXCjGy5hdEoDIJ1CGDut3vQWeese5W
 +AZbu2Cuktbmbn+g137oYuutUT/cJFhXoa0eV7/KO+fE/tDfg6l4vn+WTs0QPRbX6IKK8olNI
 iFDw0BTqLh+M+Hepxytj9XuKldGk0nkRutvO8/xf50huE0ZLVTQFupJtRilZTQ0klTBWRuVFA
 Lkypsea1MK5tWNKKGxseaBWhBC8F6RGu3vx/0gLiraHDjBqZ5LZn+FLor+BZALaozthqZHeon
 QjAEzY21NFwIfoSFazjvfglb4uBAbNLg5ky43MLjZLZnZMwlQQJwYV5sc75RvWOsjp86XQcTH
 RMMKgE3zmYVDZ3faXzfsHqhCXrwxOUjrJRtkCtgY8shnj+eUG3P6e1ByOP9KoAIKBxZdJog94
 15i/ZmJ4bJdTZ0dgP9wfECJo/5EgvIkl9ZIjt68g2oB5ZWJAHF4jk7cTFhRziNUpK2YsFPfTK
 zKMgwqe6RojOBrXIzeEQZO0hKcdisa0Ovv3p3KEReNnhVFF12nQ0D3J9A0W6njCKsWVjSdf6w
 cyO7l9yFM6SlSTNp4FdZSTTXS/9fUwTff5g1enTWocz+gSsMNnC2gRyFwdZnjk0oPExO/dAai
 q9AQr/bIs5Cfdqx1kcs4yFVsA1w2bXeSXgzN6wnH6T/WvP+RrnZwLBsiY0B5sveJgciN/gfbK
 uKd0E7pHpd89cb4uYyKSUvVXZ81P1VIuB7FYD0PeSo2fswxSsAZjWplI0EdJK0IW0mDxmADn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284639>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-67032652-1453632001=:2964
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Torsten,

On Sat, 23 Jan 2016, Torsten B=F6gershausen wrote:

> On 2016-01-22 18.01, Johannes Schindelin wrote:
> > From: Beat Bolli <dev+git@drbeat.li>
> >=20
> > When merging files in repos with core.eol =3D crlf, git merge-file
> > inserts just a LF at the end of the merge markers. Files with mixed
> > line endings cause trouble in Windows editors and e.g.
> > contrib/git-jump, where an unmerged file in a run of "git jump merge"
> > is reported as simply "binary file matches".
> >=20
> > [...]
>
> What happens when the original file already has CRLF ?
> And why don't we feed any content into the function ?

Why, indeed. I completely reworked the entire approach and will send out
the result in a moment.

Ciao,
Dscho
--8323329-67032652-1453632001=:2964--
