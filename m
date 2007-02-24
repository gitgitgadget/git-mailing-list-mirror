From: walt <wa1ter@myrealbox.com>
Subject: Problems installing as root
Date: Sat, 24 Feb 2007 07:28:56 -0800
Organization: none
Message-ID: <erpljl$ln9$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 24 16:29:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKyq0-00015A-7X
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 16:29:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933506AbXBXP3Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Feb 2007 10:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933510AbXBXP3Z
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Feb 2007 10:29:25 -0500
Received: from main.gmane.org ([80.91.229.2]:56971 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933506AbXBXP3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Feb 2007 10:29:24 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HKypl-00006d-N7
	for git@vger.kernel.org; Sat, 24 Feb 2007 16:29:13 +0100
Received: from adsl-69-234-191-13.dsl.irvnca.pacbell.net ([69.234.191.13])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 24 Feb 2007 16:29:13 +0100
Received: from wa1ter by adsl-69-234-191-13.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 24 Feb 2007 16:29:13 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-191-13.dsl.irvnca.pacbell.net
User-Agent: Thunderbird 3.0a1 (X11/20070223)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40518>

I'm current as of this morning (7bd59dee...) and I'm still seeing
two problems with doing 'make' as myself but 'make install' as
root.

First, 'make install' as root leaves dozens of files owned by root
in my personal source directory.  A minor nit, but inconvenient
during the next 'make'.

Second, this is a more recent problem with 'make install':
make -C git-gui all
make[1]: Entering directory `/usr/local/mnt/wa1ter/src/git/git-gui'
GITGUI_VERSION = 0.6.GITGUI
make[1]: Leaving directory `/usr/local/mnt/wa1ter/src/git/git-gui'
make[1]: Entering directory `/usr/local/mnt/wa1ter/src/git/git-gui'
/bin/sh ./CREDITS-GEN
error: Cannot locate authorship information.
make[1]: *** [CREDITS-FILE] Error 1

Now, CREDITS-FILE was generated during 'make' (I checked) so there
was no need to generate it again during 'make install', yes?

Thanks!
