From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH] Fix daemon documentation: '--enable-service' is not valid
Date: Wed, 24 Jan 2007 14:47:49 +0100
Message-ID: <45B76385.5050009@innova-card.com>
Reply-To: Franck <vagabon.xyz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 24 14:45:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9iRd-0001Wr-KZ
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 14:45:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbXAXNpf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 08:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbXAXNpe
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 08:45:34 -0500
Received: from hu-out-0506.google.com ([72.14.214.228]:25247 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbXAXNpd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 08:45:33 -0500
Received: by hu-out-0506.google.com with SMTP id 36so156833hui
        for <git@vger.kernel.org>; Wed, 24 Jan 2007 05:45:31 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:subject:content-type:content-transfer-encoding:from;
        b=MayRg7KjTeMMlMxAVYCe/U6x9p+VRq/kyuL6Y7s9Pf+WKCLJZ3S9Ien7qjkNiay887/4PFJCOGGkkZmM9K8/zYZi5UsaQXy801a1bR67bHBGYMP0AoG19xxIrEyTZK12ZTRZn1i6B6QWICcdeT6vcBqJV+UJSs8fwsIlIVoy7JQ=
Received: by 10.48.240.10 with SMTP id n10mr2874827nfh.1169646329535;
        Wed, 24 Jan 2007 05:45:29 -0800 (PST)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id p72sm6488151nfc.2007.01.24.05.45.28;
        Wed, 24 Jan 2007 05:45:29 -0800 (PST)
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37636>

From: Franck Bui-Huu <fbuihuu@gmail.com>

To enable/disable a service we must use '--enable/--disable' options.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 Documentation/git-daemon.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 741f2c6..6e4cded 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -109,7 +109,7 @@ Giving these options is an error when used with `--inetd`; use
 the facility of inet daemon to achieve the same before spawning
 `git-daemon` if needed.
 
---enable-service, --disable-service::
+--enable, --disable::
 	Enable/disable the service site-wide per default.  Note
 	that a service disabled site-wide can still be enabled
 	per repository if it is marked overridable and the
-- 
1.4.4.3.ge6d4
