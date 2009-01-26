From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Jan 2009, #06; Sat, 24)
Date: Mon, 26 Jan 2009 08:52:07 +0100
Message-ID: <497D6BA7.4070409@viscovery.net>
References: <7v8wp0kmj4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 08:53:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRMHu-0006VQ-Kt
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 08:53:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbZAZHwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 02:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbZAZHwQ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 02:52:16 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:33493 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbZAZHwP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 02:52:15 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LRMGO-0001YH-9s; Mon, 26 Jan 2009 08:52:08 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 15808A865; Mon, 26 Jan 2009 08:52:08 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <7v8wp0kmj4.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107174>

Junio C Hamano schrieb:
> * sp/runtime-prefix (Sun Jan 18 13:00:15 2009 +0100) 7 commits
>  - Windows: Revert to default paths and convert them by
>    RUNTIME_PREFIX
>  - Compute prefix at runtime if RUNTIME_PREFIX is set
>  - Modify setup_path() to only add git_exec_path() to PATH
>  - Add calls to git_extract_argv0_path() in programs that call
>    git_config_*
>  - git_extract_argv0_path(): Move check for valid argv0 from caller
>    to callee
>  - Refactor git_set_argv0_path() to git_extract_argv0_path()
>  - Move computation of absolute paths from Makefile to runtime (in
>    preparation for RUNTIME_PREFIX)
> 
> We should move this to 'next' soon with J6t's blessing.

I've been using this series for a few days now without problems:

Acked-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes
