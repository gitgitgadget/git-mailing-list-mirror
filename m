From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v4 0/4] Document diff and filter drivers in config
Date: Wed,  6 Apr 2011 15:27:30 +0530
Message-ID: <1302083854-2448-1-git-send-email-artagnon@gmail.com>
References: <1301654600-8901-1-git-send-email-artagnon@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 06 11:59:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7PVs-0005tN-N2
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 11:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755375Ab1DFJ6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 05:58:44 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44390 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755263Ab1DFJ6n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 05:58:43 -0400
Received: by iyb14 with SMTP id 14so1266731iyb.19
        for <git@vger.kernel.org>; Wed, 06 Apr 2011 02:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=PT0fmojxG7Y5gZFiTj/cIkorBCKewJmM9/aGc/7bmQw=;
        b=kRmbGu4ksafIgPEmSJcxdaiPE+j/Fz6YH0DkfgJT4FwaOagLDh/0HXvsQ/z4OHgij5
         3vQfrFPshL8OupoCpaAWn4tALRZ1o1za2z1rz+m2NstD0s0tDbE21CJEbTz7DnC6KVYG
         XB0EkcT7JPzV/iVu5evUKvVdHXr/GduZXhd2U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QIPw547z2r0OY+mpHM9N7HXWYyz2dhvSbn0oO59/Pi5q73O8031+1kFJSMVe+XJa7c
         zanJ/k/bkThrv0TMaKgwkYWb3kFjlwg1ayVjqKuCLqq5PC9xFvimL0jB2Kfuzb87ZQKW
         eRSEK22RO8AXbyz7ThJoWFpKaExlHAblTmoBo=
Received: by 10.42.157.199 with SMTP id e7mr1290552icx.278.1302083922964;
        Wed, 06 Apr 2011 02:58:42 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id c1sm318477ibe.51.2011.04.06.02.58.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2011 02:58:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1301654600-8901-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170958>

Also, describe What changed since v3:
- More language improvements, thanks to Michael.
- Junio's elaborate note clarifies several options.
- One more patch in the series to make similar corrections to
  merge-config.

Thanks for reading.

-- Ram

Ramkumar Ramachandra (4):
  Documentation: Add filter.<driver>.* to config
  Documentation: Add diff.<driver>.* to config
  Documentation: Allow custom diff tools to be specified in 'diff.tool'
  Documentation: Minor language improvements to merge-config

 Documentation/config.txt       |   72 ++++---------------------------
 Documentation/diff-config.txt  |   91 ++++++++++++++++++++++++++++++++++++++++
 Documentation/merge-config.txt |   38 ++++++++--------
 3 files changed, 120 insertions(+), 81 deletions(-)
 create mode 100644 Documentation/diff-config.txt

-- 
1.7.4.rc1.7.g2cf08.dirty
