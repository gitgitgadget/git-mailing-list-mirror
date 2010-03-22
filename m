From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 0/3] girocco + git-svn: trunk is not propagated to master + more... (resend)
Date: Mon, 22 Mar 2010 14:07:58 +0300
Message-ID: <cover.1269255835.git.kirr@mns.spb.ru>
References: <20100222085029.GA28744@landau.phys.spbu.ru>
Cc: Miklos Vajna <vmiklos@frugalware.org>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Mar 22 12:13:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtfZD-0007zi-Nj
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 12:13:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646Ab0CVLND (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 07:13:03 -0400
Received: from mail.mnsspb.ru ([84.204.75.2]:39925 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752837Ab0CVLNB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 07:13:01 -0400
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1NtfYd-0000hV-SW; Mon, 22 Mar 2010 14:12:32 +0300
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1NtfUb-0002uQ-U3; Mon, 22 Mar 2010 14:08:21 +0300
X-Mailer: git-send-email 1.7.0.2.284.gafe27d
In-Reply-To: <20100222085029.GA28744@landau.phys.spbu.ru>
In-Reply-To: <20100222085029.GA28744@landau.phys.spbu.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142917>

On Mon, Feb 22, 2010 at 11:50:29AM +0300, Kirill Smelkov wrote:
> On Sun, Feb 21, 2010 at 08:19:39PM +0300, Kirill Smelkov wrote:
> > ... I think I've found the problem -- it's that we need to use
> > `git config --add` in order to setup multivars. Please find patches below.
> > Petr, if everything is ok with them, could you please apply it? Thanks.
>
> And also, while at it, I was always dreaming about http:// style svn
> mirroring support at repo.or.cz . Petr, they say dreams always come
> true. Could you please apply it?

Petr,

Since I was once recognized as russian spam in Junio's inbox, and it's
already one month since I originally posted, I'd like
to "resend" this stuff. Could you please ACK/NAK?

Thanks beforehand,
Kirill


http://marc.info/?l=git&m=126677421607801&w=2
http://marc.info/?l=git&m=126682864619850&w=2


Kirill Smelkov (3):
  taskd/clone: Don't forget to use 'git config --add' for multivars
    setup
  taskd/clone: quote shell metacharacters where appropriate
  Teach Girocco to mirror http:// style SVN repos

 Girocco/Util.pm |    2 +-
 jobd/update.sh  |    2 +-
 taskd/clone.sh  |   12 +++++++-----
 3 files changed, 9 insertions(+), 7 deletions(-)
