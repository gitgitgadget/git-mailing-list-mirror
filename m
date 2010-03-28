From: Alexander Iljin <ajsoft@yandex.ru>
Subject: Re: updating github.com forks, developing in remote branches and  svn:eol-style equiv?
Date: Mon, 29 Mar 2010 00:42:45 +0700
Message-ID: <159821389.20100329004245@yandex.ru>
References: <15b345f1003272332u2f4d38ear5c8aeef9b35f5037@mail.gmail.com> <158811269761123@webmail102.yandex.ru> <15b345f1003281007r3e8b3e86p787f9ef554054adf@mail.gmail.com>
Reply-To: =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCY0LvRjNC40L0=?= 
	  <ajsoft@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Thomas Anderson <zelnaga@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 28 19:52:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvwfR-00037m-Gs
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 19:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861Ab0C1Rwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 13:52:53 -0400
Received: from forward2.mail.yandex.net ([77.88.46.7]:38308 "EHLO
	forward2.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754853Ab0C1Rww (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 13:52:52 -0400
X-Greylist: delayed 594 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Mar 2010 13:52:52 EDT
Received: from smtp2.mail.yandex.net (smtp2.mail.yandex.net [77.88.46.102])
	by forward2.mail.yandex.net (Yandex) with ESMTP id 32FDC36880D6;
	Sun, 28 Mar 2010 21:42:56 +0400 (MSD)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1269798176; bh=zsGaq6vCroIiBu01drmdp2rOE7TzRvjHk0N2F2X4zi8=;
	h=Date:From:Reply-To:Message-ID:To:CC:Subject:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=Bsy8WN5/8TfjgcHDNUaXmHhjG2hSp4i64iVvntk6vFwV0ILpDH+sqUq01lBh3JsHh
	 fAqaHFw3F5etlGBbYHyhI8RHzEt4UgEK8qmp24FcEssXp6N9nWrcoLOZPAO5lc6gsp
	 XCzRcKa0fHziV60pkGjfhzin2mITUHScofzCbTf0=
Received: from h88-115-19.sibinet.com (unknown [88.204.115.19])
	by smtp2.mail.yandex.net (Yandex) with ESMTPA id D1DB4D18130;
	Sun, 28 Mar 2010 21:42:55 +0400 (MSD)
X-Priority: 3 (Normal)
In-Reply-To: <15b345f1003281007r3e8b3e86p787f9ef554054adf@mail.gmail.com>
X-Yandex-TimeMark: 1269798176
X-Yandex-Spam: 1
X-Yandex-Front: smtp2.mail.yandex.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143411>

Hello!

TA> In playing around with their Fork Queue feature...  I have a week old
TA> fork to which I've made no changes.  I do "Select All" for al the
TA> changes in teh original fork and then select "Apply" in the drop down
TA> "Actions" menu.  It then just sits there doing nothing.  It says
TA> "Status: Processing 1 of 8 Commits" and that's it.  Shouldn't it
TA> actually be doing something?

  Last time I tried it, it said that I'll have conflicts, even though
  it was clearly a fast-forward situation. I think that either the
  feature is not production-ready, or I am severely missing something.
  I don't know the current situation, that's why I suggested you give
  it a try.

TA> I think I figured out some of my confusion - there's a "Create New
TA> Branch" checkbox in the "Checkout\Switch" dialog that needs to be
TA> checked that isn't by default.  I guess the idea is that, by default,
TA> TortoiseGit assumes you want to make the branch you checkout the
TA> default branch?

  I don't use TGit. Previous version used to hang its cache process,
  consuming 100% CPU. After once restarting it 3 times in 10 minutes I
  got rid of it. Didn't have time to give the latest version a try.
  I like the idea, and the GUI looks very usable, but I guess the
  implementation is pretty sloppy. Unlike TSvn, which is great.

  I'm using msysgit with gitk and git gui (in previous version
  git gui didn't show diffs, but the latest works almost fine).

---=====---
 Alexander
