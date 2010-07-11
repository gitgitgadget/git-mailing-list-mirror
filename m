From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH/RFC] test-lib: clean up trash* directories on SIGINT
Date: Sun, 11 Jul 2010 13:55:37 +0200
Message-ID: <m21vba9qrq.fsf@igel.home>
References: <AANLkTimnrLlprdScYDKHs_lIvFKc3K0n8U5vTzG_df2k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 11 13:55:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXv8N-0003CO-3x
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 13:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683Ab0GKLzl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Jul 2010 07:55:41 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:56224 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845Ab0GKLzk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jul 2010 07:55:40 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id DE5751C156B5;
	Sun, 11 Jul 2010 13:55:38 +0200 (CEST)
Received: from igel.home (ppp-88-217-108-81.dynamic.mnet-online.de [88.217.108.81])
	by mail.mnet-online.de (Postfix) with ESMTP id D37EF1C00333;
	Sun, 11 Jul 2010 13:55:38 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 78BA4CA297; Sun, 11 Jul 2010 13:55:38 +0200 (CEST)
X-Yow: ..  this must be what it's like to be a COLLEGE GRADUATE!!
In-Reply-To: <AANLkTimnrLlprdScYDKHs_lIvFKc3K0n8U5vTzG_df2k@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 11 Jul
 2010 09:51:02
	+0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150774>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Is "trap 'foo' INT" a bashism?

It's the norm.

> Is "trap 'foo' SIGINT" more portable?

<http://www.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.htm=
l#tag_18_28_03>
"Implementations may permit names with the SIG prefix or ignore case in
signal names as an extension."

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
