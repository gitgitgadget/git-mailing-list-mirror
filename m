From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC/PATCH 0/1] cygwin: Remove the Win32 l/stat() functions
Date: Wed, 26 Jun 2013 22:54:04 +0100
Message-ID: <51CB62FC.4070001@ramsay1.demon.co.uk>
References: <51C5FD28.1070004@ramsay1.demon.co.uk> <51C7A875.6020205@gmail.com> <7va9mf6txq.fsf@alter.siamese.dyndns.org> <51C9EE26.9010006@kdbg.org> <7vppv928jx.fsf@alter.siamese.dyndns.org> <51CAF863.4020803@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	dpotapov@gmail.com, Mark Levedahl <mlevedahl@gmail.com>,
	mhagger@alum.mit.edu, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jun 27 00:07:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Urxsb-0007co-EP
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 00:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189Ab3FZWHy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Jun 2013 18:07:54 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:60610 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753174Ab3FZWHx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 18:07:53 -0400
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id C52D16F8BBE;
	Wed, 26 Jun 2013 23:07:52 +0100 (BST)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 1A6ED6F8C45;
	Wed, 26 Jun 2013 23:07:52 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Wed, 26 Jun 2013 23:07:50 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <51CAF863.4020803@web.de>
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229064>

Torsten B=F6gershausen wrote:
> On 2013-06-25 23.18, Junio C Hamano wrote:
>> Johannes Sixt <j6t@kdbg.org> writes:
>>
>>> Some context: This is about a patch by Ramsay that removes the
>>> "schizophrenic lstat" hack for Cygwin. Junio, can you please queue =
that
>>> patch in pu?
>>
>> Sure.  Thanks.
>=20
> First of all,
> thanks for the work.
>=20
> Here some "benchmark" results,=20
> (The test run of the test suite did the same amout of time).

The test suite runs noticeably faster for me.

>=20
> But:
> git status -uno in real life takes double the time,
> git 1.8.3 compared against "pu with the vanilla l/stat"
>   =20
>     1 second ->  2 seconds on linux kernel
> 0.2 seconds -> 0.4 seconds on git.git=20

Hmm, OK, I guess I will have to try something else. Sigh :(

> Do we have any known problems with the current implementation ?

Yes. The next branch is currently broken. (see reply to Junio)

> Does speed matter ?
>=20
> One vote to keep the special cygwin functions.
> (And have a look how to improve the core.filemode)

I don't understand this (parenthetical) comment; could you
elaborate on this.

ATB,
Ramsay Jones
