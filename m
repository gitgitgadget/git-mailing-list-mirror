From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [BUG/TEST 0/2] bugs with cherry-pick renames
Date: Mon, 11 Feb 2013 20:27:40 -0800
Message-ID: <1360643262-1472-1-git-send-email-sboyd@codeaurora.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 05:28:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U57Te-00032p-Lt
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 05:28:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760386Ab3BLE1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 23:27:46 -0500
Received: from wolverine02.qualcomm.com ([199.106.114.251]:3441 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755047Ab3BLE1p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 23:27:45 -0500
X-IronPort-AV: E=Sophos;i="4.84,647,1355126400"; 
   d="scan'208";a="25120106"
Received: from pdmz-ns-snip_114_130.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine02.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Feb 2013 20:27:45 -0800
Received: from sboyd-linux.qualcomm.com (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 3C7D210004B6
	for <git@vger.kernel.org>; Mon, 11 Feb 2013 20:27:45 -0800 (PST)
X-Mailer: git-send-email 1.8.1.3.566.gaa39828
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216117>

I ran into these bugs the other day and didn't have time to 
investigate further. So I wrote test cases for them instead.

Stephen Boyd (2):
  t3501: Expose bug with cherry-pick into dirty trees w/ renames
  t3501: Expose addinfo_cache error message in cherry-pick

 t/t3501-revert-cherry-pick.sh | 60 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
