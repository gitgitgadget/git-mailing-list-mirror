From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC/PATCH 0/1] cygwin: Remove the Win32 l/stat() functions
Date: Fri, 28 Jun 2013 00:18:56 +0100
Message-ID: <51CCC860.2070404@ramsay1.demon.co.uk>
References: <51C5FD28.1070004@ramsay1.demon.co.uk> <51C7A875.6020205@gmail.com> <7va9mf6txq.fsf@alter.siamese.dyndns.org> <51C9EE26.9010006@kdbg.org> <7vppv928jx.fsf@alter.siamese.dyndns.org> <51CAF863.4020803@web.de> <51CB62FC.4070001@ramsay1.demon.co.uk> <51CC57F2.8010805@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	dpotapov@gmail.com, Mark Levedahl <mlevedahl@gmail.com>,
	mhagger@alum.mit.edu, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Jun 28 01:21:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsLVm-0003TA-7F
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 01:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072Ab3F0XVx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Jun 2013 19:21:53 -0400
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:51652 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753707Ab3F0XVw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 19:21:52 -0400
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 7C42CA0C080;
	Fri, 28 Jun 2013 00:21:51 +0100 (BST)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id D0763A0C07F;
	Fri, 28 Jun 2013 00:21:50 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;
	Fri, 28 Jun 2013 00:21:48 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <51CC57F2.8010805@web.de>
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229168>

Torsten B=F6gershausen wrote:
[ ... ]

>>> (And have a look how to improve the core.filemode)
>>
>> I don't understand this (parenthetical) comment; could you
>> elaborate on this.
>>

> This is probably wrong information:
> I had in mind that cygwin sets core.filemode=3Dfalse,

It does, see commit c869753e ("Force core.filemode to false on
Cygwin", 30-12-2006).

> which is quite annoying when exchanging .sh files with linux.

Indeed, I used to build git with NO_TRUSTABLE_FILEMODE reset so
that I wouldn't have to edit the config file by hand after a
git-clone or git-init.

> But that seems to be wrong, a quick test shows that core.filemode=3Dt=
rue.

Hmm, it shouldn't - confused!

> Sorry for confusion.

ATB
Ramsay Jones
