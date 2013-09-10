From: Tvangeste <i.4m.l33t@yandex.ru>
Subject: Re: Regression in e02ca72: git svn rebase is broken on Windows
Date: Tue, 10 Sep 2013 22:53:21 +0200
Message-ID: <6821378846401@web12g.yandex.ru>
References: <17231378818848@web5m.yandex.ru> <alpine.DEB.1.00.1309101812450.1191@s15462909.onlinehome-server.info> <93421378835002@web20j.yandex.ru> <alpine.DEB.1.00.1309101958480.1191@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"msysgit@googlegroups.com" <msysgit@googlegroups.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 10 22:59:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJV2Q-0008OW-L3
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 22:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259Ab3IJU7u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Sep 2013 16:59:50 -0400
Received: from forward17.mail.yandex.net ([95.108.253.142]:60335 "EHLO
	forward17.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254Ab3IJU7t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 16:59:49 -0400
X-Greylist: delayed 385 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Sep 2013 16:59:49 EDT
Received: from web12g.yandex.ru (web12g.yandex.ru [95.108.252.112])
	by forward17.mail.yandex.net (Yandex) with ESMTP id 11FE110615A7;
	Wed, 11 Sep 2013 00:53:22 +0400 (MSK)
Received: from 127.0.0.1 (localhost [127.0.0.1])
	by web12g.yandex.ru (Yandex) with ESMTP id 94345A81633;
	Wed, 11 Sep 2013 00:53:21 +0400 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1378846401; bh=gGdVNnl7j2iV+vD8s7xPkee75QjhwaLQb8PWpUgk/Tg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Y/PvA4m2e+iqHGI/5uBszCgbksAf+8En5EK/2UJQHhhwXCihcevBXaA1d6iwEzTC/
	 XYYakodbBSnOT9JRLw90pxiCC4cxwXjshKvQiduofjZSaEI3ZMdDpDdpw81PuDPldo
	 0ew3lqn4n4CTbwmnU798/p9Y7bSe4NlTLQNfTPCo=
Received: from agsb-5d87fcb4.pool.mediaWays.net (agsb-5d87fcb4.pool.mediaWays.net [93.135.252.180]) by web12g.yandex.ru with HTTP;
	Wed, 11 Sep 2013 00:53:21 +0400
Envelope-From: i-4m-l33t@yandex.ru
In-Reply-To: <alpine.DEB.1.00.1309101958480.1191@s15462909.onlinehome-server.info>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234481>

10.09.2013, 20:02, "Johannes Schindelin" <Johannes.Schindelin@gmx.de>:
> =9AGiven the explanation what msysGit is, you might suspect that I'd =
like you
> =9Ato try to fix this in the msysGit context: After installing
>
> =9A=9A=9A=9A=9A=9A=9A=9A=9Ahttps://code.google.com/p/msysgit/download=
s/list?q=3Dnet+installer

No problem. Here's what I have so far:

1. Installed the latest msysgit from the URL you've provided. Tried the=
 git that comes out of the box that comes with the installer (1.8.3.msy=
sgit):

1a. On CMD: everything is fine.
1b. On msys shell: everything is fine.

2. Checked out the branch you've suggested to try (pt/tentative-1.8.4) =
and installed it. Tried the new version:

2a. On CMD: got the problem that is being discussed in this thread.
2b. On msys shell: everything is fine.

So, in summary. That commit e02ca72, somewhere between 1.8.3 and 1.8.4 =
introduced the regression in git/git-svn on Windows, when executed in C=
MD.

Thanks,
  --Tvangeste
