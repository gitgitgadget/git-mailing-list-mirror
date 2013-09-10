From: Tvangeste <i.4m.l33t@yandex.ru>
Subject: Re: Regression in e02ca72: git svn rebase is broken on Windows
Date: Tue, 10 Sep 2013 19:43:22 +0200
Message-ID: <93421378835002@web20j.yandex.ru>
References: <17231378818848@web5m.yandex.ru> <alpine.DEB.1.00.1309101812450.1191@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 10 19:49:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJS47-0002fY-Vh
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 19:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752943Ab3IJRtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 13:49:24 -0400
Received: from forward13.mail.yandex.net ([95.108.130.120]:40400 "EHLO
	forward13.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758Ab3IJRtX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 13:49:23 -0400
X-Greylist: delayed 355 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Sep 2013 13:49:23 EDT
Received: from web20j.yandex.ru (web20j.yandex.ru [5.45.198.61])
	by forward13.mail.yandex.net (Yandex) with ESMTP id 7C728141885;
	Tue, 10 Sep 2013 21:43:23 +0400 (MSK)
Received: from 127.0.0.1 (localhost [127.0.0.1])
	by web20j.yandex.ru (Yandex) with ESMTP id 2050F21C113D;
	Tue, 10 Sep 2013 21:43:23 +0400 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1378835003; bh=f8mQzbPwJ81+zJm5uzD3yG8fukelt975RXEQOwAdUW8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=B/KVohJKkdyqZ3dVpCIUM6yedfdmlly2FvNLg6+JgusZwhaIkN2ngI9HbmKF/nsAl
	 TojlPsbh0xaF+on68bkxrVztZVBLnA42t1hGxdiN1cGF42PNfjNqcHAw7SNxCZclaB
	 +G5dwtbhChfEQ1ce4nlC3XrRBgwuKIYQLDuIseVc=
Received: from agsb-5d87fcb4.pool.mediaWays.net (agsb-5d87fcb4.pool.mediaWays.net [93.135.252.180]) by web20j.yandex.ru with HTTP;
	Tue, 10 Sep 2013 21:43:22 +0400
Envelope-From: i-4m-l33t@yandex.ru
In-Reply-To: <alpine.DEB.1.00.1309101812450.1191@s15462909.onlinehome-server.info>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234463>

10.09.2013, 18:13, "Johannes Schindelin" <Johannes.Schindelin@gmx.de>:
> Have you tried with Git for Windows yet?

What's Git for Windows? If you mean msysgit, then I say no, because the latest msysgit version is from June 02, and the change under discussion was made later on, on June 25th. So, this regression is not in msysgit release (yet).

Thanks,
  --Tvangeste
