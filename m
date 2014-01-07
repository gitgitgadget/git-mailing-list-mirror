From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] pager: set LV=-c alongside LESS=FRSX
Date: Tue, 07 Jan 2014 19:17:09 +0100
Message-ID: <87iotvbqsa.fsf@igel.home>
References: <874n6zbqlh.fsf@helix.nebula.avasys.jp>
	<20140106193339.GH3881@google.com>
	<874n5ghenr.fsf@helix.nebula.avasys.jp>
	<20140107021404.GK3881@google.com>
	<xmqqha9fg225.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Olaf Meeuwissen <olaf.meeuwissen@avasys.jp>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 19:17:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0bDL-000713-V1
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 19:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839AbaAGSRR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 13:17:17 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:40017 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349AbaAGSRP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 13:17:15 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3dzMHs3xfFz4KK4S;
	Tue,  7 Jan 2014 19:17:13 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3dzMHr6xjvzbbcj;
	Tue,  7 Jan 2014 19:17:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id EyevXaRtf3Jj; Tue,  7 Jan 2014 19:17:09 +0100 (CET)
X-Auth-Info: ZrgGZIKo35E7ZdP9NR3fPzQfM0tnV5BCxIMRmhR7SXk=
Received: from igel.home (ppp-88-217-48-150.dynamic.mnet-online.de [88.217.48.150])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Tue,  7 Jan 2014 19:17:09 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 359E02C09F3; Tue,  7 Jan 2014 19:17:09 +0100 (CET)
X-Yow: All I can think of is a platter of organic PRUNE CRISPS being trampled
 by an army of swarthy, Italian LOUNGE SINGERS...
In-Reply-To: <xmqqha9fg225.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 07 Jan 2014 09:00:02 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240124>

Junio C Hamano <gitster@pobox.com> writes:

>  - Scripted Porcelains get LESS=-FRSX while C Porcelains get
>    LESS=FRSX as the default (the leading dash being the
>    difference), which looks somewhat inconsistent.  Not a new
>    problem, though.

Even the less manpage is inconsistent about whether $LESS should start
with a dash (there are examples with and without it).
Implementation-wise, less uses the same function to process an option
argument (including the leading dash) and the value of $LESS, so the
form with the leading dash is probably preferred.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
