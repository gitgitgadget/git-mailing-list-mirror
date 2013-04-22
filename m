From: Barbu Paul - Gheorghe <barbu.paul.gheorghe@gmail.com>
Subject: [PATCH] git-imap-send.txt: remove the use of sslverify=false
Date: Mon, 22 Apr 2013 22:26:32 +0300
Message-ID: <51758EE8.7030800@gmail.com>
References: <20130420140802.GC29454@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 22 21:26:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMNs-0007R0-QX
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 21:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760Ab3DVT0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 15:26:36 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36158 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754675Ab3DVT0f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 15:26:35 -0400
Received: by mail-wi0-f179.google.com with SMTP id l13so5022079wie.0
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 12:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=q2YwxIJp7kC3QLNCeG40mkrikO9dOzF53iWwqFF2MRo=;
        b=CC6hqDDlMAAQCPpJ6GgeN/3lusiJXzSPfDTIs92gopQfmlsDatUBgP8Dx9tSohvBiR
         e24mtpojqd5XApaJHiGhWEXjq3KfOP77wc4gWz3fud0O4asu8gVMqkfQARoA3tDcdREl
         aExU5MxBzj2irS900d/qjFFPLwaR0VBNf3+1CeVOmrJh0yvY6HueTyzQnYhSwJvHRQso
         eGm0wSOza9HwwzUs4XMuYyH2IweXU5LnL3ma3VNUp8+X/vN3geEIP8IeqInYHca6SUDk
         zXga6px2Zuujc0PbKDhInBc5oRHyjXtAon5pI+omSM4R/DdIGk0WJCjHQumPmGKGypm+
         /bcQ==
X-Received: by 10.194.177.225 with SMTP id ct1mr16900121wjc.16.1366658794604;
        Mon, 22 Apr 2013 12:26:34 -0700 (PDT)
Received: from [192.168.16.100] (5-15-249-103.residential.rdsnet.ro. [5.15.249.103])
        by mx.google.com with ESMTPS id ch6sm42654104eeb.17.2013.04.22.12.26.33
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 22 Apr 2013 12:26:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130403 Thunderbird/17.0.5
In-Reply-To: <20130420140802.GC29454@ruderich.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222047>

Since SSL provides no protection if the certificates aren't verified it's
better not to include sslverify=false in the examples.
Also in the post 1.8.2.1 era git is able to properly verify the validity of a
certificate as well it's origin.

Signed-off-by: Barbu Paul - Gheorghe <barbu.paul.gheorghe@gmail.com>
---
 Documentation/git-imap-send.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 875d283..0d72977 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -108,7 +108,6 @@ Using direct mode with SSL:
     user = bob
     pass = p4ssw0rd
     port = 123
-    sslverify = false
 ..........................
  @@ -123,7 +122,6 @@ to specify your account settings:
 	host = imaps://imap.gmail.com
 	user = user@gmail.com
 	port = 993
-	sslverify = false
 ---------
  You might need to instead use: folder = "[Google Mail]/Drafts" if you get an error
-- 
Barbu Paul - Gheorghe
Common sense is not so common - Voltaire
Visit My GitHub profile to see my open-source projects - https://github.com/paullik
