From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/9] remote-helpers: fixes and cleanups
Date: Thu, 25 Apr 2013 19:08:13 -0500
Message-ID: <1366934902-18704-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 02:09:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVWER-0003R5-Og
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 02:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758118Ab3DZAJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 20:09:39 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:45672 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757199Ab3DZAJj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 20:09:39 -0400
Received: by mail-ob0-f181.google.com with SMTP id ta17so2998126obb.40
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 17:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=bHKLxWACKp9YFZJlhZgPUMOOrVZkE/TCudUlczlubu4=;
        b=Gg8WIUgrJQBGzgc1fF9xCuzPzTN9pwwhf8axl0iMDSv47H6wSkllVfMUaIE3ts6vQq
         AB2K3fKGs45X4PVPZV7xLC0y2NpJYK6RQq9O5JVTyrdiR1j4AQRzZiJDykJtNIML+SZU
         /d/QwCc3c1MkfOpGfQChYzjbI38UwFujWTj7M/FNvzGVzO1peYGAlLrDgC81AbAbliT2
         93xzf1oVWq3UH+HDJwPGEIwz/L3X/L1FjINzF2v7sqLgLfSiTedLVeNx2nu7QXhc1qfb
         K+MfebFXsRhDrkX+61PH0km/duMkvnUQar7co6ftHhe07s6WShXwlEYsQoWiSM4GvN5s
         u41A==
X-Received: by 10.60.136.234 with SMTP id qd10mr1806551oeb.15.1366934978610;
        Thu, 25 Apr 2013 17:09:38 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id l9sm1443192oem.7.2013.04.25.17.09.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 17:09:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.884.g3532a8d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222469>

Hi,

Same as before, minus one fix. This time they are based on 'next' so there
shouldn't be any conflicts.

Here's a bunch of cleanups mostly to synchronize remote-bzr and remote-hg.

Felipe Contreras (9):
  remote-helpers: trivial cleanups
  remote-hg: remove extra check
  remote-bzr: fix bad state issue
  remote-bzr: add support to push URLs
  remote-hg: use hashlib instead of hg sha1 util
  remote-bzr: store converted URL
  remote-bzr: tell bazaar to be quiet
  remote-bzr: strip extra newline
  remote-bzr: use proper push method

 contrib/remote-helpers/git-remote-bzr | 55 ++++++++++++++++++++++++++++-------
 contrib/remote-helpers/git-remote-hg  | 10 ++-----
 2 files changed, 48 insertions(+), 17 deletions(-)

-- 
1.8.2.1.884.g3532a8d
