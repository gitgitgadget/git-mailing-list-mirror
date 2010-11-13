From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Use reflog in 'pull --rebase . foo'
Date: Sat, 13 Nov 2010 09:58:34 +0100
Message-ID: <m2pqu98urp.fsf@whitebox.home>
References: <1289590708-11064-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, santi@agolina.net
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 13 09:59:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHBwu-0001r4-03
	for gcvg-git-2@lo.gmane.org; Sat, 13 Nov 2010 09:59:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755220Ab0KMI6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Nov 2010 03:58:32 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:42888 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755053Ab0KMI6b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Nov 2010 03:58:31 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 11C851C00673;
	Sat, 13 Nov 2010 09:58:35 +0100 (CET)
X-Auth-Info: NdsLZGGBkCzvbPqCGFr6d09CViUgvUS4xmxOYw35wrw=
Received: from linux.local (ppp-88-217-124-240.dynamic.mnet-online.de [88.217.124.240])
	by mail.mnet-online.de (Postfix) with ESMTPA id 130301C00133;
	Sat, 13 Nov 2010 09:58:24 +0100 (CET)
Received: by linux.local (Postfix, from userid 501)
	id 11D021E52EA; Sat, 13 Nov 2010 09:58:34 +0100 (CET)
X-Yow: Now I can join WEIGHT WATCHERS!
In-Reply-To: <1289590708-11064-1-git-send-email-martin.von.zweigbergk@gmail.com>
	(Martin von Zweigbergk's message of "Fri, 12 Nov 2010 20:38:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.90 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161385>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> +	    remote=$(echo "$1" | sed -e 's|+\?\([^:]*\):\?|\1|g')

\? is not portable.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
