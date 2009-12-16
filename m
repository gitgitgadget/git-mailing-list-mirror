From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: am fails to apply patches for files with CRLF lineendings
Date: Wed, 16 Dec 2009 01:38:20 +0100
Message-ID: <m2eimvu51f.fsf@igel.home>
References: <20091214183337.GA25462@atjola.homenet>
	<7vvdg9i9mn.fsf@alter.siamese.dyndns.org>
	<tCQlJn153g8Oa6Z9HKe6xOUQJdcf2PCIVthlTrLgYE-wJ5jFyXVXWw@cipher.nrlssc.navy.mil>
	<7vhbrtdtth.fsf@alter.siamese.dyndns.org>
	<ee63ef30912141650ie05baf4kab8505adf160c62e@mail.gmail.com>
	<20091215012514.GB1317@atjola.homenet> <m26387voiy.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	jk@silentcow.com, git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 16 01:38:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKhud-0002hp-8R
	for gcvg-git-2@lo.gmane.org; Wed, 16 Dec 2009 01:38:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759994AbZLPAi2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Dec 2009 19:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755852AbZLPAi1
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 19:38:27 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:57860 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756097AbZLPAi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 19:38:26 -0500
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id D2BCE1C15585;
	Wed, 16 Dec 2009 01:38:21 +0100 (CET)
Received: from localhost (dynscan2.mnet-online.de [192.168.1.215])
	by mail.m-online.net (Postfix) with ESMTP id C627590693;
	Wed, 16 Dec 2009 01:38:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.1.215]) (amavisd-new, port 10024)
	with ESMTP id r8W6fPJJoFYm; Wed, 16 Dec 2009 01:38:20 +0100 (CET)
Received: from igel.home (DSL01.83.171.165.132.ip-pool.NEFkom.net [83.171.165.132])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Wed, 16 Dec 2009 01:38:20 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 7C08DCA28C; Wed, 16 Dec 2009 01:38:20 +0100 (CET)
X-Yow: My mind is a potato field...
In-Reply-To: <m26387voiy.fsf@igel.home> (Andreas Schwab's message of "Tue, 15
	Dec 2009 23:52:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.90 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135310>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:
>
>> Right. And checking, after sending a patch containing CRs with mutt,=
 it
>> lost those CRs. Even the local copy saved directly by mutt, which di=
dn't
>> leave my box, lacks the CRs. So it seems basically impossible to sen=
d
>> patches to CRLF files inline.
>
> If you want to send mail containing a bare CR you need to encode it.

Btw, this mail had a stray CR added to the last line when I sent it out
(properly encoded as quoted-printable), but that didn't make it through
gmane.  :-)

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
