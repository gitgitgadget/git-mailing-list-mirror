From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 0/13] Modernize user-manual
Date: Sat, 24 Aug 2013 09:22:12 +0200 (CEST)
Message-ID: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, wking@tremily.us, th.acker@arcor.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 24 09:22:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD8B8-0005Y3-Am
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 09:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572Ab3HXHWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 03:22:18 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:45710 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754124Ab3HXHWR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Aug 2013 03:22:17 -0400
Received: from mail-in-12-z2.arcor-online.net (mail-in-12-z2.arcor-online.net [151.189.8.29])
	by mx.arcor.de (Postfix) with ESMTP id D7C91301C0;
	Sat, 24 Aug 2013 09:22:12 +0200 (CEST)
Received: from mail-in-15.arcor-online.net (mail-in-15.arcor-online.net [151.189.21.55])
	by mail-in-12-z2.arcor-online.net (Postfix) with ESMTP id D4CDA2E6144;
	Sat, 24 Aug 2013 09:22:12 +0200 (CEST)
Received: from webmail08.arcor-online.net (webmail08.arcor-online.net [151.189.8.44])
	by mail-in-15.arcor-online.net (Postfix) with ESMTP id CA8841AB52B;
	Sat, 24 Aug 2013 09:22:12 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-15.arcor-online.net CA8841AB52B
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1377328932; bh=kFEPeO0RM0U4jAuPCZL3OAPJFLJ5f2ZoBhmFVUEgQ2E=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=MRfjhVMpvX6Z326Z99inxjCrXXpgUbLBiIwCOvEHlEdaLyEHIeBQxkFAuqgCOBRbz
	 onxQ3KtPUkFCcbTNrirXekQgwQ0hbBrmotOghGUcpyAVMWi6H3Lsm55LVZSYFeQtNO
	 hMP4kuev0k3UDkcgR7e9ZihJRd3ohipfdY484EvM=
Received: from [188.98.235.44] by webmail08.arcor-online.net (151.189.8.44) with HTTP (Arcor Webmail); Sat, 24 Aug 2013 09:22:12 +0200 (CEST)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.98.235.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232867>

Hi,

command output has changed for some commands in the last years,
so reflect this also in the user-manual. While doing so, fix some minor 
spelling, formatting and wording issues.

Further, some references and recommendations which nowadays might 
only confuse and not help new Git users where removed. Also some 
explanations where rephrased to IMHO make them easier to understand
for new users.

The last patch removes a lengthy paragraph which states that "git prune" 
(and "git fsck") should only be used in a quiescent repository.  The 
man-page for "git prune" tells nothing about this. So either the 
removal should be OK or we have to duplicate the warning paragraph 
in the man-page of "git prune"?

[PATCH 01/13] Call it "Git User Manual" and remove reference to very old Git version
[PATCH 02/13] Use current "detached HEAD" message
[PATCH 03/13] Use current output for "git repack"
[PATCH 04/13] Use "git merge" instead of "git pull ."
[PATCH 05/13] Fix some typos
[PATCH 06/13] Simplify "How to make a commit"
[PATCH 07/13] Improve description in "How to merge"
[PATCH 08/13] Improve section "Manipulating branches"
[PATCH 09/13] Improve section "Merge multiple trees"
[PATCH 10/13] Remove unnecessary historical note from "Object storage format"
[PATCH 11/13] Remove obscure reference from "Examples"
[PATCH 12/13] Remove irrelevant reference from "Tying it all together"
[PATCH 13/13] "git prune" is safe now

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>


---
Thomas
