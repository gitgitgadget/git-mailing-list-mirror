From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH] Stop creating the .git/branches direectory in new repositories.
Date: Wed, 21 May 2008 16:09:30 -0400
Message-ID: <1211400570-6926-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: "	Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 21 22:11:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyueM-00038L-MH
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 22:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936286AbYEUUJz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 May 2008 16:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936159AbYEUUJx
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 16:09:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43076 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935203AbYEUUJw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 16:09:52 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m4LK9f7F030899;
	Wed, 21 May 2008 16:09:41 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m4LK9epj016652;
	Wed, 21 May 2008 16:09:41 -0400
Received: from localhost.localdomain (dhcp-100-3-198.bos.redhat.com [10.16.3.198])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m4LK9ekP026087;
	Wed, 21 May 2008 16:09:40 -0400
X-Mailer: git-send-email 1.5.4.5
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82579>

The .git/brances directory is actually a piece of cogito infrastructure
that git creates, and is only there to prevent cogito falling over.

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---

I think it's time to drop this confusing directory from the .git templa=
te.
If not for 1.5.x, let's at least schedule it for 1.6.0.

cheers,
Kristian

 templates/branches-- |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)
 delete mode 100644 templates/branches--

diff --git a/templates/branches-- b/templates/branches--
deleted file mode 100644
index fae8870..0000000
--- a/templates/branches--
+++ /dev/null
@@ -1 +0,0 @@
-: this is just to ensure the directory exists.
--=20
1.5.4.5
