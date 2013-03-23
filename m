From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Avoid false positives in label detection in cpp diff hunk header regex.
Date: Sat, 23 Mar 2013 09:31:12 +0100
Message-ID: <m2y5de34bz.fsf@linux-m68k.org>
References: <loom.20130322T144107-601@post.gmane.org>
	<7vehf78olw.fsf@alter.siamese.dyndns.org> <514CD34F.70107@kdbg.org>
	<7vhak35ami.fsf@alter.siamese.dyndns.org> <514CE53F.3080308@kdbg.org>
	<loom.20130323T011153-345@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Vadim Zeitlin <vz-git@zeitlins.org>
X-From: git-owner@vger.kernel.org Sat Mar 23 09:31:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJJro-00019I-Hk
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 09:31:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754678Ab3CWIbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Mar 2013 04:31:25 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:36629 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608Ab3CWIbY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 04:31:24 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3ZXw1h4446z3hhjh;
	Sat, 23 Mar 2013 09:31:20 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3ZXw1h18MMzbfSv;
	Sat, 23 Mar 2013 09:31:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id 2h5zxNoK0A2E; Sat, 23 Mar 2013 09:31:18 +0100 (CET)
X-Auth-Info: hJojIC/R2zOK3abXfIe0oqAHERY6Va2lvCAYydakEP4=
Received: from linux.local (ppp-93-104-138-13.dynamic.mnet-online.de [93.104.138.13])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sat, 23 Mar 2013 09:31:18 +0100 (CET)
Received: by linux.local (Postfix, from userid 501)
	id 2D7051E5576; Sat, 23 Mar 2013 09:31:13 +0100 (CET)
X-Yow: I appoint you ambassador to Fantasy Island!!!
In-Reply-To: <loom.20130323T011153-345@post.gmane.org> (Vadim Zeitlin's
	message of "Sat, 23 Mar 2013 00:38:37 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218899>

Vadim Zeitlin <vz-git@zeitlins.org> writes:

>   "!^[ \t]*[A-Za-z_][A-Za-z_0-9]+[ \t]*:([^:]|$)\n"

That would fail to match single-character identifiers.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
