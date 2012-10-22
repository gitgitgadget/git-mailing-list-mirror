From: Mat Arge <argemat1010@gmail.com>
Subject: signing commits with openssl/PKCS#11
Date: Mon, 22 Oct 2012 15:38:04 +0200
Message-ID: <1392235.RizYqAYdkC@off17>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 22 15:38:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQICz-0000KN-4x
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 15:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754385Ab2JVNiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2012 09:38:09 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:33020 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754369Ab2JVNiI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2012 09:38:08 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so972317eek.19
        for <git@vger.kernel.org>; Mon, 22 Oct 2012 06:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding:content-type;
        bh=RnRY1OZfjRYtiGbMl7JQzM4bREEPgql51wj/HeQoCUQ=;
        b=ZyOzftB2y8SUkLyFkUrerqxdllLiqIgNNcwLwMN6+57WHwlMD6t65EcvL0SRUDGIYX
         fCjrKx9IuuwKrnpUYp7c5UuZ8ptrmbKfbQWS0R+BgbCQ/CrWPrvb6u807IfuiE9wAJtg
         rzbXMcnPUZvQcLuzhfMkw6B7sicUFWzopVuyaJ4SQ7JSlAIWaoqbBCK1YzQFwDb+Y/77
         hzwybrMNBxUwM3OafpI+CKUlVcSLhir4qMG75L+y4MVlMu8k9pSdUNKNn5ZFvbe2z1eH
         C5zJp2YCTRsD3YGpCokpuXIPGoeTIdz7vecZVjd5mnr7l1J0q4u9vktP+CrZpxtOLOVA
         CRTQ==
Received: by 10.14.179.6 with SMTP id g6mr12006609eem.46.1350913087089;
        Mon, 22 Oct 2012 06:38:07 -0700 (PDT)
Received: from off17.localnet ([188.118.223.98])
        by mx.google.com with ESMTPS id e7sm1074740eep.1.2012.10.22.06.38.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 22 Oct 2012 06:38:06 -0700 (PDT)
User-Agent: KMail/4.9.2 (Linux/3.4.11-2.16-default; KDE/4.9.2; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208185>

Hy!

I would like to sign each commit with a X.509 certificate and a private key 
stored on a PKCS#11 token. I assume that that should be possible somehow using 
a hook which calls openssl. Does somebody know a working implementation of 
this?

cheers
Mat
