From: Alexander Iljin <ajsoft@yandex.ru>
Subject: Re: Git 1.7 rebase problems
Date: Thu, 22 Apr 2010 01:41:20 +0700
Message-ID: <178224036.20100422014120@yandex.ru>
References: <4BCF2E27.1010906@gmx.de>
Reply-To: =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCY0LvRjNC40L0=?= 
	  <ajsoft@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 21 20:41:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4erg-0005MO-Dl
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 20:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756165Ab0DUSla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 14:41:30 -0400
Received: from forward3.mail.yandex.net ([77.88.46.8]:40962 "EHLO
	forward3.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756149Ab0DUSl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 14:41:29 -0400
Received: from smtp3.mail.yandex.net (smtp3.mail.yandex.net [77.88.46.103])
	by forward3.mail.yandex.net (Yandex) with ESMTP id DBB6856D9FB1;
	Wed, 21 Apr 2010 22:41:27 +0400 (MSD)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1271875287; bh=PdBPLMg2H326BLpIQvl6lgN6n0qcejMcIPRJtW/r23s=;
	h=Date:From:Reply-To:Message-ID:To:CC:Subject:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=e57vFbcJiFxzddmydUXjD0TubmxYTAcVBXQfAzytoUkZUy4uVvyFf0Sr2xI0dpZyZ
	 xxQyeBIy1EDOE6I6LT3EX2R2CMaNRa/rrpCtE3K5dv7C2pp1M0oTR87yaZnG3mJ4z6
	 2xM6FCWL6YO9yfuAYy9fBqFWNgCaRRocicYJHEtE=
Received: from h88-115-252.sibinet.com (unknown [88.204.115.252])
	by smtp3.mail.yandex.net (Yandex) with ESMTPA id 7B50927807E;
	Wed, 21 Apr 2010 22:41:27 +0400 (MSD)
X-Priority: 3 (Normal)
In-Reply-To: <4BCF2E27.1010906@gmx.de>
X-Yandex-TimeMark: 1271875287
X-Yandex-Spam: 1
X-Yandex-Front: smtp3.mail.yandex.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145447>

Hello!

MA> Looking for help - I have some issues with git-svn as of git version
MA> 1.7.1.rc1.12.ga601 on Cygwin 1.7.5 w/ Windows 7 32-bit professional German, but
MA> this has been going on for a while now, but I hadn't figured how to reproduce.

MA> === Symptoms ===

MA> When I run "git svn rebase" (trace below) *from a working directory somewhere
MA> deep in the checkout,* the index gets dirty.

  Wow! I just filed a very similar issue at msysGit discussion group,
  with steps to reproduce, etc. See here:
  http://groups.google.com/group/msysgit/browse_thread/thread/c7218c7d1ba8949b
  I could not make interactive rebase work, it just hanged there.

  Going to the root of the repository fixed the problem.

---=====---
 Alexander
