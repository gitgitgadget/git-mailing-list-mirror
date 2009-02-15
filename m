From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v2 0/3] send-email
Date: Sat, 14 Feb 2009 23:32:12 -0500
Message-ID: <1234672335-54321-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 05:35:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYYj8-0007tT-DX
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 05:35:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670AbZBOEcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 23:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752551AbZBOEcT
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 23:32:19 -0500
Received: from an-out-0708.google.com ([209.85.132.243]:29015 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510AbZBOEcS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 23:32:18 -0500
Received: by an-out-0708.google.com with SMTP id c2so873005anc.1
        for <git@vger.kernel.org>; Sat, 14 Feb 2009 20:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=cKiMlC6PVRFNBTJDzC/FO0n63SCLP4+M3+PKuSP7p0U=;
        b=MIdOnZwdPuDXEAwlZMfYZp6q4lX6+HpHhg9/PiXwwsXbWTJQZ7hK/ftIwpxCCCKg3T
         GvSzNioi2DEpqf8NK4wlPaa4IwXg0QvUijhtRpE73nNtGX3yXe0dkVM3Gp+3v6aUfBBZ
         A6m3p1wFwXB/pG345nTWJmjYwcDg2Lc+GgZVE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=FigBNy6xMCkfyRaK3Y8QbUUxurE8HO+HF9r6YTbrHAAOR4Ctk/GpzlfcnbrQa3PHaR
         h6FoPgCuDWaduCopQsil+7toqcL8+wC3UpfmW7sF1iUd7HcmVHJnJFE0xKB+PUi/fSWs
         7YW+S+ooCBLmtDg0VbGtiBU48h/fCG6gMFQ70=
Received: by 10.100.14.2 with SMTP id 2mr1869379ann.79.1234672337571;
        Sat, 14 Feb 2009 20:32:17 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id b37sm4857025ana.37.2009.02.14.20.32.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Feb 2009 20:32:17 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.250.g3b7b7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109956>

Junio,

There have been several messages on my send-email patches. I
incorporated your feedback and Thomas's contributions and re-rolled the
series.

Thomas, thank you for helping out on this series.

More information in each patch.

j.

Jay Soffian (3):
  send-email: allow send-email to run outside a repo
  send-email: handle multiple Cc addresses when reading mbox message
  send-email: --suppress-cc improvements

 Documentation/git-send-email.txt |   26 ++++--
 git-send-email.perl              |  183 +++++++++++++++++++++---------------
 t/t9001-send-email.sh            |  192 +++++++++++++++++++++++++++++++++-----
 3 files changed, 294 insertions(+), 107 deletions(-)
