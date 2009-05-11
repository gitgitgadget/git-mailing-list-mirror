From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] gitk: use --textconv to generate diff text
Date: Mon, 11 May 2009 09:34:50 +0200
Message-ID: <4A07D51A.4090409@viscovery.net>
References: <4A07D160.9020709@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon May 11 09:35:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3Q2T-0007zx-09
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 09:35:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbZEKHe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 03:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbZEKHe5
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 03:34:57 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:3584 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbZEKHe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 03:34:56 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M3Q2J-000159-UJ; Mon, 11 May 2009 09:34:56 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B13FEC6C1; Mon, 11 May 2009 09:34:55 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <4A07D160.9020709@viscovery.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118779>

Johannes Sixt schrieb:
> From: Johannes Sixt <j6t@kdbg.org>
> Date: Tue, 28 Apr 2009 14:03:54 +0200
> 
> For the most part gitk's focus is on showing history and changes in
> a human readable form. For this reason, it makes sense to generate
> the patch text in the diff view using --textconv so that textconv drivers
> are used if they are defined.

FWIW, I keep a few Word documents in git and use catdoc as textconv
driver. This works pretty well. Git-gui doesn't show any textual changes
(it treats the Word files as binary, and it has to), with this patch I can
use gitk to preview the changes in the worktree and the index.

-- Hannes
