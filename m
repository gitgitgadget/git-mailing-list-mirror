From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Filename quoting / parsing problem
Date: Wed, 06 Jan 2010 11:06:15 +0100
Message-ID: <m2eim3wns8.fsf@whitebox.home>
References: <201001011844.23571.agruen@suse.de>
	<201001021236.26947.agruen@suse.de>
	<7v8wcge4kr.fsf@alter.siamese.dyndns.org>
	<201001022148.47841.agruen@suse.de>
	<7viqbgniq1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Gruenbacher <agruen@suse.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 09 13:39:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTabD-0005k1-38
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 13:39:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094Ab0AIMjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 07:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754087Ab0AIMjK
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 07:39:10 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:54609 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605Ab0AIMjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 07:39:09 -0500
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 5B4071C15661;
	Sat,  9 Jan 2010 13:39:05 +0100 (CET)
X-Auth-Info: R0ktkecH2e2vLiPLMEuCLeQsd9mCUAjxts53GMTnKiM=
Received: from whitebox.home (DSL01.83.171.185.36.ip-pool.NEFkom.net [83.171.185.36])
	by mail.mnet-online.de (Postfix) with ESMTP id 477BE90177;
	Sat,  9 Jan 2010 13:39:05 +0100 (CET)
Received: by whitebox.home (Postfix, from userid 501)
	id 7722C1E52C9; Wed,  6 Jan 2010 11:06:16 +0100 (CET)
X-Yow: I love ROCK 'N ROLL!  I memorized the all WORDS to ``WIPE-OUT'' in 1965!!
In-Reply-To: <7viqbgniq1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 05 Jan 2010 17:08:06 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136529>

Junio C Hamano <gitster@pobox.com> writes:

> So you can (and I think git-apply does) follow this simple rule:
>
>     If you see +++/---/rename from/rename to/new file/deleted file, use
>     the names you find there.  Otherwise, because there is no rename,
>     "diff --git" lines has two identical names that follow a/ and b/, so
>     use that name.

If you use diff.mnemonicprefix=true then a/ and b/ may be different.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
