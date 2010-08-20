From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 0/4] fmt-merge-msg improvements
Date: Fri, 20 Aug 2010 22:24:48 +0530
Message-ID: <1282323292-11412-1-git-send-email-artagnon@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 20 18:57:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmUtz-0004QD-Mb
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 18:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158Ab0HTQ5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 12:57:06 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52010 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397Ab0HTQ5E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 12:57:04 -0400
Received: by yxg6 with SMTP id 6so1324303yxg.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 09:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=bqdU0s8gmSoHvi1s3rS39DoA9Vq6UzRYgowwtZN3210=;
        b=AmvZkPqoFaYiLPxmLjVXuqc43Cx8CB3ccOi122Y+JnEkVF2kzvlOiMGa08YZZH8/EQ
         hQtU8sygZNlUZPEZsO/JHEioaGgbmOU+Cer5fuXz5cHsCvDcBAosxhJ3olnUUu2eC4ki
         /HAw2kdIqd3nDTlKCN6z8timYj30pvpabx7Kc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=MvKM2OOnOvHIhp1j0bJaVmkKpa8Qeezpv+Gi2GDlpPS+K4M1+7Jv9yW56/m6bMoqC6
         sK60tIeeeucttrzicCil20RJvoOi2HpQUSgsx57hcx99Dhc46eWXF3d+Hz9yjc4FhURP
         SheEwDb+cdddRO7m1RoEZGOvw8kY0ANeOS7nw=
Received: by 10.100.171.16 with SMTP id t16mr1937470ane.83.1282323423670;
        Fri, 20 Aug 2010 09:57:03 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id e8sm2761091ibb.20.2010.08.20.09.56.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 09:57:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.408.g7357
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154053>

What changed since last time: Brought `--no-log` option back.

Ramkumar Ramachandra (4):
  fmt-merge-msg: Make the number of log entries in commit message
    configurable
  fmt-merge-msg: Update command line options to sync with config
    options
  fmt-merge-msg: Remove deprecated --summary option
  fmt-merge-msg: Update fmt-merge-msg and merge-config documentation

 Documentation/git-fmt-merge-msg.txt |   24 +++++++------------
 Documentation/merge-config.txt      |    8 +++++-
 builtin/fmt-merge-msg.c             |   42 ++++++++++++++++------------------
 3 files changed, 35 insertions(+), 39 deletions(-)

-- 
1.7.2.2.408.g7357
