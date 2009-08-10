From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Optimize git-favicon.png
Date: Mon, 10 Aug 2009 13:00:51 +0200
Message-ID: <20090810110002.4448.88448.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 13:01:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaScj-0001aJ-SC
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 13:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840AbZHJLA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 07:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753584AbZHJLA5
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 07:00:57 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:60014 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbZHJLA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 07:00:56 -0400
Received: by fg-out-1718.google.com with SMTP id e21so712098fga.17
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 04:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:date
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=1ZWz4aFb72fqMcbMvRCjVS5lwFzQzxRWGd4ktupeKmo=;
        b=oZQ/FbOe04PcurK7J53i1Y4df8F+ElNk/4jSKfVwkFYkXXk8S6v6pul1UtACRVZTk2
         5Zg2hYKX8U3Scy9Yrobn8p5qiGh/rONB1vdpGMFq3pSy/6SqLDakbLVMbG/CfjRoPqAu
         ZFTvSJCl/LKjVXSsREL01jZPr2dsQdof3gRdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=IkjV/oGDB+toTNRHkIu/8xanaW6eC23Cv09U00ZmCK9xAh52aZLafIkd+xebdgIxzW
         qE2vWAWllkwljeT0+QNldcZk2sZshzkKITanIrN7MvPbYgtKRImTN0YyMSBCQkR+T5KH
         GG9owQ6BZ2ejcoebcv74cY6bLBjadpZXszx8w=
Received: by 10.86.50.4 with SMTP id x4mr2985185fgx.76.1249902056997;
        Mon, 10 Aug 2009 04:00:56 -0700 (PDT)
Received: from localhost.localdomain (abvr219.neoplus.adsl.tpnet.pl [83.8.215.219])
        by mx.google.com with ESMTPS id 12sm10121350fgg.1.2009.08.10.04.00.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Aug 2009 04:00:56 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n7AB0prm004494
	for <git@vger.kernel.org>; Mon, 10 Aug 2009 13:00:53 +0200
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125432>

Reduce size of git-favicon.png using Smush.it(TM) online PNG optimizer
  http://developer.yahoo.com/yslow/smushit/
from 164 bytes to 118 bytes (28% reduction).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Smush.it(TM) could not improve git-logo.png

 gitweb/git-favicon.png |  Bin 164 -> 118 bytes
 1 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/gitweb/git-favicon.png b/gitweb/git-favicon.png
index de637c0608090162a6ce6b51d5f9bfe512cf8bcf..1f8bfa70d674b1073a40ea66ba8c745dfdbaa59d 100644
GIT binary patch
delta 64
zcmZ3&ST@1NO4ZZFF@)oKas(?2&y5Z?Rz5Y3MuF&EM%rD8Sy?F(EeyqhTNxQ99#M`y
TnP0Y$0SG)@{an^LB{Ts5d%zSA

delta 110
zcmXS0!Z^VugR{URvY3H^TNs2H8D`CqU|?Xd^K@|xsbFM1xKYr-L4@_d*Jr0+dMpU|
zSh|pTqEw4`hlFuidz*uTz>4DC^A21PSh4+E+}|Dh9hQ}@lhS2sls~7={piN!fAT<+
O7(8A5T-G@yGywqcawy0E
