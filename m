From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: git fsck segmentation fault
Date: Tue, 9 Dec 2008 22:57:22 +0100
Message-ID: <20081209215722.GA8877@auto.tuwien.ac.at>
References: <200811271814.06941.simon@lst.de> <200811272021.56108.simon@lst.de> <alpine.LFD.2.00.0811271449500.14328@xanadu.home> <200811280919.10685.simon@lst.de> <alpine.LFD.2.00.0812091408560.14328@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Simon Hausmann <simon@lst.de>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Dec 09 22:58:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAAbM-0000dm-1s
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 22:58:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754257AbYLIV5Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Dec 2008 16:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754587AbYLIV5Z
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 16:57:25 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:55855 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753609AbYLIV5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 16:57:24 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 7C282680507D;
	Tue,  9 Dec 2008 22:57:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WnopXZWSF6mT; Tue,  9 Dec 2008 22:57:22 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 590E06805045; Tue,  9 Dec 2008 22:57:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0812091408560.14328@xanadu.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102655>

On Tue, Dec 09, 2008 at 02:09:58PM -0500, Nicolas Pitre wrote:
> Has this been looked at?  Martin?

I have not noticed this message.

> #54 0x0000000000493c6d in parse_tree (item=3D0x20d0178) at tree.c:224
> #55 0x0000000000424ca2 in mark_object (obj=3D0x20d0178, type=3D2, dat=
a=3D<value=20
> optimized out>) at builtin-fsck.c:102
> #56 0x0000000000468d1c in fsck_walk (obj=3D<value optimized out>, wal=
k=3D0x424af0=20
> <mark_object>, data=3D0x20d0128) at fsck.c:26
> #57 0x0000000000424cba in mark_object (obj=3D0x20d0128, type=3D2, dat=
a=3D<value=20
> optimized out>) at builtin-fsck.c:105
> #58 0x0000000000468d1c in fsck_walk (obj=3D<value optimized out>, wal=
k=3D0x424af0=20
> <mark_object>, data=3D0x1edb448) at fsck.c:26
> #59 0x0000000000424cba in mark_object (obj=3D0x1edb448, type=3D2, dat=
a=3D<value=20
> optimized out>) at builtin-fsck.c:105
> #60 0x0000000000468d1c in fsck_walk (obj=3D<value optimized out>, wal=
k=3D0x424af0=20
> <mark_object>, data=3D0x1edb420) at fsck.c:26
> #61 0x0000000000424cba in mark_object (obj=3D0x1edb420, type=3D2, dat=
a=3D<value=20
> optimized out>) at builtin-fsck.c:105
> #62 0x0000000000468bf9 in fsck_walk (obj=3D0x241a750, walk=3D0x424af0=
=20
> <mark_object>, data=3D0x241a750) at fsck.c:50
> #63 0x0000000000424b7d in mark_object (obj=3D0x241a750, type=3D1, dat=
a=3D<value=20
> optimized out>) at builtin-fsck.c:105
> #64 0x0000000000468c31 in fsck_walk (obj=3D<value optimized out>, wal=
k=3D0x424af0=20
> <mark_object>, data=3D0x241a708) at fsck.c:57
> #65 0x0000000000424b7d in mark_object (obj=3D0x241a708, type=3D1, dat=
a=3D<value=20
> optimized out>) at builtin-fsck.c:105
> #66 0x0000000000468c31 in fsck_walk (obj=3D<value optimized out>, wal=
k=3D0x424af0=20
> <mark_object>, data=3D0x4dea0b0) at fsck.c:57
> #67 0x0000000000424b7d in mark_object (obj=3D0x4dea0b0, type=3D1, dat=
a=3D<value=20
> optimized out>) at builtin-fsck.c:105
> #68 0x0000000000468c31 in fsck_walk (obj=3D<value optimized out>, wal=
k=3D0x424af0=20
> <mark_object>, data=3D0x488ff78) at fsck.c:57
> #69 0x0000000000424b7d in mark_object (obj=3D0x488ff78, type=3D1, dat=
a=3D<value=20
> optimized out>) at builtin-fsck.c:105
> #70 0x0000000000468c31 in fsck_walk (obj=3D<value optimized out>, wal=
k=3D0x424af0=20
> <mark_object>, data=3D0x488bd18) at fsck.c:57
> #71 0x0000000000424b7d in mark_object (obj=3D0x488bd18, type=3D1, dat=
a=3D<value=20
> optimized out>) at builtin-fsck.c:105
> #72 0x0000000000468c31 in fsck_walk (obj=3D<value optimized out>, wal=
k=3D0x424af0=20
> <mark_object>, data=3D0x313c0b0) at fsck.c:57
> #73 0x0000000000424b7d in mark_object (obj=3D0x313c0b0, type=3D1, dat=
a=3D<value=20
> optimized out>) at builtin-fsck.c:105
> [recursion between line 105 and 57]

If I look at the backtrace, nothing seems wrong. The obj pointers for
mark_object are all different, so its not stuck in a loop. If you look
at type, you will see that it traverses commits (type=3D1) untils
#63. Then it traverses trees (type=3D2).

At my option, there is a commit with a very long ancestory (~40.000
[stack frame count/2]). As we do depth first search for the reachabilit=
y
check, we need about 80.000 frames.

I suggest, that you retry with a very much bigger stack (ulimit -s).

mfg Martin K=F6gler
