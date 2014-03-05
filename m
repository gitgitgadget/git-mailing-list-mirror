From: Dmitry <wipedout@yandex.ru>
Subject: git push first asks for credentials, then checks the branch exists
Date: Wed, 05 Mar 2014 13:36:12 +0400
Message-ID: <259061394012172@web5j.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 05 10:45:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WL8OY-0000Ox-Em
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 10:45:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753899AbaCEJpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 04:45:41 -0500
Received: from forward13.mail.yandex.net ([95.108.130.120]:59659 "EHLO
	forward13.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622AbaCEJpj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 04:45:39 -0500
X-Greylist: delayed 564 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Mar 2014 04:45:39 EST
Received: from web5j.yandex.ru (web5j.yandex.ru [5.45.198.46])
	by forward13.mail.yandex.net (Yandex) with ESMTP id 4BB4B141624
	for <git@vger.kernel.org>; Wed,  5 Mar 2014 13:36:13 +0400 (MSK)
Received: from 127.0.0.1 (localhost [127.0.0.1])
	by web5j.yandex.ru (Yandex) with ESMTP id F1FBC2681391;
	Wed,  5 Mar 2014 13:36:12 +0400 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1394012173; bh=Qs+E7/2m/RbaV5Lz86TJLkzJ0c1FmihCRYCnUunbY6I=;
	h=From:To:Subject:Date;
	b=r5OaThX9UOjAfpQ/O82FTk2B/7uvGCDgJCvaNPHYe7WPGuIFm6L6+B0TTnRP0UxXe
	 wARvTK+u/fzjOCXdz+sFG+MiGs97k+a9GJFCWOVgH0LH7pvc2ejXyRCvRBZG/Zi8zq
	 9uRHnCr3OSa/hPnktI+TjSrmyRyWMbrmizetJWVk=
Received: from [195.210.147.143] ([195.210.147.143]) by web5j.yandex.ru with HTTP;
	Wed, 05 Mar 2014 13:36:12 +0400
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243431>

Hi,

Here's my usecase. I have created a BranchWithVeryLongName and I want to have it pushed to origin. So I use this command with version 1.8.1.2:

git push origin BranchMistypedLongName

(note that I mistyped the branch name). The following happens:
1. git asks me for username and password
2. it authenticates on the origin server
3. it bails out with "error: sfc refspec BranchMistypedLongName does not match any"


Can't git perhaps check that the branch exists before it asks me for credentials and just say there's no such branch?

Could you please fix this?

Thank you.
Dmitry.
