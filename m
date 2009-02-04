From: Stefan Naewe <stefan.naewe@googlemail.com>
Subject: [PATCH v2] urls.txt: document optional port specification in git URLS
Date: Wed,  4 Feb 2009 21:49:35 +0100
Message-ID: <1233780575-20125-1-git-send-email-stefan.naewe+git@gmail.com>
References: <7vr62et6p4.fsf@gitster.siamese.dyndns.org>
Cc: gitster@pobox.com, Stefan Naewe <stefan.naewe+git@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 21:52:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUoix-0006jh-0V
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 21:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758636AbZBDUtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 15:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758630AbZBDUtl
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 15:49:41 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:35887 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758226AbZBDUtk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 15:49:40 -0500
Received: by ewy14 with SMTP id 14so3887155ewy.13
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 12:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Bd67VgKeycez+CBYg0YsFxnRAcTZSOPtsHH9u6nHtXc=;
        b=Fv7tzbKaoafrcjKk2ZSkIRrDwrEDi2MwFrl0nIgAI5TWcwI0GSjj7ObwM/YdDyBMlE
         rJq4lGfRnwEWkD1uMP+83+KSOCLLF+SzeSlP/Kp4z4WLuEGLYiJTG1S6mfTu8HphQCJE
         39tyHoC8pQa1rJ8eFMbIbTCSljtrWV6fCVCEw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RupXs7X+ACYu4M5I0YDjY+4vM5CGPlshRUQhV/QrvH0EVzjtkXOLH89bJnKCBaRUKb
         E4gDjpT8ECn62fTfaxfOk1auVCopMdrQRQEq6CLvez8rgXTmmqTK6n2NERJMgrm7B/5L
         +o8c5NETqZtKjM7Dke7sVIc+EphSEFD6IJN14=
Received: by 10.210.18.8 with SMTP id 8mr1605842ebr.13.1233780578805;
        Wed, 04 Feb 2009 12:49:38 -0800 (PST)
Received: from localhost.localdomain (dyndsl-095-033-043-081.ewe-ip-backbone.de [95.33.43.81])
        by mx.google.com with ESMTPS id 28sm6192888eyg.45.2009.02.04.12.49.37
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 04 Feb 2009 12:49:38 -0800 (PST)
X-Mailer: git-send-email 1.6.1.2
In-Reply-To: <7vr62et6p4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108431>

Signed-off-by: Stefan Naewe <stefan.naewe+git@gmail.com>
---
 Documentation/urls.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index fa34c67..5355ebc 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -6,10 +6,10 @@ to name the remote repository:
 
 ===============================================================
 - rsync://host.xz/path/to/repo.git/
-- http://host.xz/path/to/repo.git/
-- https://host.xz/path/to/repo.git/
-- git://host.xz/path/to/repo.git/
-- git://host.xz/~user/path/to/repo.git/
+- http://host.xz{startsb}:port{endsb}/path/to/repo.git/
+- https://host.xz{startsb}:port{endsb}/path/to/repo.git/
+- git://host.xz{startsb}:port{endsb}/path/to/repo.git/
+- git://host.xz{startsb}:port{endsb}/~user/path/to/repo.git/
 - ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/path/to/repo.git/
 - ssh://{startsb}user@{endsb}host.xz/path/to/repo.git/
 - ssh://{startsb}user@{endsb}host.xz/~user/path/to/repo.git/
-- 
1.6.1.2
