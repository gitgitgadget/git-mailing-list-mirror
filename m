From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: There you have it. Git.pm breaks pull.
Date: Mon, 3 Jul 2006 06:35:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607030633120.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Jul 03 06:35:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxG9y-0004pv-Cw
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 06:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWGCEfY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 00:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWGCEfY
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 00:35:24 -0400
Received: from mail.gmx.net ([213.165.64.21]:11984 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751299AbWGCEfY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 00:35:24 -0400
Received: (qmail invoked by alias); 03 Jul 2006 04:35:22 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 03 Jul 2006 06:35:22 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23153>

Hi,

I do not install git, but run it in place. And now git-pull, the core of 
git, is broken.

Can't locate Git.pm in @INC (@INC contains: 
/home/gene099/lib/perl5/site_perl/5.8.0/i586-linux-thread-multi 
/usr/lib/perl5/5.8.0/i586-linux-thread-multi /usr/lib/perl5/5.8.0 
/usr/lib/perl5/site_perl/5.8.0/i586-linux-thread-multi 
/usr/lib/perl5/site_perl/5.8.0 /usr/lib/perl5/site_perl .) at 
./git-fmt-merge-msg line 14.
BEGIN failed--compilation aborted at ./git-fmt-merge-msg line 14.

I have to run for work, but next thing I'll do with git is rewrite 
git-fmt-merge-msg in C.

Ciao,
Dscho
