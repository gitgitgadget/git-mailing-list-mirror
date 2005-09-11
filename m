From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [ANNOUNCE qgit-0.94]
Date: Sun, 11 Sep 2005 10:33:22 +0200
Message-ID: <20050911083322.GR15165MdfPADPa@greensroom.kotnet.org>
References: <20050911075805.3984.qmail@web26306.mail.ukl.yahoo.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 10:33:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EENHD-0007zQ-0w
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 10:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbVIKIdY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 04:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbVIKIdY
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 04:33:24 -0400
Received: from smtp14.wxs.nl ([195.121.6.28]:20167 "EHLO smtp14.wxs.nl")
	by vger.kernel.org with ESMTP id S932225AbVIKIdX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2005 04:33:23 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp14.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with SMTP id <0IMN00E0393MZ9@smtp14.wxs.nl> for git@vger.kernel.org; Sun,
 11 Sep 2005 10:33:23 +0200 (CEST)
Received: (qmail 20459 invoked by uid 500); Sun, 11 Sep 2005 08:33:22 +0000
In-reply-to: <20050911075805.3984.qmail@web26306.mail.ukl.yahoo.com>
To: Marco Costalba <mcostalba@yahoo.it>
Mail-followup-to: Marco Costalba <mcostalba@yahoo.it>, git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8276>

On Sun, Sep 11, 2005 at 12:58:05AM -0700, Marco Costalba wrote:
> Please, what compiler version and qt dev libraries do you have?

I had installed qt 4.0.1 in the mean time, because apparently
the 3.1.2 I had installed before was too old.
It seems to have installed itself in /usr though.
Removing the -I/usr/include/qt3 from SConstruct _seems_
to make annotate.cpp compile.

But now I get this:

bash-3.00$ QTDIR=/usr/ make
scons
scons: Reading SConscript files ...
scons: done reading SConscript files.
scons: Building targets ...
/usr//bin/uic -o src/commitbase.h src/commitbase.ui
/usr//bin/uic -impl commitbase.h -o src/uic_commitbase.cc src/commitbase.ui
/usr//bin/moc -o src/moc_commitbase.cc src/commitbase.h
uic: File generated with too old version of Qt Designer
File 'src/commitbase.ui' is not valid
scons: *** [src/commitbase.h] Error 1
scons: building terminated because of errors.
make: *** [all] Error 2

How can I create src/commitbase.ui ?

skimo
