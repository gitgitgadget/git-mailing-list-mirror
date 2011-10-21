From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 0/2] submodule patches
Date: Fri, 21 Oct 2011 21:49:34 +0800
Message-ID: <1319204976-5076-1-git-send-email-rctay89@gmail.com>
References: <1317978295-4796-2-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 21 15:49:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHFTo-0004pt-NK
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 15:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754607Ab1JUNto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Oct 2011 09:49:44 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62848 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754493Ab1JUNto (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2011 09:49:44 -0400
Received: by yxl42 with SMTP id 42so1302797yxl.19
        for <git@vger.kernel.org>; Fri, 21 Oct 2011 06:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=EcZomlWuJ9M3UNOGzEzZEUE6h74H5xtYpX9kZSi6spM=;
        b=luY2H9grFpStCXmz22LC7ATr7gSf09jIzdvgsncBAxKT4cQY/HqrGVqj5eBQl4MQh+
         ANdF4p8dxlyor4zjyQiDzLslWbTEt1ENmx34VZCqhxF8jQyvVPF+0r+01NveusbGd1PA
         yfL0gU0hLPfzepAodCt8cioYnxKTRo9tjlgJU=
Received: by 10.68.32.194 with SMTP id l2mr28073173pbi.57.1319204982901;
        Fri, 21 Oct 2011 06:49:42 -0700 (PDT)
Received: from localhost (s80216.pc.nus.edu.sg. [137.132.36.216])
        by mx.google.com with ESMTPS id g1sm18168717pbv.2.2011.10.21.06.49.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Oct 2011 06:49:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.msysgit.0.584.g2cbf
In-Reply-To: <1317978295-4796-2-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184062>

Junio, this goes on top of 'fg/submodule-git-file-git-dir' (particularly
the second patch).

Changed in v2: reworded 2nd paragraph of 2nd patch, as recommended by
Jens.

Tay Ray Chuan (2):
  submodule: whitespace fix
  submodule::module_clone(): silence die() message from module_name()

 git-submodule.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

-- 
1.7.6.msysgit.0.584.g2cbf
