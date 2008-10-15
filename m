From: Stephan Springl <springl-git@bfw-online.de>
Subject: BUG: git rev-list segfaults
Date: Wed, 15 Oct 2008 21:00:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0810152034040.7572@rosenkohl.springl.homeip.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463794926-201686720-1224097215=:7572"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 15 22:23:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqCtZ-0005AV-O4
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 22:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbYJOUVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 16:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753217AbYJOUVu
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 16:21:50 -0400
Received: from mail.bfw-online.de ([62.245.186.164]:40225 "EHLO
	mail.bfw-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051AbYJOUVt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 16:21:49 -0400
X-Greylist: delayed 4891 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Oct 2008 16:21:49 EDT
Received: from rosenkohl.bfw.de
	([192.168.18.67] helo=rosenkohl ident=Debian-exim)
	by mail.bfw-online.de with esmtp (Exim 4.69)
	(envelope-from <springl-git@bfw-online.de>)
	id 1KqBbU-00088h-Jm; Wed, 15 Oct 2008 21:00:16 +0200
Received: from localhost ([127.0.0.1] ident=stephan)
	by rosenkohl with esmtp (Exim 4.69)
	(envelope-from <springl-git@bfw-online.de>)
	id 1KqBbU-0001zy-3f; Wed, 15 Oct 2008 21:00:16 +0200
X-SA-Exim-Connect-IP: 192.168.18.67
X-SA-Exim-Mail-From: springl-git@bfw-online.de
X-SA-Exim-Scanned: No (on mail.bfw-online.de); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98318>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463794926-201686720-1224097215=:7572
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

git rev-list segfaults when crossing a merge commit when given=20
--bisect-vars and --first-parent.  This is on branches master, next, and=20
pu from git://git.kernel.org/pub/scm/git/git.git right now.

Reproduce it using git's git repository like this:

git rev-list --bisect-vars --first-parent \
   80bfd76af7ac817d4a4b9b7d54485..67faaaba8338cf59c212ce5239eeb

Without either --first-parent or --bisect-vars it works.

Thank you for your work on git.  When we introduced CVS in our development=
=20
some ten years ago, after a few weeks we could not imagine how we could=20
have got any work done without it.  When we started using git, we found=20
this former step was tiny compared to the increase in productivity we=20
experienced switching from CVS to git.

Regards
Stephan
--=20
Stephan Springl                           BFW Werner V=F6lk GmbH
                                           Energiemesstechnik & Service
                                           Drosselgasse 5
                                           D-82166 Gr=E4felfing
                                           Germany
                                           Gesch=E4ftsf=FChrer: Georg F. V=
=F6lk
                                           HRB 44779 Amtsgericht M=FCnchen
                                           USt.-ID: DE129301566
---1463794926-201686720-1224097215=:7572--
