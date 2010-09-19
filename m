From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/2] en/object-list-with-pathspec v5
Date: Mon, 20 Sep 2010 09:24:27 +1000
Message-ID: <1284938669-16753-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 01:24:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxTFV-0008Ly-55
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 01:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754336Ab0ISXYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Sep 2010 19:24:38 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35469 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753533Ab0ISXYh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 19:24:37 -0400
Received: by pvg2 with SMTP id 2so1010616pvg.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 16:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=HQTVztZAijUL4WFWJ8QFDsJ+eMxc5BCi+R5hKfLexqw=;
        b=AXtcVB1ck4IPYrzQ5DGqqp7sZe//1TQR3tChClwo2XQv+Gflbv2w/6RKuSL6f5OjBw
         kHwPWtScBAkHoCgRxy2S/nv8uLVYiIPOec0ky2HEaJwafOE/qcL60XC7AE1qcCjRGK12
         NDKNmBdA4P6x6G0qAegwFU/TwZk2wiGCB6T3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=HGoiOl9/R9NOCgHEXUAhMwAEhHKs6EXsXBYmPL3VmBWWjuLkxHwgr7D3feFLvSaZPF
         0Hx8Dz7zFh18AHSH7ctHApOJ0/BcbupQ5yVUAhyKB5vXigsc3OS7f2uKAykIlTdhWnjU
         tmWReLi8bmKThDHy7DbJCimQuF4QHVr5JL2BM=
Received: by 10.142.48.17 with SMTP id v17mr6935185wfv.233.1284938677343;
        Sun, 19 Sep 2010 16:24:37 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id d10sm5595605wfe.10.2010.09.19.16.24.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Sep 2010 16:24:36 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon, 20 Sep 2010 09:24:31 +1000
X-Mailer: git-send-email 1.7.1.rc1.70.g788ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156528>

Just a rebase version of en/object-list-with-pathspec on top of

http://mid.gmane.org/1284938514-16663-1-git-send-email-pclouds@gmail.com

Elijah Newren (2):
  Make rev-list --objects work together with pathspecs
  Add testcases showing how pathspecs are handled with rev-list
    --objects

 list-objects.c           |   23 ++++++++++++++++++++
 revision.c               |    8 +++++-
 revision.h               |    3 +-
 t/t6000-rev-list-misc.sh |   51 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 82 insertions(+), 3 deletions(-)
 create mode 100755 t/t6000-rev-list-misc.sh
