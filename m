From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [WIP PATCH] Write stubby remote helper for SVN
Date: Mon, 10 May 2010 13:39:33 +0200
Message-ID: <1273491574-31870-1-git-send-email-artagnon@gmail.com>
Cc: srabbelier@gmail.com
To: Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 10 13:38:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBRJY-0001IO-SZ
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 13:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871Ab0EJLiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 07:38:19 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:50392 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754053Ab0EJLiT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 07:38:19 -0400
Received: by ewy20 with SMTP id 20so863231ewy.1
        for <git@vger.kernel.org>; Mon, 10 May 2010 04:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Zm8w5XYlvcacOEajlCBCGn8jB5GrBDtmiZJo8biZsaQ=;
        b=VOXS1fIgEQFGdzuBlUZ94/vTJeHSwsJrFFG0l1jowN7xlvS/hZiphYue4Bg47mzmpx
         lb7NVabzcByUWF34M1djOX1K2tVSA2vO5bahhFeJXbkGgnuIwENAH6VPwWvU0w6g7yDN
         PvTsGrCO1BCikvHKJzfOJAATiqn3l8oZSSaAc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Cp/VJXFs586Al37sp5cNiinlvq9PZwHg/O+qIlo2/aBtYBu/1Z0jupWE4L7d5PxkEz
         FvbU1CcQlTFFYHNbd7i+wFtmZhIJBLBAk8m3H5XxsM6mPtUdE0KsdL972+shlWT4quJT
         xPOLEMETJYNYcVG66D/o7NTwLObGFcjOAULYA=
Received: by 10.213.40.77 with SMTP id j13mr1195248ebe.31.1273491497733;
        Mon, 10 May 2010 04:38:17 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id 14sm2501121ewy.10.2010.05.10.04.38.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 04:38:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146800>

This is a WIP patch based on master, and is part of my GSoC project
git-remote-svn. It is not intended for inclusion- the purpose of the
patch is to get feedback on aspects such as style and overall
design. I plan to put an SVN client, fast-import and fast-export
helpers for SVN inside a directory vcs-svn. Only this file will be in
the root directory.

I've also included a Makefile target git-remote-svn, which should
build just fine, but do nothing except list capabilities.

Ramkumar Ramachandra (1):
  Add skeleton remote helper for SVN

 Makefile     |    6 ++-
 remote-svn.c |  202 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 207 insertions(+), 1 deletions(-)
 create mode 100644 remote-svn.c
