From: Martin Fick <mfick@codeaurora.org>
Subject: git help prune accuracy?
Date: Thu, 15 Dec 2011 14:32:09 -0700
Organization: CAF
Message-ID: <201112151432.09252.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 15 22:47:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbJ8o-0001Fz-C2
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 22:47:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759543Ab1LOVq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 16:46:58 -0500
Received: from wolverine02.qualcomm.com ([199.106.114.251]:11626 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146Ab1LOVq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 16:46:57 -0500
X-IronPort-AV: E=McAfee;i="5400,1158,6561"; a="144887648"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 15 Dec 2011 13:38:03 -0800
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id F312F10004C4
	for <git@vger.kernel.org>; Thu, 15 Dec 2011 13:32:09 -0800 (PST)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187243>

I admit that I am guessing here, but I was wondering if this 
paragraph from git help prune was a incorrect, it says:

  This runs git fsck --unreachable using all the refs 
  available in refs/, optionally with additional set of 
  objects specified on the command line, and prunes all 
  unpacked objects unreachable from any of these head  
  objects from the object database. In addition, it prunes
  the unpacked objects that are also found in packs by
  running git prune-packed.

The last sentence seems like it should maybe have the 
following fix:

s/it prunes the unpacked/it prunes the unreferenced/

-Martin

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
