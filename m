From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v3 1/5] completion: simplify __gitcomp_1
Date: Sun, 15 Apr 2012 11:49:22 +0200
Message-ID: <m23985cokd.fsf@linux-m68k.org>
References: <1334439784-6460-1-git-send-email-felipe.contreras@gmail.com>
	<1334439784-6460-2-git-send-email-felipe.contreras@gmail.com>
	<87obqueyas.fsf@thomas.inf.ethz.ch>
	<CAMP44s3qXnONLh_=gO4_9DK2=bx0tLBTTAb4WenYh5k2QPQL-g@mail.gmail.com>
	<CAMP44s05KsZFAW=i7TvN0jDNPyFZ4OHkOTwVp2+04CR-jsz-nA@mail.gmail.com>
	<m2ehrpcs9u.fsf@linux-m68k.org> <20120415093334.GB2900@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Apr 15 11:49:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJM5R-0006DP-7y
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 11:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752941Ab2DOJtc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Apr 2012 05:49:32 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:42332 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab2DOJtc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 05:49:32 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3VVnxd591jz4Kn97;
	Sun, 15 Apr 2012 11:49:25 +0200 (CEST)
Received: from linux.local (ppp-93-104-140-113.dynamic.mnet-online.de [93.104.140.113])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3VVnxd4FXYz4KK94;
	Sun, 15 Apr 2012 11:49:25 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
	id 4D63D1E52EC; Sun, 15 Apr 2012 11:49:23 +0200 (CEST)
X-Yow: Yow!  I just went below the poverty line!
In-Reply-To: <20120415093334.GB2900@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1b?=
 =?utf-8?Q?or=22's?= message of
	"Sun, 15 Apr 2012 11:33:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.95 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195553>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> We can even get rid of the %s with
>
>   printf -- "$c\n"

Only if $c can never contain special characters.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
