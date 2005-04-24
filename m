From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: Humble request of 'git' developers
Date: Sun, 24 Apr 2005 06:47:31 +0100
Message-ID: <E1DPZxr-0000a3-00@skye.ra.phy.cam.ac.uk>
References: <426AAB65.2060401@pobox.com>
Cc: Chris Wedgwood <cw@f00f.org>, git@vger.kernel.org,
	"David A. Wheeler" <dwheeler@dwheeler.com>
X-From: git-owner@vger.kernel.org Sun Apr 24 07:43:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPZtZ-00025t-Hq
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 07:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbVDXFru (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 01:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbVDXFru
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 01:47:50 -0400
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:6368 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262269AbVDXFrj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 01:47:39 -0400
Received: from skye.ra.phy.cam.ac.uk ([131.111.48.158] ident=mail)
	by mraos.ra.phy.cam.ac.uk with esmtp (Exim 4.43)
	id 1DPZxs-0003OH-D4; Sun, 24 Apr 2005 06:47:32 +0100
Received: from sanjoy by skye.ra.phy.cam.ac.uk with local (Exim 3.35 #1)
	id 1DPZxr-0000a3-00; Sun, 24 Apr 2005 06:47:31 +0100
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: Your message of "Sat, 23 Apr 2005 16:09:09 EDT."
             <426AAB65.2060401@pobox.com> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[Added David Wheeler to the CC given his (admirable) pushes for wide
standards compliance.]

>>>Just have one 'git' script, which looks in /usr/local/libexec/git
> [or] /usr/libexec/git

The FHS <http://www.pathname.com/fhs/pub/fhs-2.3.html> looks like it
recommends a /usr/lib/git directory:

  /usr/lib : Libraries for programming and packages

  Purpose
     /usr/lib includes object files, libraries, and internal binaries that
     are not intended to be executed directly by users or shell scripts.

     Applications may use a single subdirectory under /usr/lib. If an
     application uses a subdirectory, all architecture-dependent data
     exclusively used by the application must be placed within that  
     subdirectory.

My Debian sarge system has one libexec-like directory, but it follows
the FHS:

$ locate '/usr*libexec*'
/usr/lib/php4/libexec

-Sanjoy
