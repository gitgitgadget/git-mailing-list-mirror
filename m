From: Max Horn <max@quendi.de>
Subject: On git-remote-hg (the "native" one)
Date: Fri, 6 Jul 2012 03:14:09 +0200
Message-ID: <36B95782-DE96-4BCB-8919-4AB2160C8CDD@quendi.de>
Mime-Version: 1.0 (Apple Message framework v1280)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 06 03:14:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Smx7s-0006bk-KS
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 03:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755607Ab2GFBOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 21:14:22 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:50039 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755881Ab2GFBOO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 5 Jul 2012 21:14:14 -0400
Received: from 77-22-67-26-dynip.superkabel.de ([77.22.67.26] helo=kaitain-wlan.fritz.box); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1Smx7a-0001o7-9R; Fri, 06 Jul 2012 03:14:10 +0200
X-Mailer: Apple Mail (2.1280)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1341537254;ed80b998;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201083>

Dear all,

as you may know, Johannes Schindelin and Sverre Rabbelier (with help by Michael J Gruber) create some time ago a remote helper for mercurial repositories. Unlike the one https://github.com/rfk/git-remote-hg (which is based on hg-git), this one directly uses the Mercurial python code, and as a result is often much faster, e.g. when cloning big repositories.

This is a *very* interesting project for anybody (like me ;) who is a git fan but for some reason is forced to work with Mercurial repositories. Just like hg-git is useful in the converse situation. If like me you would like to know more about its status, on how to use it in the first place, and what is missing, take a look here:

  <https://github.com/msysgit/msysgit/wiki/Guide-to-git-remote-hg>

I tried to collect everything I could find about git-remote-hg on this page, and begun a list of things that need to be done to make git-remote-hg useful for a wider audience. And things blocking its inclusion into git. BTW, it was Johannes who suggested to me that I should add this to the msysgit wiki.

In addition, I made some small tweaks and also fixed the commit message of at least one old committed that apparently got messed up during some rebasing. You can find it here:
  <https://github.com/fingolfin/git/tree/remote-hg>

Unfortunately, I myself can't dedicate much time to this project :-(, nor am I a git expert in the first place. But perhaps this Wiki page will attract some people to git-remote-hg who otherwise might not have known about it, respectively about what needs to be done. I am not expecting miracles, but I think this minor contribution will at least very slightly improve the chances for git-remote-hg being developed further.

So, your help is warmly welcome :-).

Cheers,
Max