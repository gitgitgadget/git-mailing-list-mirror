From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] git-mergetool--lib.sh: fix mergetool.<tool>.* configurations ignored for known tools
Date: Sat, 05 Jun 2010 11:11:54 +0200
Message-ID: <m2fx11n8rp.fsf@igel.home>
References: <1275705112-8088-1-git-send-email-sylvain@abstraction.fr>
	<1275705112-8088-2-git-send-email-sylvain@abstraction.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Sylvain Rabot <sylvain@abstraction.fr>
X-From: git-owner@vger.kernel.org Sat Jun 05 11:13:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKpRk-0006rr-5e
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 11:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932648Ab0FEJL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jun 2010 05:11:57 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:44948 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932576Ab0FEJL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jun 2010 05:11:56 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 54F001C15798;
	Sat,  5 Jun 2010 11:11:54 +0200 (CEST)
Received: from igel.home (ppp-88-217-114-32.dynamic.mnet-online.de [88.217.114.32])
	by mail.mnet-online.de (Postfix) with ESMTP id 4085E1C0014E;
	Sat,  5 Jun 2010 11:11:54 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 20CEDCA297; Sat,  5 Jun 2010 11:11:54 +0200 (CEST)
X-Yow: What PROGRAM are they watching?
In-Reply-To: <1275705112-8088-2-git-send-email-sylvain@abstraction.fr>
	(Sylvain Rabot's message of "Sat, 5 Jun 2010 04:31:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148462>

Sylvain Rabot <sylvain@abstraction.fr> writes:

> +			if !test -f "$merge_tool_path/$merge_tool_cmd_base"; then

Missing space after '!'.

> +			elif !test -x "$merge_tool_path/$merge_tool_cmd_base"; then

Likewise.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
