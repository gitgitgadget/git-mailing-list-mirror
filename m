From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v2 13/14] daemon: use select() instead of poll()
Date: Sat, 16 Jan 2010 12:27:51 +0100
Message-ID: <m26372uw5k.fsf@igel.home>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
	<201001160906.26270.j6t@kdbg.org>
	<40aa078e1001160126q34bc066as3adb9b61eac690d@mail.gmail.com>
	<201001161138.36535.j6t@kdbg.org>
	<40aa078e1001160305y17b46a6dtc4959e5255c7acae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, msysgit@googlegroups.com,
	git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Sat Jan 16 12:28:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NW6ow-00082E-UF
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 12:27:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282Ab0APL1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 06:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752985Ab0APL1y
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 06:27:54 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:48102 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605Ab0APL1y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 06:27:54 -0500
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 5D31B1C1545D;
	Sat, 16 Jan 2010 12:27:52 +0100 (CET)
Received: from igel.home (DSL01.83.171.154.110.ip-pool.NEFkom.net [83.171.154.110])
	by mail.mnet-online.de (Postfix) with ESMTP id 48A4A9005E;
	Sat, 16 Jan 2010 12:27:52 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id E6138CA298; Sat, 16 Jan 2010 12:27:51 +0100 (CET)
X-Yow: ...It's REAL ROUND..  And it's got a POINTY PART right in the MIDDLE!!
 The shape is SMOOTH..  ..And COLD.. It feels very COMFORTABLE on my
 CHEEK..  I'm getting EMOTIONAL..
In-Reply-To: <40aa078e1001160305y17b46a6dtc4959e5255c7acae@mail.gmail.com>
	(Erik Faye-Lund's message of "Sat, 16 Jan 2010 12:05:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137223>

Erik Faye-Lund <kusmabite@googlemail.com> writes:

> ...but __WSAFDIsSet() seems to be every bit as official on Windows as
> FD_ISSET() (documented in msdn, without any notes not to use it), so I
> still don't really see the point.

The fact that it starts with two underscores suggests that it is kinda
internal.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
