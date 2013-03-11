From: Max Horn <max@quendi.de>
Subject: Re: rebase: strange failures to apply patc 3-way
Date: Mon, 11 Mar 2013 22:20:47 +0100
Message-ID: <E30ECECD-DD58-41E2-AA7C-18F83E5E74E6@quendi.de>
References: <7A483B92-D671-46CA-9EFD-83C6F4C97B5E@quendi.de> <494292C5-EBD9-487B-8846-9D9DD23ACB83@quendi.de> <CADeaMWp_R0HLwEYn7O3oX4-0OoSeqLfzz_2AYXT-Po88nM4HkQ@mail.gmail.com> <205D17C4-F737-46E9-BC48-D16D5948C707@quendi.de> <CADgNjan9v++__TSPE55j7+=BBZrVEkMD52O+9kXAm-C8SRV+Ww@mail.gmail.com> <B21B6CEC-7507-47A1-9BBB-FB95EA6B831F@quendi.de> <CADgNja=Ej8jnYn027GX986VrmuqVemM7aE59rynHzUpToPVaEw@mail.gmail.com> <3B5EA38E-9603-4321-AA3C-74354BBC8BFC@quendi.de> <513B8037.7060107@gmail.com> <C79E1B20-2C42-49FF-A964-285A7049FDED@quendi.de> <CADgNjanQxMFrQG=7SqgAXv5PW8OEfG+1kZt_Mrq27OcP1uyGtA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 11 22:21:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFAAM-00058X-6A
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 22:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101Ab3CKVVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 17:21:11 -0400
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:42591 "EHLO
	merkurneu.hrz.uni-giessen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754587Ab3CKVVK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 17:21:10 -0400
Received: from mailgw42.hrz.uni-giessen.de by merkurneu.hrz.uni-giessen.de with ESMTP; Mon, 11 Mar 2013 22:20:56 +0100
Received: from merkurneu.hrz.uni-giessen.de (merkurneu.hrz.uni-giessen.de [134.176.2.3])
	by mailgw42.hrz.uni-giessen.de (Postfix) with ESMTP id 227849C;
	Mon, 11 Mar 2013 22:20:49 +0100 (CET)
Received: from [134.176.2.3] by merkurneu.hrz.uni-giessen.de with ESMTP; Mon, 11 Mar 2013 22:20:49 +0100
In-Reply-To: <CADgNjanQxMFrQG=7SqgAXv5PW8OEfG+1kZt_Mrq27OcP1uyGtA@mail.gmail.com>
X-Mailer: Apple Mail (2.1283)
X-HRZ-JLUG-MailScanner-Information: Passed JLUG virus check
X-HRZ-JLUG-MailScanner: No virus found
X-Envelope-From: max@quendi.de
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217911>

PS: Just as a side note, I should mention that I have done tons of rebases on various repositories on this very machine: same hard drive, same file system; the git version of course has changed over time, but as I already described, I can reproduce the same issue with older git versions.

All I want to say here is: While this may of course be a bug of OS X or my machine may be faulty or whatever, it is not as if this issue is occurring all over the place. It is so far somehow specific to this repository, or even the particular branch. So it is probably not something as simple as a faulty clock, because then I should be seeing rebases fail all over the place, right? (Hm, OK, admittedly I didn't try any other big rebases in the last couple days. And right now I have no good example at hand, i.e. a non-trivial branch that cleanly rebases to some other branch)


Cheers,
Max