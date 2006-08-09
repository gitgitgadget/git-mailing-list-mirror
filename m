From: Alan Larkin <nobrow@eircom.net>
Subject: setting up a git repo on apache
Date: Wed, 09 Aug 2006 16:58:03 +0100
Message-ID: <44DA060B.2050601@eircom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Aug 09 17:58:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAqRd-0007sP-VR
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 17:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWHIP6G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 11:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbWHIP6F
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 11:58:05 -0400
Received: from mail09.svc.cra.dublin.eircom.net ([159.134.118.25]:1801 "HELO
	mail09.svc.cra.dublin.eircom.net") by vger.kernel.org with SMTP
	id S1751081AbWHIP6E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Aug 2006 11:58:04 -0400
Received: (qmail 22431 messnum 2876717 invoked from network[193.1.133.115/affront.ucd.ie]); 9 Aug 2006 15:58:03 -0000
Received: from affront.ucd.ie (HELO ?193.1.133.115?) (193.1.133.115)
  by mail09.svc.cra.dublin.eircom.net (qp 22431) with SMTP; 9 Aug 2006 15:58:03 -0000
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25123>

New user ... Hi.

I realise that this is really an apache question, but Im not getting any
help from their mailing lists and figure that there must be someone here
whos done this.

Can someone please help me get a GIT repo running on Apache 2.
Specifically my problem is with DAV.

$ git push http://localhost:/webdav/git/myproj master
Error: no DAV locking support on remote repo

I have dav_fs.conf, dav_fs.load, and dav.load in mods-enabled. They
load the modules and set

DAVLockDB /var/lock/apache2/DAV.lock

Apache owns and has full access to that directory.

I have removed all .htaccess files below /var/www/webdav. I am not
using any form of authentication. I have tried with and without aliases
for the repo directory. I have tried setting DAV on for
/var/www/webdav/git, and /var/www/webdav/git/myproj.

Its always the same. No DAV locking support.

If could help or even point me to some appropriate documentation (Ive
looked and looked and cant find any) Id appreciate it.

Thanks.
