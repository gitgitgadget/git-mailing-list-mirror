From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v3 18/21] count-objects: recognize .bitmap in garbage-checking
Date: Sat, 07 Dec 2013 17:38:11 +0100
Message-ID: <87r49oipl8.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
References: <20131114124157.GA23784@sigill.intra.peff.net>
	<20131114124618.GR10757@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Vicent =?utf-8?Q?Mart=C3=AD?= <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 07 17:38:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpKtf-0002in-KI
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 17:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758274Ab3LGQiY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Dec 2013 11:38:24 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:52311 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755383Ab3LGQiX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Dec 2013 11:38:23 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 94A044D6510;
	Sat,  7 Dec 2013 17:38:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id i-6eimdXis62; Sat,  7 Dec 2013 17:38:12 +0100 (CET)
Received: from linux-1gf2.Speedport_W723_V_Typ_A_1_00_098.thomasrast.ch (84-73-190-173.dclient.hispeed.ch [84.73.190.173])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 46F444D64C4;
	Sat,  7 Dec 2013 17:38:12 +0100 (CET)
In-Reply-To: <20131114124618.GR10757@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 14 Nov 2013 07:46:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239004>

Jeff King <peff@peff.net> writes:

> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>
> Count-objects will report any "garbage" files in the packs
> directory, including files whose extensions it does not
> know (case 1), and files whose matching ".pack" file is
> missing (case 2).  Without having learned about ".bitmap"
> files, the current code reports all such files as garbage
> (case 1), even if their pack exists. Instead, they should be
> treated as case 2.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> Signed-off-by: Jeff King <peff@peff.net>

Reviewed-by: Thomas Rast <tr@thomasrast.ch>

--=20
Thomas Rast
tr@thomasrast.ch
