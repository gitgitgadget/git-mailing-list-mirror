From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: bug report on update-index --assume-unchanged
Date: Fri, 05 Dec 2014 23:18:03 +0100
Message-ID: <87fvctoi5g.fsf@igel.home>
References: <1417732931.20814.16.camel@segulix>
	<1417759955.10992.2.camel@segulix> <548156E5.2080006@kdbg.org>
	<CACsJy8AVKaq4NJu=23W+wcRgVTQ7hVAOxsVwtZnZsNw6393cTA@mail.gmail.com>
	<1417798622.23238.6.camel@segulix>
	<xmqq1toeq79b.fsf@gitster.dls.corp.google.com>
	<12536C063959480083CC2D4CBA0BA38E@PhilipOakley>
	<xmqqfvctq030.fsf@gitster.dls.corp.google.com>
	<C082ED21306F4D82BCF6B03D9163836B@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Junio C Hamano" <gitster@pobox.com>,
	=?utf-8?Q?S=C3=A9rgio?= Basto <sergio@serjux.com>,
	"Duy Nguyen" <pclouds@gmail.com>, "Johannes Sixt" <j6t@kdbg.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Dec 05 23:18:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx1Cb-0002lx-NL
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 23:18:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbaLEWSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 17:18:14 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:44248 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbaLEWSN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 17:18:13 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3jvSwX2Jhgz3hjQy;
	Fri,  5 Dec 2014 23:18:04 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3jvSwX1S7Tzvh1l;
	Fri,  5 Dec 2014 23:18:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id Sp1VMATwDkoj; Fri,  5 Dec 2014 23:18:03 +0100 (CET)
X-Auth-Info: I5inJijpBLp0vAyeVXn2Wfcbbqu0Hbt6PzcLIOtsTbDIWMusHxHO3emA0jasUrqn
Received: from igel.home (ppp-188-174-159-25.dynamic.mnet-online.de [188.174.159.25])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Fri,  5 Dec 2014 23:18:03 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 0EF542C4408; Fri,  5 Dec 2014 23:18:03 +0100 (CET)
X-Yow: Why am I in this ROOM in DOWNTOWN PHILADELPHIA?
In-Reply-To: <C082ED21306F4D82BCF6B03D9163836B@PhilipOakley> (Philip Oakley's
	message of "Fri, 5 Dec 2014 21:55:09 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260900>

"Philip Oakley" <philipoakley@iee.org> writes:

> However the man page's statement 'When the "assume unchanged" bit is on,
> Git stops checking the working tree files for possible modifications, so
> you need to manually unset the bit to tell Git when you change the working
> tree file.' can easily be understood the way Sergio has described. Git
> stops checking so it won't notice any changes, which is a contract it
> doesn't keep.

The contract is: when you change the working tree file, you must tell
Git about it.  Failure to do so is a breach of the contract.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
