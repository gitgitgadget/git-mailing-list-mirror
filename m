From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] completion: backwards compatibility fix
Date: Sat, 19 May 2012 04:41:33 +0200
Message-ID: <1337395295-29162-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Carsten Mattner <carstenmattner@googlemail.com>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 19 04:42:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVZcG-0000K4-A0
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 04:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030428Ab2ESClu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 22:41:50 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:46275 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759075Ab2ESClk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 22:41:40 -0400
Received: by weyu7 with SMTP id u7so2152811wey.19
        for <git@vger.kernel.org>; Fri, 18 May 2012 19:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=aRitPu633MYva1NICHPghxa2lrBO8XVOIqwnEeayfag=;
        b=pB/CNTFIcZPILQ7dJpAo49+o9dY9G2ygQhR8SKYLD0otgkfkH5HhSASdWTBZ+LmF5x
         TpVnPo1M1Y4pLcF3DjaoXjoImyFLyD1rhvqmOiHAjWRmwDodyOX0PblKbozkYNTVyglz
         5U/OAbdnjtK3doqB4tAOZA9wVH0nBevb4s2qrl05Yrh8B3vXGBNaqSK95iR8vrwpanAZ
         b7/J8Lz0+L6Tzj2rbuQoyTEzDIRFxjs9JinsnGd0ouYRtWc9sZLNhQGEU4NrI8ROrIIv
         81im04h3QDAuHWIujBh1X93uA46zlTFTw8YULQ3JhzWPRh9UHtnWGyzQKMTapMT7jatF
         Hs7w==
Received: by 10.181.11.137 with SMTP id ei9mr6705864wid.21.1337395298595;
        Fri, 18 May 2012 19:41:38 -0700 (PDT)
Received: from localhost (ip-109-43-0-59.web.vodafone.de. [109.43.0.59])
        by mx.google.com with ESMTPS id du4sm8606000wib.10.2012.05.18.19.41.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 May 2012 19:41:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198006>

Hi,

These two patches are meant to fix the backwards compatibility of _git, and
_gitk. This also helps my zsh's wrapper.

Felipe Contreras (2):
  completion: rename _git and _gitk
  completion: add support for backwards compatibilit

 contrib/completion/git-completion.bash |   22 +++++++++++++++++-----
 t/t9902-completion.sh                  |    2 +-
 2 files changed, 18 insertions(+), 6 deletions(-)

-- 
1.7.10.2
