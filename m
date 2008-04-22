From: Mike Galbraith <efault@gmx.de>
Subject: git remote update -> rejected
Date: Tue, 22 Apr 2008 11:48:53 +0200
Message-ID: <1208857733.4695.37.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 22 11:49:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoF8B-0000qf-Im
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 11:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757849AbYDVJs5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 05:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758062AbYDVJs5
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 05:48:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:54480 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757830AbYDVJs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 05:48:56 -0400
Received: (qmail invoked by alias); 22 Apr 2008 09:48:54 -0000
Received: from p54B5AFAD.dip0.t-ipconnect.de (EHLO [192.168.178.27]) [84.181.175.173]
  by mail.gmx.net (mp030) with SMTP; 22 Apr 2008 11:48:54 +0200
X-Authenticated: #14349625
X-Provags-ID: V01U2FsdGVkX1+1fqMHnTK1zqe7MAsS+bm8VBg7/JjM7aapnt75C4
	25wvPQG7GVNHtg
X-Mailer: Evolution 2.12.0 
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80088>

Greetings,

Does anyone know what could lead to this?  git doesn't have any trouble
(well, hasn't had any yet) with any trees other than x86 and
sched-devel. Nobody but little old me seems to be having this trouble...

git is pulled nearly every day, but checking out older versions doesn't
make any difference (unless i go too far back of course).

marge:..git/linux-2.6 # git remote update
Updating origin
Updating linux-next
Updating stable
Updating x86
>From git://git.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-x86
 ! [rejected]        latest     -> x86/latest  (non fast forward)
 ! [rejected]        master     -> x86/master  (non fast forward)
 ! [rejected]        testing    -> x86/testing  (non fast forward)
Updating sched-devel
>From git://git.kernel.org/pub/scm/linux/kernel/git/mingo/linux-2.6-sched-devel
 ! [rejected]        for-akpm   -> sched-devel/for-akpm  (non fast forward)
 ! [rejected]        latest     -> sched-devel/latest  (non fast forward)
 ! [rejected]        master     -> sched-devel/master  (non fast forward)

If I rm/add the remote back, all goes fine... until it says rejected.

marge:..git/linux-2.6 # git remote rm x86
marge:..git/linux-2.6 # git remote add x86 git://git.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-x86.git
marge:..git/linux-2.6 # git remote update
Updating origin
Updating linux-next
Updating stable
Updating sched-devel
Updating x86
>From git://git.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-x86
 * [new branch]      base       -> x86/base
 * [new branch]      for-akpm   -> x86/for-akpm
 * [new branch]      for-linus  -> x86/for-linus
 * [new branch]      latest     -> x86/latest
 * [new branch]      master     -> x86/master
 * [new branch]      origin     -> x86/origin
 * [new branch]      testing    -> x86/testing
marge:..git/linux-2.6 #
