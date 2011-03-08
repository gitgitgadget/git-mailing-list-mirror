From: Alexei Sholik <alcosholik@gmail.com>
Subject: [PATCH 0/2] A couple of tweaks in git-for-each-ref.txt
Date: Tue,  8 Mar 2011 15:16:08 +0200
Message-ID: <1299590170-30799-1-git-send-email-alcosholik@gmail.com>
Cc: Alexei Sholik <alcosholik@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 08 14:13:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwwjS-0006qG-T3
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 14:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754850Ab1CHNNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 08:13:41 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34391 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753589Ab1CHNNl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 08:13:41 -0500
Received: by bwz15 with SMTP id 15so4543793bwz.19
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 05:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=Gwbhs6HVFnl4iQF18Rp8pP8TGGqM3ir5g2rebEo8Oc4=;
        b=jc6+r1YR6YLh1XATvJYj8m6v2CX0aepmv0QQQEY98/TVrsNeooMp8SQiscpvB4A7qg
         a4VIZUVfJkRSsLFXermfad7G6CjiCa9fuVJBXdVtNlWHVbwYirU71nRPLqsXTd3XlaTG
         fab93qdGbZXcoOAitQilJXsM+xBV32t+SLhDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=xs/YyvzmRU1pFBW023Cwix6THOF6tBhQ+6vqgu8XtGznwaLpr/7AeJt8vNcTRZpbBQ
         hKEnC9Hdx7Ts5WxgtefLNNDArBtEPO9kVtbQ/WvNUvY/r2fcpv5T5EBjx8CYkfR2pfKP
         38B0BezzY4YtqpOKXhbjX5C89pUc0o2b5kfp8=
Received: by 10.204.20.66 with SMTP id e2mr1341721bkb.141.1299590019692;
        Tue, 08 Mar 2011 05:13:39 -0800 (PST)
Received: from localhost.localdomain ([193.254.233.10])
        by mx.google.com with ESMTPS id u23sm495968bkw.9.2011.03.08.05.13.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Mar 2011 05:13:39 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168660>

I was reading the man page on git-for-each-ref and noticed a few bugs and missing Authors and Documentation sections.

Sorry if I wasn't supposed to add them. I don't know if such editing should be done exclusively by the authors themselves or is it OK for others to do so. Just thought someone overlooked missing sections in the docs for this command.

Alexei Sholik (2):
  Documentation: remove redundant colons in git-for-each-ref.txt
  Add Author and Documentation sections to git-for-each-ref.txt

 Documentation/git-for-each-ref.txt |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

--
1.7.2.3
