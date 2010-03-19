From: Michael Cox <mhcox@bluezoosoftware.com>
Subject: Error building installing on Redhat Linux Server release 5.3 
	(Tikanga)
Date: Fri, 19 Mar 2010 15:36:05 -0600
Message-ID: <d557014b1003191436r4d141825p6c5b8e1b3bee4fc8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 19 22:44:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsjzL-000802-Ga
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 22:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245Ab0CSVoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 17:44:10 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55585 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab0CSVoI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 17:44:08 -0400
Received: by gyg8 with SMTP id 8so1734843gyg.19
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 14:44:06 -0700 (PDT)
Received: by 10.91.19.11 with SMTP id w11mr1033798agi.114.1269034585327; Fri, 
	19 Mar 2010 14:36:25 -0700 (PDT)
X-Originating-IP: [199.64.0.252]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142653>

I downloaded the latest tarball (git-1.7.0.2), configured it, and
make'ed it.  When I did a "make install", the build seemed to work and
most of the install, but I got an error when the installation tried to
use gtar:

make -C templates DESTDIR='' install
make[1]: Entering directory `/users/e477610/exptool/src/git-1.7.0.2/templates'
install -d -m 755 '/home/e477610/exptool/share/git-core/templates'
(cd blt && gtar cf - .) | \
        (cd '/home/e477610/exptool/share/git-core/templates' && umask
022 && gtar xof -)
gtar: This does not look like a tar archive
gtar: Skipping to next header
gtar: Archive contains obsolescent base-64 headers
gtar: Error exit delayed from previous errors
make[1]: *** [install] Error 2
make[1]: Leaving directory `/users/e477610/exptool/src/git-1.7.0.2/templates'
make: *** [install] Error 2

When I try to run "git clone
http://www.kernel.org/pub/scm/git/git.git", I get the following error:

$  git clone http://www.kernel.org/pub/scm/git/git.git
Initialized empty Git repository in /users/e477610/exptool/src/git/.git/
fatal: Unable to find remote helper for 'http'

I assume it's because I didn't finish the install properly.  Any ideas
why the install of the build failed and what I could do to make it
complete?

Michael
