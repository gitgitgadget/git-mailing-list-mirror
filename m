From: KES <kes-kes@yandex.ua>
Subject: Can not 'git add file'
Date: Sun, 03 Jan 2016 16:53:11 +0200
Message-ID: <1500251451832791@web17m.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 03 16:01:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aFk9V-0002ov-7A
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jan 2016 16:01:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbcACPAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jan 2016 10:00:24 -0500
Received: from forward18m.cmail.yandex.net ([5.255.216.149]:57998 "EHLO
	forward18m.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751355AbcACPAX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jan 2016 10:00:23 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 Jan 2016 10:00:22 EST
Received: from web17m.yandex.ru (web17m.yandex.ru [37.140.138.108])
	by forward18m.cmail.yandex.net (Yandex) with ESMTP id 5D3E120C4D
	for <git@vger.kernel.org>; Sun,  3 Jan 2016 17:53:12 +0300 (MSK)
Received: from 127.0.0.1 (localhost [127.0.0.1])
	by web17m.yandex.ru (Yandex) with ESMTP id D443C37A2C41;
	Sun,  3 Jan 2016 17:53:11 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1451832792; bh=Zt5tK5SYMal/8veyG8+9Ml283S3C4Vvpy5uuPa3hfig=;
	h=From:To:Subject:Date;
	b=a1NQdU9JkSGyikbpZPQlN/8kcUFPnqO1aGUmPnw2GsG7nafOJCZoULyYHQB2zHv0X
	 tTI1uklDva+1yyyuljuiEeg6dG9xExP5RJz3OztFGBXWmLesyF6pXOgPuw2S8GlUX7
	 YdOFMxcq/c9JApZtoPhzOCxsaM1rMgbvWFMg+U/M=
Received: by web17m.yandex.ru with HTTP;
	Sun, 03 Jan 2016 17:53:11 +0300
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283274>

Hi.

How to reproduce

$ git-number
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

1	modified:   ../lib/Devel/DebugHooks.pm
2	modified:   ../lib/Devel/KillPrint.pm
3	modified:   00-simple.t

Untracked files:
  (use "git add <file>..." to include in what will be committed)

4	../lib/Devel/DebugHooks/
5	../lib/Devel/ImportArgs.pm
6	../lib/Devel/KillPrintTest.pm
7	../lib/Devel/KillPrint_scope.pm
8	../lib/Devel/PkgAtCompileTime.pm
9	../lib/Devel/t.pl
10	lib/Devel/AutoInit.pm
11	lib/Devel/DZVii.pm

no changes added to commit (use "git add" and/or "git commit -a")
$ git add -p ../lib/Devel/DebugHooks/Commands.pm 
No changes.

I want to start track file here, but I do not want to stage while file.

It seems the git can not process this case and do not allow me to complete that.
