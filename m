From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] grep: add option -p/--show-function
Date: Wed, 01 Jul 2009 22:27:40 -0700
Message-ID: <7vy6r7d583.fsf@alter.siamese.dyndns.org>
References: <4A4BDC65.80504@lsrfire.ath.cx> <4A4BDDEA.3030005@lsrfire.ath.cx>
	<7vbpo3errd.fsf@alter.siamese.dyndns.org>
	<4A4C39D3.1020401@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Jul 02 07:28:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMEqG-00016N-N2
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 07:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754400AbZGBF1j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jul 2009 01:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754409AbZGBF1i
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 01:27:38 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:56451 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236AbZGBF1h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 01:27:37 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090702052741.MNGE25927.fed1rmmtao106.cox.net@fed1rmimpo03.cox.net>;
          Thu, 2 Jul 2009 01:27:41 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id AtTg1c0074aMwMQ04tTgSQ; Thu, 02 Jul 2009 01:27:40 -0400
X-VR-Score: -200.00
X-Authority-Analysis: v=1.0 c=1 a=hgzHMRyroUkA:10 a=Lotmli-fYMwAOwW5B68A:9
 a=gMkaqswz46U97y_GjMHilc-Wpo0A:4
X-CM-Score: 0.00
In-Reply-To: <4A4C39D3.1020401@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Thu\, 02 Jul 2009 06\:38\:43 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122620>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Hmm, even shorter would be to leave out these "=3D=3D" things entirel=
y:
>
> 	# mock-up
> 	$ git grep -p -n markers grep.c
> 	grep.c=3D746=3Dstatic void clr_hit_marker(struct grep_expr *x)
> 	grep.c:748:     /* All-hit markers are meaningful only at...
> 	grep.c=3D760=3Dstatic int chk_hit_marker(struct grep_expr *x)
> 	grep.c:762:     /* Top level nodes have hit markers.  See...
> 	grep.c=3D772=3Dint grep_buffer(struct grep_opt *opt, const ch...
> 	grep.c:782:      * We first clear hit markers from them.
>
> Is that still readable?

Actually the above matches what I expected to see when I read your [0/6=
].

Is the use of '=3D' your invention, or does somebody's grep have this
function header feature already and use '=3D' the same way?
