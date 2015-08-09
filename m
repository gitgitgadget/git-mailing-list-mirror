From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v2] worktree:  list operation
Date: Sun, 09 Aug 2015 08:51:39 +0200
Message-ID: <m2vbcpnedg.fsf@linux-m68k.org>
References: <1439079599-87904-1-git-send-email-rappazzo@gmail.com>
	<1439079599-87904-2-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: gitster@pobox.com, sunshine@sunshineco.com, git@vger.kernel.org
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 08:51:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOKSV-0002d5-9y
	for gcvg-git-2@plane.gmane.org; Sun, 09 Aug 2015 08:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753860AbbHIGvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2015 02:51:47 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:56647 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075AbbHIGvq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2015 02:51:46 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3mprgd4Th5z3hj3T;
	Sun,  9 Aug 2015 08:51:41 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3mprgd3K5xzvh1q;
	Sun,  9 Aug 2015 08:51:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id bflyM1bZsDtD; Sun,  9 Aug 2015 08:51:40 +0200 (CEST)
X-Auth-Info: PtGIxuia5dURmL8hJA0dDJUJ0ICWHbSLoCYwn0sH16Kcd23NluS2BL0APZkExIUn
Received: from linux.local (unknown [188.174.192.39])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sun,  9 Aug 2015 08:51:40 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
	id B091E1E530D; Sun,  9 Aug 2015 08:51:39 +0200 (CEST)
X-Yow: YOU'D cry too if it happened to YOU!!
In-Reply-To: <1439079599-87904-2-git-send-email-rappazzo@gmail.com> (Michael
	Rappazzo's message of "Sat, 8 Aug 2015 20:19:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275526>

Michael Rappazzo <rappazzo@gmail.com> writes:

> @@ -36,7 +37,7 @@ static int prune_worktree(const char *id, struct strbuf *reason)
>  	fd = open(git_path("worktrees/%s/gitdir", id), O_RDONLY);
>  	if (fd < 0) {
>  		strbuf_addf(reason, _("Removing worktrees/%s: unable to read gitdir file (%s)"),
> -			    id, strerror(errno));
> +			id, strerror(errno));

There are still a lot of spurious whitespace changes.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
