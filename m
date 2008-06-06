From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT PATCH 00/12] Extensions in core needed by PackWriter
Date: Fri, 6 Jun 2008 15:24:03 +0200
Message-ID: <200806061524.04140.robin.rosenberg@dewire.com>
References: <1212441883-12990-1-git-send-email-marek.zawirski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spearce@spearce.org, git@vger.kernel.org
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 15:28:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4bz0-0007qh-VY
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 15:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756180AbYFFN07 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Jun 2008 09:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756073AbYFFN07
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 09:26:59 -0400
Received: from [83.140.172.130] ([83.140.172.130]:21499 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755854AbYFFN06 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jun 2008 09:26:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 86D5C80287C;
	Fri,  6 Jun 2008 15:26:56 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eHiOe6W-PgBe; Fri,  6 Jun 2008 15:26:56 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id F0A078026F0;
	Fri,  6 Jun 2008 15:26:55 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1212441883-12990-1-git-send-email-marek.zawirski@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84065>

m=E5ndagen den 2 juni 2008 23.24.31 skrev Marek Zawirski:
> Hello,
>=20
> Here is my first GSoC series - some work from the last week.
> It's actually not a PackWriter, but some changes in existing jgit cor=
e
> related to PackWriting. Some of these added methods/refactors are not=
 yet
> used within this series, but are used in my dirty branch in PackWrite=
r
> which is under-development, even somewhat usable.
>=20
> Series start with formatting stuff, as some old files were not
> appropriatelly formatted.
>=20
> This series is also available at my corechanges branch:
> http://repo.or.cz/w/egit/zawir.git?a=3Dshortlog;h=3Drefs/heads/corech=
anges
> It's based on Shawn's bsd branch, with new BSD-style license, but I c=
an
> rebase if really needed.
No, that's fine.=20
>=20
> If you want to track some PackWriter (itself) development you may wan=
t to
> have a look at my dirty branch:
> http://repo.or.cz/w/egit/zawir.git?a=3Dshortlog;h=3Drefs/heads/dirty
>=20
> That's all. Although Shawn already reviewed some old version of this =
patches,
> I'm still interested in your comments.

A well defined set of enhancements with only minor nitpicks (in separat=
e mails)  I'm somewhat reluctant to reformatting patches though. Ideall=
y we'd be using eclipse 3.4 and have it format changed parts automatica=
lly on save (or similar feature for other IDE's). I tried format on all=
 classes leading to 118 files changed, but nothing major, just a lot of=
 changes with no relevant to readability, except some cases which only =
made things worse.  That's a reason why I have not formatted code accor=
ding to settings, although
the most common reason is probably sloppiness.

-- robin
