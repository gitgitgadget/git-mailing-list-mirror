From: Martin Fick <mfick@codeaurora.org>
Subject: Checking out orphans with -f
Date: Wed, 18 Jan 2012 12:07:05 -0700
Organization: CAF
Message-ID: <201201181207.05967.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 20:07:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rnaqo-0000dx-BG
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 20:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756812Ab2ARTHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 14:07:08 -0500
Received: from wolverine01.qualcomm.com ([199.106.114.254]:26186 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756445Ab2ARTHH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2012 14:07:07 -0500
X-IronPort-AV: E=McAfee;i="5400,1158,6593"; a="156068524"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine01.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 18 Jan 2012 11:07:06 -0800
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id A62AC10004DC
	for <git@vger.kernel.org>; Wed, 18 Jan 2012 11:07:06 -0800 (PST)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am trying to write some scripts which do various things to 
a git repo and I have run into a issue where I think that 
git behavior with respect to orphan branches is potentially 
undesirable.  If I type:

  git checkout --orphan a

I cannot easily abandon this state by simply typing:

  git check -f --orphan b

Is there a better simpler way to abandon a that I am not 
aware of?  Am I miss understanding what -f is supposed to 
do?  It seems like it should allow me to abandon the a 
orphan and continue to checkout the b orphan?

Thanks for any insights,

-Martin

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
