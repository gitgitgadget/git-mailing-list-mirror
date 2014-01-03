From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH] Documentation/gitmodules: Only 'update' and 'url' are required
Date: Fri,  3 Jan 2014 10:31:22 -0800
Message-ID: <c22c81472bb8b8943d34bdf1ac9ef61f5a489a16.1388773808.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 03 19:31:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vz9Wz-0006Jn-60
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 19:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103AbaACSbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 13:31:33 -0500
Received: from qmta14.westchester.pa.mail.comcast.net ([76.96.59.212]:40554
	"EHLO qmta14.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751139AbaACSbc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jan 2014 13:31:32 -0500
Received: from omta19.westchester.pa.mail.comcast.net ([76.96.62.98])
	by qmta14.westchester.pa.mail.comcast.net with comcast
	id 9WHD1n00627AodY5EWXXFC; Fri, 03 Jan 2014 18:31:31 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta19.westchester.pa.mail.comcast.net with comcast
	id 9WXW1n00K152l3L3fWXWgV; Fri, 03 Jan 2014 18:31:31 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id D4F4FE66FEB; Fri,  3 Jan 2014 10:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1388773889; bh=/rZfK4QtdeWKA3f8/cr7jM2ZmB37UIowe6yhpNOJQew=;
	h=From:To:Cc:Subject:Date;
	b=eZ+ZSKGjUciHda4dsSVAxqt+n011wIHyFDx/xjqm18u+xeM2Svq7BiAisJ0imgSUw
	 gNC6VwJl+4JrqAg8Z9TAkWBVeNP5i6en/VxNjx62jLsAWYn9C/vGJTXTCW29U4AE9L
	 ke94hkPVahJGMXBVILkDA8TuUfoopAThhvz5cZ74=
X-Mailer: git-send-email 1.8.3.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1388773891;
	bh=q2hk1BvVjW0aOSo+E9e/R7QmHbhN69t01vtEi0DRvJM=;
	h=Received:Received:Received:From:To:Subject:Date:Message-Id;
	b=E+IidmKiuQgT8EPvLFrB82wzWnxMmmSw4cbFWKoMZsL0QyUiWXjprsONw7AnCU5QE
	 4EzS3WOcuTD+PKnUw6kOgDThLb7Wii3NuiZr+fUQtZfrUfMQS4tQWRAppUcI+beN5Q
	 YuQ9SRRr7fLUJq9sKJo0NkEzMkB9SXAzOeIhCcuGywcyHf4X2UZwnV8JFH1VZyaV40
	 Il0Eai0jOfVLJ9GYFndOm2hYw+vm34ZpUKz2t5mW1u7n1KbdgOyEJkrc+MkWKmIIr4
	 D0LrIcDB9f6ZJrat9ekA6GunMzcrQjSi0eR133XeSYEreOxTm4LOzqpQE2dj1giggJ
	 PueMruTqR9GBg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239924>

From: "W. Trevor King" <wking@tremily.us>

Before this commit, all the settings fell under the initial "Each
submodule section also contains the following required keys:".  The
example shows sections with just 'update' and 'url' entries, but we
should still make the required/optional distinction explicit for the
descriptions.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/gitmodules.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index f7be93f..347a9f7 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -35,6 +35,8 @@ submodule.<name>.url::
 	linkgit:git-clone[1] or (if it begins with ./ or ../) a location
 	relative to the superproject's origin repository.
 
+In addition, there are a number of optional keys:
+
 submodule.<name>.update::
 	Defines what to do when the submodule is updated by the superproject.
 	If 'checkout' (the default), the new commit specified in the
-- 
1.8.5.2.gaa5d535.dirty
