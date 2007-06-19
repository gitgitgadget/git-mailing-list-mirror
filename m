From: Sergey Yanovich <ynvich@gmail.com>
Subject: [PATCH 3/3] Fix large-scale exports by 'git-svndump'
Date: Tue, 19 Jun 2007 09:54:37 +0300
Message-ID: <11822360772924-git-send-email-ynvich@gmail.com>
References: 11821688443683-git-send-email-ynvich@gmail.com
 <11822360772759-git-send-email-ynvich@gmail.com>
 <11822360772830-git-send-email-ynvich@gmail.com>
Cc: Sergey Yanovich <ynvich@gmail.com>
To: git@vger.kernel.org, normalperson@yhbt.net, J.Sixt@eudaptics.com,
	masterdriverz@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 19 08:53:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0Xau-0005Q8-4J
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 08:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755985AbXFSGxi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 02:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755697AbXFSGxi
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 02:53:38 -0400
Received: from hu-out-0506.google.com ([72.14.214.233]:62729 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755260AbXFSGxg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 02:53:36 -0400
Received: by hu-out-0506.google.com with SMTP id 19so874857hue
        for <git@vger.kernel.org>; Mon, 18 Jun 2007 23:53:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:message-id:in-reply-to:references;
        b=GrXBNmtP0ONTOi2ptLRYE5+W0FjRqPzFgsEG6Gs2iyyh0MQd41AzjSvr61YnoK3CtHZWa+PLxf6tQ9xbx+VGSdafsw29cLH8blGmruQShQaDOm+hXhn33kEz52runa9VXabzXinChMOljOXFT44jl5pfQy+SwVCJNMcXUdSRyG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=b9bTS/AwzD3aLT9zK1htYQSpnTF9WI+plLpEvQaCn+VZo8ufFYh5UIvROBFjsCPjyqMsfHj9WlvfbklDSmrnyQIdI/ur15hVacUMqPJgqqfLL+UzGGtiQTc00EHQiqrzAM9MIyJqumdwCO9ZukfxwOs/aBq6IJdBFJrDAJlg2Y0=
Received: by 10.78.97.7 with SMTP id u7mr2650272hub.1182236014910;
        Mon, 18 Jun 2007 23:53:34 -0700 (PDT)
Received: from host3 ( [87.252.237.202])
        by mx.google.com with ESMTP id o39sm2383562hub.2007.06.18.23.53.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jun 2007 23:53:34 -0700 (PDT)
Received: from sergei by host3 with local (Exim 4.63)
	(envelope-from <ynvich@gmail.com>)
	id 1I0Xbp-0003Tp-VR; Tue, 19 Jun 2007 09:54:37 +0300
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11822360772830-git-send-email-ynvich@gmail.com>
Message-Id: <ad3394d949e01bf962120ad69f59f4017ca5466b.1182235492.git.ynvich@gmail.com>
In-Reply-To: <cff8d32813e43d9e1c75ad50824d95dbcd6f669c.1182235491.git.ynvich@gmail.com>
References: <cff8d32813e43d9e1c75ad50824d95dbcd6f669c.1182235491.git.ynvich@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is an empty patch. It is generated only to preserve headers
([PATCH x/y] ...) for two previous patches. May/should be ignored.

Thanks to Johannes Sixt <J.Sixt@eudaptics.com> for comments.

Signed-off-by: Sergey Yanovich <ynvich@gmail.com>
---
 git-svndump-sync.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-svndump-sync.sh b/git-svndump-sync.sh
index 602af72..b3e47f9 100755
--- a/git-svndump-sync.sh
+++ b/git-svndump-sync.sh
@@ -96,3 +96,4 @@ done
 start=^$last
 
 done
+
-- 
1.5.2.1
