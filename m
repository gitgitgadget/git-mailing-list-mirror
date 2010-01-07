From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/3] Bringing git-ls-files to porcelain level
Date: Fri,  8 Jan 2010 00:07:53 +0700
Message-ID: <1262884076-12293-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 07 18:09:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSvqz-0003LX-IJ
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 18:08:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403Ab0AGRIw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jan 2010 12:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753396Ab0AGRIv
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 12:08:51 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:53624 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803Ab0AGRIu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 12:08:50 -0500
Received: by yxe26 with SMTP id 26so17848817yxe.4
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 09:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=57uKNWhKttX4D0BqDbrsXR0Kppa/Dtynwxit8bmePpg=;
        b=OqSa6wwV/yXHlwwT6tXnGEDFNQ2nDIY7w7qWLLTuJONH974nGIrd0SchYSSP0VldiT
         NXNvQrJR9JX0/dBLwyk2bA8XG1qW1jwrEQSvT0kbNviPLRApgyo3NgVFr2sJMP8t4VGs
         QVbYWnP4XEVKsfOEYGImsHWTIZ30lEmejWJj0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=G/t3ad02nDveDHM4aRM76rCG3QgsNURgUX7eLyDeCUuDGzQBbvA7tXgqn9qQLsZot3
         eN2Og/MJoUBHu6pOaocJmTC7Q/wrfZjtbEzbIz/18RreSCR+FucMCdtnAxtU2xP8CYJF
         V3TF+GlBwxYTmebXEgNKSgtPj+gbq1nrFuv1s=
Received: by 10.91.164.27 with SMTP id r27mr10838378ago.56.1262884128246;
        Thu, 07 Jan 2010 09:08:48 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.227.183])
        by mx.google.com with ESMTPS id 15sm10221288gxk.4.2010.01.07.09.08.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 Jan 2010 09:08:43 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri,  8 Jan 2010 00:07:57 +0700
X-Mailer: git-send-email 1.6.6.315.g1a406
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136360>

This is a hack, to scratch my itch. These patches add "git ls",
which is equivalent to "git ls-files --max-depth 1|column"

Anyone up for coloring? ;)

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  ls-files: support --max-depth
  ls-files: support -o --max-depth (more of a hack as fill_directory
    should support this)
  Add "ls", which is basically ls-files with user-friendly settings

 builtin-ls-files.c |   72 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 builtin.h          |    1 +
 git.c              |    1 +
 3 files changed, 74 insertions(+), 0 deletions(-)
