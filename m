From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH (GITK)] gitk: Fix transient windows on Win32 and MacOS.
Date: Wed, 12 Nov 2008 08:15:08 +0100
Message-ID: <491A827C.3010000@viscovery.net>
References: <200811112355.43352.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 08:17:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L09yg-0000tF-T4
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 08:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbYKLHPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 02:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbYKLHPS
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 02:15:18 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:29963 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939AbYKLHPR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 02:15:17 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1L09wT-00024I-FG; Wed, 12 Nov 2008 08:15:09 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 14DEE4E4; Wed, 12 Nov 2008 08:15:09 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <200811112355.43352.angavrilov@gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100716>

Alexander Gavrilov schrieb:
> Transient windows cause problems on these platforms:
...
> diff --git a/gitk b/gitk
> index 9b2a6e5..e6aafe8 100755

I'd appreciate if you could make it a habit to base your patches on
versions of gitk etc. that are available from a public repository so that
the index information is useful:

Applying: gitk: Fix transient windows on Win32 and MacOS.
warning: gitk-git/gitk has type 100644, expected 100755
error: patch failed: gitk-git/gitk:1754
error: gitk-git/gitk: patch does not apply
fatal: sha1 information is lacking or useless (gitk-git/gitk).
Repository lacks necessary blobs to fall back on 3-way merge.
Cannot fall back to three-way merge.
Patch failed at 0001.

I'm stopping here... :-(

-- Hannes
