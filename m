From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 2/3] tests: Test how well "git apply" copes with weird filenames
Date: Sat, 24 Jul 2010 10:03:59 +0200
Message-ID: <m2r5iti9w0.fsf@igel.home>
References: <20100724010618.GA13670@burratino>
	<20100724011114.GC13670@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
	Giuseppe Iuculano <iuculano@debian.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 10:04:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcZiS-0003Su-U8
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 10:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738Ab0GXIEJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 04:04:09 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:41125 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686Ab0GXIEF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 04:04:05 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 0DB661C1595B;
	Sat, 24 Jul 2010 10:04:01 +0200 (CEST)
Received: from igel.home (ppp-93-104-154-255.dynamic.mnet-online.de [93.104.154.255])
	by mail.mnet-online.de (Postfix) with ESMTP id 011D51C001FE;
	Sat, 24 Jul 2010 10:04:00 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id C7884CA297; Sat, 24 Jul 2010 10:04:00 +0200 (CEST)
X-Yow: I'm losing my hair..did it go to ATLANTIC CITY??
In-Reply-To: <20100724011114.GC13670@burratino> (Jonathan Nieder's message of
	"Fri, 23 Jul 2010 20:11:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151603>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The tests assume a reasonably well-behaved =E2=80=9Cdiff -u=E2=80=9D =
and =E2=80=9Cpr=E2=80=9D
> to produce the (possibly whitespace-damaged) patches.  On platforms
> without those commands, skip the tests.

pr -T is not portable.  What's wrong with expand?

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
