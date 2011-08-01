From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 0/4] changes for rc/histogram-diff in 'next'
Date: Mon,  1 Aug 2011 12:20:06 +0800
Message-ID: <1312172410-4380-1-git-send-email-rctay89@gmail.com>
References: <1312168608-10828-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 06:20:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnjzT-0002go-Fz
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 06:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751933Ab1HAEUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 00:20:19 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37546 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035Ab1HAEUR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 00:20:17 -0400
Received: by iyb12 with SMTP id 12so6447661iyb.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 21:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=yL7hpd0gmJ+WBo1RRPoAANU6X7O0EGyLDS2IF4JTPSU=;
        b=gK5N2kjtuwi0YxHJbW+Bm8xLTEieoR7y4W+lBunHI7B/FuTCDe7K9goQRYH2CTLdwr
         lVy9VITrp327HfM2t4fffVgXPvZZoQOfdhh8Q/zKA0Byo4JULLU9j9yuxxgcq9/kRD+t
         VyKtTb1FsriYC5O5EPhJztm5tUL1gwB6+ALOs=
Received: by 10.231.123.206 with SMTP id q14mr2714273ibr.147.1312172416739;
        Sun, 31 Jul 2011 21:20:16 -0700 (PDT)
Received: from localhost (cm119.beta238.maxonline.com.sg [116.86.238.119])
        by mx.google.com with ESMTPS id d8sm6238626icy.9.2011.07.31.21.20.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 21:20:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0
In-Reply-To: <1312168608-10828-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178309>

This is a rebased version of this series:

  [PATCH v2 0/8] teach --histogram to diff
  <1312168608-10828-1-git-send-email-rctay89@gmail.com>

I had overlooked that the previous iteration of the series has been
added to 'next'.

Contents:
[PATCH 1/4] xdiff: do away with xdl_mmfile_next()
[PATCH 2/4] xdiff/xhistogram: rework handling of recursed results
[PATCH 3/4] xdiff/xhistogram: rely on xdl_trim_ends()
[PATCH 4/4] xdiff/xhistogram: drop need for additional variable

-- 
1.7.3.4.730.g67af1.dirty
