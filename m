From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/2] Two tests for rr/fmt-merge-msg
Date: Fri, 27 Aug 2010 19:44:48 +0530
Message-ID: <1282918490-5190-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 27 16:17:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oozju-0005eO-1V
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 16:17:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753923Ab0H0ORB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 10:17:01 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35443 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753769Ab0H0OQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Aug 2010 10:16:59 -0400
Received: by pzk9 with SMTP id 9so1054291pzk.19
        for <git@vger.kernel.org>; Fri, 27 Aug 2010 07:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=BCw2raLZ2z74g4h8N6WWVriabsUHy8kJUU6skVlRQM8=;
        b=q86HUUDihCFPDFTDVB+yxK9IS1RGBJ0BxdlQu3AnL6J5aVSjzGt5pYggKtlmzGm0Yw
         PEVmpmSbfja3nF4uUytDJAaYiOzmh7o9TnoCOOlMjbFqj07kkbcf5W8i1+RQ/NDBC6I3
         VLR+x+yHDcGV4hl/mPxywtGeLfIYyWnyqzqRg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=A4MstkvVdZakriOPLbwqZwCmHiYsZHcT1X2O+WW5WHouXQ527vkLG1lCWdHAQ/F+L0
         ZMyFuiYl0PN0CanWyi+AwtQO4U2Cl2ueNeA66VqFjQNcDwiMeirg/HjlqnlbaeQc0cXv
         yRW7Jnx8dtw1pBj52wlCM0ZLRzQHLxKQuhtxM=
Received: by 10.114.195.12 with SMTP id s12mr481648waf.204.1282918614955;
        Fri, 27 Aug 2010 07:16:54 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id o17sm525142wal.21.2010.08.27.07.16.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Aug 2010 07:16:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154597>

These tests exercise the feature in rr/fmt-merge-msg.

Ramkumar Ramachandra (2):
  t6200-fmt-merge-msg: Exercise 'merge.log' to configure shortlog
    length
  t6200-fmt-merge-msg: Exercise '--log' to configure shortlog length

 t/t6200-fmt-merge-msg.sh |  111 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 111 insertions(+), 0 deletions(-)

-- 
1.7.2.2.409.gdbb11.dirty
