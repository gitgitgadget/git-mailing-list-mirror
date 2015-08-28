From: larsxschneider@gmail.com
Subject: [PATCH v9] git-p4: Obey core.ignorecase when using P4 client specs
Date: Fri, 28 Aug 2015 14:00:33 +0200
Message-ID: <1440763234-60172-1-git-send-email-larsxschneider@gmail.com>
Cc: git@vger.kernel.org, remi.galan-alfonso@ensimag.grenoble-inp.fr,
	Lars Schneider <larsxschneider@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 28 14:00:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVIKp-0004H9-NH
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 14:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbbH1MAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 08:00:38 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37562 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844AbbH1MAh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 08:00:37 -0400
Received: by wicfv10 with SMTP id fv10so9892834wic.0
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 05:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=cpsDpl/FqhHbxv7leCL2Sxc0Lhd63RyDmcG1D5mfTsY=;
        b=q0R8b9vhzrVT+/rK0vxM1r1D6G5QurroeIrU/woPxws8GkZRLcEbuWOHYkKUcNYI1g
         YxvJUrmDzrjV0OfDXo4+vrYhZ+kqapPVXAuQv1Xn4PSh2qFW5ATMajwlSS4MD2fh+M1L
         Y1Xsn8DRp+9W4VPBjGBm4HhdRAW0x+1wbmHlALDv5i9AYUdcYJHSsOtQDvC9wbEuPmVg
         e/u3qjeslttoh7VdWCBPThltLPQDy9qoj4JxgTQDTfIG+6ZNlaXhDTPsgcUeav3bF6F/
         DYpRv2sH2JbubjIvvYNEOPoKdUFPwbuLeq8uuXvmlUOdVDZ5uxnmo0fIcOV7BiD4rM/E
         Xb+g==
X-Received: by 10.180.74.148 with SMTP id t20mr4174049wiv.31.1440763236619;
        Fri, 28 Aug 2015 05:00:36 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id lg6sm7745828wjb.10.2015.08.28.05.00.35
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Aug 2015 05:00:35 -0700 (PDT)
X-Mailer: git-send-email 1.9.5 (Apple Git-50.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276718>

From: Lars Schneider <larsxschneider@gmail.com>

I fixed a commit message typo discover by Remi in v8.

Thanks,
Lars

Lars Schneider (1):
  git-p4: Obey core.ignorecase when using P4 client specs

 git-p4.py                         |   7 ++
 t/t9821-git-p4-path-variations.sh | 200 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 207 insertions(+)
 create mode 100755 t/t9821-git-p4-path-variations.sh

--
1.9.5 (Apple Git-50.3)
