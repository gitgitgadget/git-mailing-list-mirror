From: Alex Bennee <kernel-hacker@bennee.com>
Subject: [QUESTION] What is a tag for?
Date: Tue, 17 Jan 2006 22:52:24 +0000
Message-ID: <1137538344.9104.34.camel@malory>
Reply-To: kernel-hacker@bennee.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 17 23:52:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eyzgd-0007Ka-RZ
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 23:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbWAQWwV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 17:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbWAQWwV
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 17:52:21 -0500
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:59764 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932483AbWAQWwU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2006 17:52:20 -0500
Received: from aamta12-winn.ispmail.ntl.com ([81.103.221.35])
          by mta07-winn.ispmail.ntl.com with ESMTP
          id <20060117225216.PBX11753.mta07-winn.ispmail.ntl.com@aamta12-winn.ispmail.ntl.com>
          for <git@vger.kernel.org>; Tue, 17 Jan 2006 22:52:16 +0000
Received: from jack.nin ([81.97.154.68]) by aamta12-winn.ispmail.ntl.com
          with ESMTP
          id <20060117225216.ZPNJ20369.aamta12-winn.ispmail.ntl.com@jack.nin>
          for <git@vger.kernel.org>; Tue, 17 Jan 2006 22:52:16 +0000
Received: from [192.168.1.3] (helo=malory)
	by jack.nin with esmtp (Exim 3.36 #1 (Debian))
	id 1EyzgT-0004mU-00
	for <git@vger.kernel.org>; Tue, 17 Jan 2006 22:52:13 +0000
To: git@vger.kernel.org
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14804>

Hi,

So I want to track Linus's 2.6 git tree as well as do a little small
time hacking. I'm not brave enough to sit on the very bleeding edge and
build what ever happens to be at the "HEAD" of the tree. However when a
kernel releases I'd like to build *that* kernel.

I keep thinking of tags like labels in the old convetional SCM case. Is
this correct? I can see once I've done my update (fetch/cogito what
ever) that these tags apear in my local tree:

22:42 alex@malory [linux-2.6] >cat .git/refs/tags/v2.6.16-rc1
f3bcf72eb85aba88a7bd0a6116dd0b5418590dbe

So what do I do with them now? Are they only for branch points? Is the
only way to know I'm building 2.6.16-rc1 to branch from it as described
in git-branch, even if I'm not planning on doing any development?

Is this part of the concept that branches are cheap and you should feel
free to create and throw them away at will?

I look forward to your elucidation and the ah! moment that finally gets
my head around git ;-)

Cheers,


--
Alex, homepage: http://www.bennee.com/~alex/
Zoe: "So.. Trap?" Mal: "Trap." Zoe: "We goin' in?" Mal: "Ain't nothin'
but a few hours out." Wash: "But, remember the part where it's a trap?"
