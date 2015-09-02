From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Git book figure bug
Date: Wed, 02 Sep 2015 10:39:22 +0200
Organization: gmx
Message-ID: <bf22f191aed6809871e33fd9b34f5267@www.dscho.org>
References: <FADA8795DF99B842A563D149FBDDAE5F58341EF5@VMPREVAS2.prevas.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Jesper_J=C3=B8rgensen?= <Jesper.Jorgensen@prevas.dk>
X-From: git-owner@vger.kernel.org Wed Sep 02 10:39:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZX3Zu-0003QM-WF
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 10:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbbIBIja convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Sep 2015 04:39:30 -0400
Received: from mout.gmx.net ([212.227.15.15]:57506 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750805AbbIBIj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 04:39:27 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LxPAo-1YdOs506WY-016sv8; Wed, 02 Sep 2015 10:39:23
 +0200
In-Reply-To: <FADA8795DF99B842A563D149FBDDAE5F58341EF5@VMPREVAS2.prevas.se>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:wswf031wZnn6Ft+/cpKhfR+W2JzcNhuKINAbdlSnCdR3vZRmyNL
 u7iYDZYABX1H+0E1MowzEvIsb8ApWSZAaXGI0DzWi/K0I0s9QRSUmXZxdAICgtGHb850L0n
 4gd3IaZIIFru3qvmPBmIkMV7xLBZR8mnRWOFt1BXcYYE/At+VrJj5GomHVob644GYIY11At
 3OdLtbv4Rdk04NsFWCaxg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YMfEgwXDGcs=:xFJVtUdRLupvjBN5pp6wKt
 2AsIDmkjv72xlu0aznaxiumYUneOh9WQa9k5zhhXMdLaa/8x+KA2Z0rt47fI6TWVuY/bA73p8
 qoHdbHEVHw1odN8fNxHIqcZeU7dQpwhYo3BMhpqAsub1hDOnMdKTZuql+ANc92j/hwEx/Ai6K
 3WJIjX8rFPwWSHS84wwoisCg/DBGxGnCHM+5R8g0m7wIGxkT2l3pqWKe1Vt3h95ZPcA/jb5/J
 u+Of9NRjZtnJzYiZeV/CxJ9G+khHwZhtgbmtYrKGs3T4ci1e4jNSkWyieF9CX/ShgNg7bCLFS
 Gvu2DoSJyJ2zzc32rEIPLe9tLGgDzOPuaBrf+Pc/939s8Ai8Hh7GqdfNIv+tIcr+8goqTbXCg
 z4aAMRAaRhcjfM8l14vcLb9vGw54kaYeRxOjcRt3U0xatuti+N8kgUJc0ry1o2NizCJTdHEu9
 UTvqmVdskXJsfFp91xw/OfSEVYZ3zsqS/q6KUXDIRv2e/sp8pvs6Rgz5Bho7rnxLGM0FyZw3h
 FJD0fEk7HpCMoppElATOfwElShYIHO6seoNhLmLoQWhn0qX/hbVR/ii7/36Ameb4ul/Xe566T
 IxuTXpb0bWfLelspqeOCU3d49iRgLLW1Cv7jZePpiLIHCwnkiVuDuy7ZCughJVqVKfKmZMCkg
 5PBxM/jCQ2qVfl2l0dtLJ8DiHlDiY0OmRZXBKkyTThRdWRyfaKA9rer3K5Phc/BY04eE9IM+S
 UStGjqyw610/Pp2q85DzgU9+eNRnD5RihIthlA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277081>

Hi Jesper,

On 2015-09-02 09:45, Jesper J=C3=B8rgensen wrote:

> I am learning how git works, and is using the excellent book on the
> official site.
> I believe I have located a mistake in one of the images.
> It is  about Figure 3.17 on this page :
> http://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Mergi=
ng
>=20
> As far as I understand it, the right most snapshot called C5 should
> have been named C6.
> The texts describes a new snapshot being made from the merge of the 2=
 branches.
> Having 2 snapshots both named C5 does not seem like it can be possibl=
e.

Your hunch is correct, and it should be C6, that's why it was changed:

https://github.com/progit/progit2/blob/master/book/03-git-branching/ima=
ges/basic-merging-2.png

I do not know why it is still displayed incorrectly on https://git-scm.=
com/, but your best bet would be to report this as a bug: https://githu=
b.com/git/git-scm.com/issues

But make sure first that there is not another ticket opened for the sam=
e bug!

Ciao,
Johannes
