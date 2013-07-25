From: =?koi8-r?B?ydfBzs/XIMnXwc4=?= <xowirun@yandex.ru>
Subject: git and cyrillic branches
Date: Thu, 25 Jul 2013 15:19:48 +0300
Message-ID: <922031374754788@web29h.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 25 14:27:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2Kdh-0005SW-No
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jul 2013 14:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755450Ab3GYM1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jul 2013 08:27:21 -0400
Received: from forward5h.mail.yandex.net ([84.201.186.23]:34718 "EHLO
	forward5h.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755358Ab3GYM1V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jul 2013 08:27:21 -0400
X-Greylist: delayed 446 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Jul 2013 08:27:21 EDT
Received: from web29h.yandex.ru (web29h.yandex.ru [84.201.187.163])
	by forward5h.mail.yandex.net (Yandex) with ESMTP id 90809D01928
	for <git@vger.kernel.org>; Thu, 25 Jul 2013 16:19:49 +0400 (MSK)
Received: from 127.0.0.1 (localhost.localdomain [127.0.0.1])
	by web29h.yandex.ru (Yandex) with ESMTP id 1EEA83396AE;
	Thu, 25 Jul 2013 16:19:49 +0400 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1374754789; bh=eQwX8mdNqEpwakTjCvutzDM96fCruxI4E089Wx5yd7Q=;
	h=From:To:Subject:Date;
	b=w4sfYIg5GOk8hRHV6GSA4wZIrHZC4zxCq0iHsZs+2vRme9uw0D0C8Pfe3kkUPsdAT
	 kgAuUfRvlFMbWS+Xf9LpLjISg76B4DBmlNf38PYwpXCxB6Cn96WhR7UeNL9lrP0G7j
	 xAKPrah1ZVn29Q49PSd/t5LISli6xrt5652Ttpgw=
Received: from client.yota.ru (client.yota.ru [188.162.36.106]) by web29h.yandex.ru with HTTP;
	Thu, 25 Jul 2013 16:19:48 +0400
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231131>

hello! there is problem vith git and cyrillic (utf-8) names of branches. branch creates perfectly, but when i clone this remote branch to local host, there are 2 bugs:
1) "git branch" doesnt show checked branch with asterisk (while on remote server it does)
2) "git push" gives 2 errors: "fatal: BRANCH_NAME cannot be resolved to branch." and "fatal: The remote end hung up unexpectedly"
thanks.
