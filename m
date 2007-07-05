From: Alecs King <alecsk@gmail.com>
Subject: [PATCH] fix remote.origin.url in tutorial.txt
Date: Fri, 6 Jul 2007 00:21:16 +0800
Message-ID: <20070705162116.GA5337@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 05 18:21:34 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6U5G-0005ST-6P
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 18:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758708AbXGEQVa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 12:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758631AbXGEQV3
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 12:21:29 -0400
Received: from nz-out-0506.google.com ([64.233.162.228]:26135 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758448AbXGEQV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 12:21:28 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1899435nze
        for <git@vger.kernel.org>; Thu, 05 Jul 2007 09:21:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=hNqlfD+bTHgJ6acAQiP5lqgtytu5zhsGZRraMzV2wrt5wmtWelwwV6T+9xxrjK9apGl5b2M1aAnxrSg3WSg1Ok8V/e0WIctnfTzGerTeS07+Hc3Prq4oWG9DePXo3yaaGknTkQxKZVAm44GBSV3qdjHpT6eOG/xjenybM8E07Aw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=esBob+VnrImZw3eoprI0sfwwmUJWKgnDbKMjqvwXlU2FmsMksTNry+irB9Ab5a45EpfZyiyxEru+9Q0oWTySCCVeK2ViMIMWnctfTDim0p8yonpsk1UGFWM3tnvmH6HCO6/eEqPZpAWImDfAD0VF1Ti6aLfeS8xkaMmUU1N3S4o=
Received: by 10.115.17.1 with SMTP id u1mr8294246wai.1183652486331;
        Thu, 05 Jul 2007 09:21:26 -0700 (PDT)
Received: from localhost ( [210.77.2.82])
        by mx.google.com with ESMTP id v37sm20184385wah.2007.07.05.09.21.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 Jul 2007 09:21:24 -0700 (PDT)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51682>

Bob cloned from Alice.
The origin url is actually Alice's repo.

Signed-off-by: Alecs King <alecsk@gmail.com>
---
 Documentation/tutorial.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 118ff72..53403c6 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -354,7 +354,7 @@ used for pulls:
 
 -------------------------------------
 $ git config --get remote.origin.url
-/home/bob/myrepo
+/home/alice/project
 -------------------------------------
 
 (The complete configuration created by git-clone is visible using
-- 
1.5.3.rc0.107.g93d7e


-- 
Alecs King
