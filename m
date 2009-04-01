From: Ali Gholami Rudi <ali@rudi.ir>
Subject: [PATCH] builtin-clone.c: make junk_pid static
Date: Wed, 1 Apr 2009 12:34:44 +0430
Message-ID: <20090401080444.GA2237@lilem.mirepesht>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 01 10:08:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LovUw-0005k7-86
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 10:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233AbZDAIHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 04:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbZDAIHB
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 04:07:01 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:38584 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbZDAIHA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 04:07:00 -0400
Received: by ewy9 with SMTP id 9so2941381ewy.37
        for <git@vger.kernel.org>; Wed, 01 Apr 2009 01:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=e+Bm6h8ymT3vUAvwf7jMfULY9bbbO6VA/kuC583X6VY=;
        b=iPOvWgk25KCvnUA/J6fOuAikBwraE4KB56REiVObz9HWqYPpXUNRoxmt90GDlFfC67
         ZIXc3Pey9tSsvzlmB4BZsPaWJrws9DVBaewQB4a3mA6OjnNhh7TEIvVuWnrDK8DxbO2+
         BwAROEtFyBS/nNe339q5ih0R0dZb1i7pOOvOk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=c+rzjg8dMWMBE2coKh2bdQHq83nazzPzdw8yjnDdC4wNArjXgyS6OJAJhI/qUmovXs
         2qvpF1V3D7eGzFapYgTO+/lc1cNwJ2q0LO4+cwx7NwlS5xkcASzfSy68rWN7uhML5PaO
         F0685Cks4CCaUM7vw6okezk1FwV7Z9GUQpaPE=
Received: by 10.216.20.210 with SMTP id p60mr2427166wep.172.1238573217549;
        Wed, 01 Apr 2009 01:06:57 -0700 (PDT)
Received: from localhost ([85.185.70.226])
        by mx.google.com with ESMTPS id g9sm11469762gvc.28.2009.04.01.01.06.54
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Apr 2009 01:06:56 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115351>

junk_pid is used only in builtin-clone.c.

Signed-off-by: Ali Gholami Rudi <ali@rudi.ir>
---
 builtin-clone.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 0031b5f..736c72c 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -270,7 +270,7 @@ static const struct ref *clone_local(const char *src_repo,
 
 static const char *junk_work_tree;
 static const char *junk_git_dir;
-pid_t junk_pid;
+static pid_t junk_pid;
 
 static void remove_junk(void)
 {
