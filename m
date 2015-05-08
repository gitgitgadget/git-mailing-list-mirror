From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 1/3] command-list.txt: group common commands by theme
Date: Fri, 08 May 2015 14:01:51 +0200
Message-ID: <87egmrth00.fsf@igel.home>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com>
	<b89d3fec640cb6fb01aa32ad50bae4e064528220.1430770308.git.sebastien.guimmara@gmail.com>
	<CAPig+cTHQikgOvPrjxikUNjQoWCv2hdubJ55OG0SqpGUs_3Pow@mail.gmail.com>
	<554A8084.10506@gmail.com>
	<CAPig+cQ2e4c5hYsRbZhgyvLcMPsqshqRUZGNLwhJd57YP9JEFA@mail.gmail.com>
	<554BBBAF.30705@kdbg.org>
	<0eb58475c6238be314eb4f0be08f8ae6@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?utf-8?Q?S=C3=A9bastien?= Guimmara 
	<sebastien.guimmara@gmail.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 08 14:02:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqgz1-0003oB-8L
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 14:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018AbbEHMB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 08:01:59 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:49629 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713AbbEHMBz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 08:01:55 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3ljqyS6MJwz3hjPL;
	Fri,  8 May 2015 14:01:52 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3ljqyS5j1VzvdWw;
	Fri,  8 May 2015 14:01:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id K1CtVu4wmH69; Fri,  8 May 2015 14:01:51 +0200 (CEST)
X-Auth-Info: bNTbhWs7m9HIjk+bCwHPCCgtMIaxEFz3rOVZmYrdyiUfNQtUrVGwDBlnjeYXQaTI
Received: from igel.home (ppp-93-104-60-133.dynamic.mnet-online.de [93.104.60.133])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Fri,  8 May 2015 14:01:51 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 535D12C3B3D; Fri,  8 May 2015 14:01:51 +0200 (CEST)
X-Yow: These PRESERVES should be FORCE-FED to PENTAGON OFFICIALS!!
In-Reply-To: <0eb58475c6238be314eb4f0be08f8ae6@www.dscho.org> (Johannes
	Schindelin's message of "Fri, 08 May 2015 12:11:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268613>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> It's probably my failure for not finding the documentation on that, but I really would like to be educated. Do you have an authoritative source for that statement?

http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html

3.206 Line
A sequence of zero or more non- <newline> characters plus a terminating
<newline> character.

3.397 Text File
A file that contains characters organized into zero or more lines. The
lines do not contain NUL characters and none can exceed {LINE_MAX} bytes
in length, including the <newline> character. Although POSIX.1-2008 does
not distinguish between text files and binary files (see the ISO C
standard), many utilities only produce predictable or meaningful output
when operating on text files. The standard utilities that have such
restrictions always specify "text files" in their STDIN or INPUT FILES
sections.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
