From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Show modified files in git-ls-files
Date: Fri, 02 Sep 2005 10:04:25 +0100
Message-ID: <tnxzmqvalie.fsf@arm.com>
References: <43179E59.80106@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 02 11:05:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EB7Tr-0008IH-Hx
	for gcvg-git@gmane.org; Fri, 02 Sep 2005 11:05:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbVIBJFA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Sep 2005 05:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbVIBJFA
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Sep 2005 05:05:00 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:38292 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1751130AbVIBJFA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2005 05:05:00 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j8294VQb021558;
	Fri, 2 Sep 2005 10:04:31 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id KAA22156;
	Fri, 2 Sep 2005 10:04:33 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.140]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 2 Sep 2005 10:04:24 +0100
To: Brian Gerst <bgerst@didntduck.org>
In-Reply-To: <43179E59.80106@didntduck.org> (Brian Gerst's message of "Thu,
 01 Sep 2005 20:35:37 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 02 Sep 2005 09:04:24.0618 (UTC) FILETIME=[508EA8A0:01C5AF9D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8011>

Brian Gerst <bgerst@didntduck.org> wrote:
> Add -m/--modified to show files that have been modified wrt. the index.
>
> M was already taken so the tag for modifified files is C (changed).

I think git-ls-files should be consistent with git-diff-cache where M
means modified and U unmerged (but for the former, M is unmerged).

StGIT currently uses C to report a merge conflict but I will probably
change this since it means copied in git-diff-cache.

-- 
Catalin
