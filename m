From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: [ANNOUNCE] GIT 1.5.2
Date: Sun, 20 May 2007 11:37:32 +0200
Message-ID: <20070520093732.GA5015@cip.informatik.uni-erlangen.de>
References: <7vsl9rq2u2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 11:37:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HphrC-0007gu-EI
	for gcvg-git@gmane.org; Sun, 20 May 2007 11:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755369AbXETJhf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 05:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754488AbXETJhf
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 05:37:35 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:60175 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755369AbXETJhe (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 May 2007 05:37:34 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id A5E283F376; Sun, 20 May 2007 11:37:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vsl9rq2u2.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47802>

Hello,

> The latest feature release GIT 1.5.2 is available

It does not compile for me on Solaris 10 with forte 12 with the
following error. Any ideas?

export PATH="/opt/forte12/SUNWspro/bin:/usr/ccs/bin:/usr/bin:/usr/openwin/bin"

cd git-1.5.2
/opt/csw/bin/gmake \
        CFLAGS='-O' \
        CC=/opt/forte12/SUNWspro/bin/cc \
        DESTDIR=/var/tmp/sithglan-pkg/git-1.5.2-buildroot \
        ETC_GITCONFIG=/etc/gitconfig \
        INSTALL=/opt/csw/bin/ginstall \
        NO_CURL=1 \
        NO_EXPAT=1 \
        NO_ICONV=1 \
        NO_OPENSSL=1 \
        NO_TCLTK=1 \
        TAR=/opt/csw/bin/gtar \
        mandir=/usr/share/man \
        prefix=/usr \
        install
...
gmake[2]: Leaving directory `/var/tmp/sithglan-pkg/git-1.5.2/templates'
/opt/forte12/SUNWspro/bin/cc -O  -D__EXTENSIONS__ -DNO_OPENSSL -DNO_ICONV -DSHA1_HEADER='"mozilla-sha1/sha1.h"' -DETC_GITCONFIG='"/etc/gitconfig"' -DNO_STRCASESTR -o test-chmtime   test-chmtime.c
Undefined                       first referenced
symbol                             in file
die                                 test-chmtime.o
release_pack_memory                 test-chmtime.o
sane_ctype                          test-chmtime.o
ld: fatal: Symbol referencing errors. No output written to test-chmtime
gmake[1]: *** [test-chmtime] Error 1
gmake[1]: Leaving directory `/var/tmp/sithglan-pkg/git-1.5.2'


        Thomas
