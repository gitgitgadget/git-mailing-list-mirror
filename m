From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] Update documentation: git-commit is not a shell command
Date: Sat, 16 Jan 2010 15:05:40 +0530
Message-ID: <f3271551001160135k569e2692i5e2ab893701e1738@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 16 10:36:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NW54t-00088Z-Ny
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 10:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521Ab0APJgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 04:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752305Ab0APJgL
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 04:36:11 -0500
Received: from mail-gx0-f217.google.com ([209.85.217.217]:38034 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967Ab0APJgH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 04:36:07 -0500
Received: by gxk9 with SMTP id 9so2642892gxk.8
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 01:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=UaCZ7OuWFED/401Yo3vUbAUJehjTbPQcFd6XDwtSZdQ=;
        b=tWSwjZF7XyZxovr7Nn59Z5g5v6XOw4JIUTilaSXyz0uqNxFeJqXiohcPnPiCdSFp7z
         EnNlIaJwQROJYU8TkuTl8HjIhADnqvZOJgBIhKinn5FHphSqopBcP0KbV34VSM47GJ7w
         egMMRcEDUq5T17R+AkJcoNun20ATZ4Mrz+bSk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=N3yrTa54JEx49QkwatwEQL+Uvdk3y7/zprdj0JgoGBzl1QZtkdUuJ7jRXgmkYo/xUL
         62i6N2sHh+JfE1RpIC4iYL9GD6jj0Pbvklz3sfMJGGHk3rGZYYQ0EiNmkW5kspMMiDQ1
         WZawkRt0hpNOSdWumSPjLc0Zg0hILweYFmN/c=
Received: by 10.90.40.17 with SMTP id n17mr3515805agn.3.1263634560811; Sat, 16 
	Jan 2010 01:36:00 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137214>

Reported by Osamu Aoki through http://bugs.debian.org/560795

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/gitcore-tutorial.txt |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/Documentation/gitcore-tutorial.txt
b/Documentation/gitcore-tutorial.txt
index f762dca..ebc5d0b 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -454,14 +454,7 @@ will be pruned out, and the rest will be used as
the commit message for
 the change. If you decide you don't want to commit anything after all at
 this point (you can continue to edit things and update the index), you
 can just leave an empty message. Otherwise `git commit` will commit
-the change for you.
-
-You've now made your first real git commit. And if you're interested in
-looking at what `git commit` really does, feel free to investigate:
-it's a few very simple shell scripts to generate the helpful (?) commit
-message headers, and a few one-liners that actually do the
-commit itself ('git-commit').
-
+the change for you. You've now made your first real git commit.

 Inspecting Changes
 ------------------
-- 
1.6.5
