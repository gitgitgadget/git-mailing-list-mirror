From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 (resend) 0/4] git-am foreign patch support
Date: Tue,  2 Jun 2009 01:10:37 +0200
Message-ID: <1243897841-8923-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 01:11:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBGf0-0003zM-KN
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 01:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754047AbZFAXKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 19:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752936AbZFAXKr
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 19:10:47 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:48984 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024AbZFAXKr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 19:10:47 -0400
Received: by bwz22 with SMTP id 22so7792812bwz.37
        for <git@vger.kernel.org>; Mon, 01 Jun 2009 16:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Mlp/H5XbLXT0to8xJ0RhiSKUmvSNxio4t6tfPYAoKXc=;
        b=QQA6te85SL+l1JAsOzQTTD71lo6sCkQ1YnFkpeLdopCqKQW3mDJzbxDVm//ejT0gRK
         0VudM+cQPu9Td6+vLZJkv1ZDdyQcNluhqINpNixF9NlSkNcTLmoeMKtMAvbuBiQruuKN
         bezQ0l14Mp7skB6is/OVv0jePnho8U9XuzzM0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ohGOhhi6QCRCwpuX+WzmZkcPYHwgrQuxU89j+nD7jnQCjoy49nHkmZ1JzC3Z8kZgvn
         w4jOwGcaqipRxWyXj/K2ujL/93h68soHjCXvPGYFA25kXGlW5V5ArkMxaACJkxJG7den
         mLtxpYC69yN2CPoZXiNw/J501Py7Cr0SctOcU=
Received: by 10.204.59.76 with SMTP id k12mr6123520bkh.136.1243897847575;
        Mon, 01 Jun 2009 16:10:47 -0700 (PDT)
Received: from localhost (host-78-13-53-56.cust-adsl.tiscali.it [78.13.53.56])
        by mx.google.com with ESMTPS id f31sm7909894fkf.38.2009.06.01.16.10.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Jun 2009 16:10:46 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.282.g9f93
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120485>

Junio mentioned that he's ready to apply the series cleanly, so here's
a resend rebased on latest 'next' and without any 'bis' patches ;-)

Giuseppe Bilotta (4):
  git-am foreign patch support: introduce patch_format
  git-am foreign patch support: autodetect some patch formats
  git-am foreign patch support: StGIT support
  git-am: refactor 'cleaning up and aborting'

 git-am.sh |  133 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 129 insertions(+), 4 deletions(-)
