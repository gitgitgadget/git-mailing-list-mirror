From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 0/3] prepare for histogram diff
Date: Wed,  6 Jul 2011 14:15:42 +0800
Message-ID: <1309932945-5048-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 06 08:16:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeLPJ-0003Pf-KW
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 08:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754100Ab1GFGP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 02:15:58 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:53949 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753920Ab1GFGP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 02:15:58 -0400
Received: by gxk21 with SMTP id 21so2518950gxk.19
        for <git@vger.kernel.org>; Tue, 05 Jul 2011 23:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=2tnawiJQDi8r/V8xUvtZ3r/Y7/LsyyE2EdQIfQ/GV6U=;
        b=IEJK6CJxAjKozIRP4j4Nf0gUh670cDm9cIvmVV2T/MXWWW0hoQSzvr2oZKMUXeTPa/
         bEujTvUX7gstryEn+vJ5tjMrmKlMZR/HitORyGiQN3yG2vzzUdyUBvOyn+dKXPdhpzjW
         BTBmM7M9F6cvuNDmNROpJvJYMjttWudKBbIak=
Received: by 10.236.186.65 with SMTP id v41mr7943579yhm.1.1309932957261;
        Tue, 05 Jul 2011 23:15:57 -0700 (PDT)
Received: from localhost (cm119.beta238.maxonline.com.sg [116.86.238.119])
        by mx.google.com with ESMTPS id f4sm2351884yhn.13.2011.07.05.23.15.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Jul 2011 23:15:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176637>

Tay Ray Chuan (3):
  xdiff/xprepare: use memset
  xdiff/xpatience: factor out fall-back-diff function
  t4033-diff-patience: factor out tests

 t/lib-diff-patience.sh   |  162 ++++++++++++++++++++++++++++++++++++++++++++++
 t/t4033-diff-patience.sh |  162 +---------------------------------------------
 xdiff/xpatience.c        |   27 +-------
 xdiff/xprepare.c         |   10 +--
 xdiff/xutils.c           |   31 +++++++++
 xdiff/xutils.h           |    2 +
 6 files changed, 203 insertions(+), 191 deletions(-)
 create mode 100644 t/lib-diff-patience.sh

-- 
1.7.3.4.678.g170bd
