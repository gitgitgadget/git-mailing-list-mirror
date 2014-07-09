From: Dmitry <wipedout@yandex.ru>
Subject: "Unexpected end of command stream" message looks irrelevant when I try to pull a non-existing branch
Date: Wed, 09 Jul 2014 11:37:51 +0400
Message-ID: <787461404891471@web12h.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 09:38:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4mRz-0005fn-G2
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 09:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbaGIHhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 03:37:55 -0400
Received: from forward1h.mail.yandex.net ([84.201.187.146]:55789 "EHLO
	forward1h.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbaGIHhy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 03:37:54 -0400
Received: from web12h.yandex.ru (web12h.yandex.ru [84.201.186.41])
	by forward1h.mail.yandex.net (Yandex) with ESMTP id 1EF209E19EE
	for <git@vger.kernel.org>; Wed,  9 Jul 2014 11:37:52 +0400 (MSK)
Received: from 127.0.0.1 (localhost [127.0.0.1])
	by web12h.yandex.ru (Yandex) with ESMTP id 995B71460C0A;
	Wed,  9 Jul 2014 11:37:51 +0400 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1404891471; bh=35S/OoVpd0NfAakWTWttCwGzsyAN7ELczWk12xq06JY=;
	h=From:To:Subject:Date;
	b=D+83KjuticGS5DieJJnYCg1Q85LW2Arls3am/lySV7A63wYTGDZr5Je3MSPzL7QaZ
	 VcwWGtD9V+gUvMR96Up4HjLbrXgQDtsmuvcfoGj2qhcMVpzSx4U06Exwq7K9N+2GZ1
	 zN1XYdr9J65NoDigL/wZQBKoaIc0RpeymT09HB0Y=
Received: from hq-hub1.abbyy.com (hq-hub1.abbyy.com [212.44.132.21]) by web12h.yandex.ru with HTTP;
	Wed, 09 Jul 2014 11:37:51 +0400
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253108>

Hi,

I'm using Git 1.8.1 and when I run the following command:

git pull origin matser

I get the following output:

fatal: couldn't find remote ref matser
Unexpected end of command stream

The first line in the output is right on the money but the second one looks completely irrelevant - the command is well formed except I perhaps mistyped the branch name. It looks like there's some bug that prevents the program from just exiting after printing the first line and so the second line is being output.

Could you please fix this?

Thank you.
Dmitry.
--
