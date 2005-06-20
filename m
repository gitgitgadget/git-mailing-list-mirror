From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Stacked GIT 0.2
Date: Mon, 20 Jun 2005 22:00:10 +0100
Message-ID: <tnxslzc68x1.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jun 20 23:00:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkTNN-0000WN-QK
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 23:00:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbVFTVFL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Jun 2005 17:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVFTVBN
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jun 2005 17:01:13 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:9663 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S261575AbVFTVAe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2005 17:00:34 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j5KL006i009203
	for <git@vger.kernel.org>; Mon, 20 Jun 2005 22:00:00 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch1.emea.arm.com [10.1.255.57])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id WAA02646
	for <git@vger.kernel.org>; Mon, 20 Jun 2005 22:00:26 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Mon, 20 Jun 2005 22:00:24 +0100
To: git@vger.kernel.org
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 20 Jun 2005 21:00:24.0885 (UTC) FILETIME=[144DAE50:01C575DB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

StGIT 0.2 is now available. See http://www.procode.org/stgit/

The main changes:

- Multiple heads are supported. Each head has its own series (needs
  separate 'stg init' command for each head). To change between
  series, simply change the .git/HEAD link (thanks to Daniel Barkalow
  for suggesting this)
- top/bottom files for each patch are backed up as a safety measure
- 'stg push' warns when the patch is empty (i.e. it was already merged
  upstream)
- Many bug fixes. The tool is now usable

-- 
Catalin

