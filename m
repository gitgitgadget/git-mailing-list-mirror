From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv2] Fixup test-lint error in git-p4 t9814 test
Date: Tue, 28 Apr 2015 07:30:08 +0100
Message-ID: <1430202609-31841-1-git-send-email-luke@diamand.org>
References: <20150427230223.GA22403@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 28 08:30:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ymz2i-00059F-Cv
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 08:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbbD1Gar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 02:30:47 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37545 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbbD1Gaq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 02:30:46 -0400
Received: by widdi4 with SMTP id di4so16317842wid.0
        for <git@vger.kernel.org>; Mon, 27 Apr 2015 23:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pvI1rII9hhngXiVnhpHnSsJqLc0mm80EWa5BM3QmJM0=;
        b=OI8iqyjkDpPFalzvkKvrcfYQpMj7rhqze6MDc3PYX4d9WULbfv1bXt6cR/4o+hm32l
         TedVBYBItT+WrBK8e/7mdnRsuJDx5mjaz+c7j+aAvSn3gK9kXLs3eURQ+MHzMKgniFKv
         eMYGqnH1nNFGu8yJBFIi0WdAUYmlfWfS1VTkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pvI1rII9hhngXiVnhpHnSsJqLc0mm80EWa5BM3QmJM0=;
        b=d3UtTI7PI8PlOzua9PtazD3NC0DeoyCu6KCPsEowh6orKQ9kg00JJ8rp/oaDG4Qhl2
         52sqFraPMdqYNm3vLXi23sim0dT2kRV4OpsWLadxFpCy65pPrbXq+dsPH4OwM/V/xPou
         cTHdagStPMnUWiL/MKREvB2xWX7uHGg+XuBrNMMEnLlbtk9ljO4kMF3oLTx3gt+fwUpQ
         h+y63BCO08FST6P8v+UpsdIjE73/8PTqoEGvC05y9Zo3t8pxD6VZXXi0DBP0UAmAGpMH
         xhlUBGgIa+UCRkMI18qZopoLaenFTxqwQPmM8IqFS3FGdOpiQC/evRFCJeBT7IkLv1+O
         XuIQ==
X-Gm-Message-State: ALoCoQlcABJ8zLgV8KGJG5YwLJb/1/akujHUkEBbzwuJFK7V6B57afIJVfS51aAnYSdSdmay1ex3
X-Received: by 10.194.86.101 with SMTP id o5mr29804957wjz.8.1430202645302;
        Mon, 27 Apr 2015 23:30:45 -0700 (PDT)
Received: from ethel.cable.virginmedia.net (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id a18sm6543394wja.46.2015.04.27.23.30.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2015 23:30:44 -0700 (PDT)
X-Mailer: git-send-email 2.3.4.48.g223ab37
In-Reply-To: <20150427230223.GA22403@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267904>

Using Jeff's suggestion of converting the t9814 test to use
test_lazy_prereq makes the test a lot clearer, and as a bonus,
also fixes the --chain-lint error.

Thanks,
Luke

Luke Diamand (1):
  git-p4: t9814: prevent --chain-lint failure

 t/t9814-git-p4-rename.sh | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

-- 
2.3.4.48.g223ab37
