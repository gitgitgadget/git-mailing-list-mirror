From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/4] remote-helpers: general fixes
Date: Wed, 28 Nov 2012 02:01:31 +0100
Message-ID: <1354064495-23171-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 02:02:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdW2S-0001gR-AM
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 02:02:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754907Ab2K1BBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 20:01:53 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54402 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263Ab2K1BBw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 20:01:52 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so5441611bkw.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 17:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=xle/u/J00llhWBgSwk5nZk7lxSqEi5XJQ91SHEi7pfc=;
        b=SppMqTPF6Y8WCdLzNnpq2EPg5wWuamxhS6ooUWSTTUsbHiPB2anNpFZooN7cdZpS5I
         SCu3+6UxsQ3fjKlMwLKzZvKhmmoWg1z7iIJFhYPutj/g2M5Gv0kaQyoDxiqMClqW511w
         j+VC6/nl4tziE/CY7EOaO1J1o84ockLFteAbQxYI+dj2XEKsxXXFar9qFagLVaPp1zNl
         WYqV70RU8iYHjEU/o+16Yvgwlel4TP5X2bPE9ICw0IIdx+Cf7jE6pKmWvL+dGvCFXduX
         gN5EX3Fk8M0ebbN9pV/0tQG4sKxoUVlZgEGrWTKkdNUwfGu/VkD2phNIIBHmmj8qc52d
         85Rw==
Received: by 10.204.5.141 with SMTP id 13mr5076337bkv.35.1354064511414;
        Tue, 27 Nov 2012 17:01:51 -0800 (PST)
Received: from localhost (ip-109-43-0-26.web.vodafone.de. [109.43.0.26])
        by mx.google.com with ESMTPS id u3sm11484614bkw.9.2012.11.27.17.01.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Nov 2012 17:01:50 -0800 (PST)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210647>

Hi,

These are general fixes, some for old versions of bazaar, mercurial, and
python. Some of these have already been sent, but here they go alone so they
are not missed.

The bazaar fixes are on top of the series v3 which is still not in 'pu'.

Felipe Contreras (4):
  remote-hg: fix for files with spaces
  remote-hg: fix for older versions of python
  remote-bzr: add support for older versions of bzr
  remote-bzr: detect local repositories

 contrib/remote-helpers/git-remote-bzr | 54 +++++++++++++++++++++--------------
 contrib/remote-helpers/git-remote-hg  | 14 +++++----
 2 files changed, 42 insertions(+), 26 deletions(-)

-- 
1.8.0
