From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/2] nd/slim-index-pack-memory-usage update
Date: Sat, 18 Apr 2015 17:47:03 +0700
Message-ID: <1429354025-24659-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 12:47:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjQHL-0007cS-DD
	for gcvg-git-2@plane.gmane.org; Sat, 18 Apr 2015 12:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173AbbDRKrK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Apr 2015 06:47:10 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33673 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163AbbDRKrH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2015 06:47:07 -0400
Received: by paboj16 with SMTP id oj16so152684644pab.0
        for <git@vger.kernel.org>; Sat, 18 Apr 2015 03:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=Qq4nUXwiMrd7+pBtA8nYXH6MRenluX5iwfbJLKSAPkw=;
        b=q3nhHY+4IpwDI69QuVSQ/cDo2k2VujFxEZa6xfMrfM+/OOFDDKEWLefJrQ8jgWRIDP
         sTjpW4bE9KP7Fmru3tV77k/mT/3Xuyy/vrs0WGuDG9KuFmsFl28uOhCzFnX/4wJx7I6/
         TGc/I3/Nevl7OiKZwxJYV3tbLBOoNQdr1ijd8r4sexYewuG8dW1yQQ4ZBE5n08B9/aiP
         VoNEWMT4cTYXINus4BUlaAh4UwnctFGo92p41iPkHG7Crdh8oWGFd4oO3EEbpvmu8iMz
         ny4cE4w1PHLaecFgF/49tLgSbgto0ZASdg3W3o3/9H4ySblLtplTnyK1U3jFeqPxqxGz
         CYRA==
X-Received: by 10.70.130.43 with SMTP id ob11mr12782224pdb.35.1429354027261;
        Sat, 18 Apr 2015 03:47:07 -0700 (PDT)
Received: from lanh ([115.73.194.246])
        by mx.google.com with ESMTPSA id hz13sm12686342pab.6.2015.04.18.03.47.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Apr 2015 03:47:06 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 18 Apr 2015 17:47:06 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267413>

The only change is in the commit message of 2/2 [1]. Sorry it took too
long, I completely forgot about it.

[1] http://article.gmane.org/gmane.comp.version-control.git/264544

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  index-pack: reduce object_entry size to save memory
  index-pack: kill union delta_base to save memory

 builtin/index-pack.c | 290 +++++++++++++++++++++++++++++++------------=
--------
 1 file changed, 179 insertions(+), 111 deletions(-)

--=20
2.3.0.rc1.137.g477eb31
