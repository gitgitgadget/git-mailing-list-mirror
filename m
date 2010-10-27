From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/34] repo setup test cases
Date: Wed, 27 Oct 2010 21:49:03 +0700
Message-ID: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:49:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7K9-00064J-1t
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760808Ab0J0Otn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:49:43 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61352 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760699Ab0J0Otm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:49:42 -0400
Received: by yxk8 with SMTP id 8so64577yxk.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=byb9LR2rYpdS3g49PATWVBDiNCpSo1g5j+sG/BlnWDY=;
        b=QSLaaozfadrvZJiKW9bZYXrNWfJFvZKgXU5XfK35hjRUZLU1/W3whUFqM9NVqz/TCD
         ETOO8tFSQsxxxVC/lgwUeRnDJ6Zp9YTLYs07UlM5pPsuvODK2/IHA6PVlV50MeU01PHA
         yOzuckX9IzQPeisHt7/GXG6QkfCOeXp3B0Om8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=aQyMESHVWQ+a4SY3RWr4j3TgIMiUdSYwuZ/2jH0lBBI8kamjpvyPksAjNku6VLAcrr
         DI7Pesf/ECqDGzbPJXIRtX0Rw8zIskyvyrttRziguAYa4uk4JSXmBI+4dXeAwwf4bnST
         RRPV5ieEQGNeVLQKJNedXnu36ev7BN+lE/4LI=
Received: by 10.101.162.10 with SMTP id p10mr7935244ano.241.1288190981886;
        Wed, 27 Oct 2010 07:49:41 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id 25sm11919994anq.8.2010.10.27.07.49.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:49:40 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:49:38 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160041>

A complete series after the WIP [1]. The rules are bent a bit, see 2/34=
=2E

178/376 test cases fail, but mostly because GIT_DIR=3D.git-file is
not supported. I'll send a bandage series shortly that will bring the
number of failed test cases to 20.

[1] 1287922310-14678-1-git-send-email-pclouds@gmail.com

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (34):
  builtins: print setup info if repo is found
  Add t1510 and basic rules that run repo setup
  t1510: setup case #0
  t1510: setup case #1
  t1510: setup case #2
  t1510: setup case #3
  t1510: setup case #4
  t1510: setup case #5
  t1510: setup case #6
  t1510: setup case #7
  t1510: setup case #8
  t1510: setup case #9
  t1510: setup case #10
  t1510: setup case #11
  t1510: setup case #12
  t1510: setup case #13
  t1510: setup case #14
  t1510: setup case #15
  t1510: setup case #16
  t1510: setup case #17
  t1510: setup case #18
  t1510: setup case #19
  t1510: setup case #20
  t1510: setup case #21
  t1510: setup case #22
  t1510: setup case #23
  t1510: setup case #24
  t1510: setup case #25
  t1510: setup case #26
  t1510: setup case #27
  t1510: setup case #28
  t1510: setup case #29
  t1510: setup case #30
  t1510: setup case #31

 cache.h               |    1 +
 git.c                 |   36 +
 t/t1510-repo-setup.sh | 4515 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 trace.c               |   11 +
 4 files changed, 4563 insertions(+), 0 deletions(-)
 create mode 100755 t/t1510-repo-setup.sh
