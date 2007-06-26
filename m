From: Gerrit Pape <pape@smarden.org>
Subject: git-svn: libsvn-perl_1.4.4 and do_switch()
Date: Tue, 26 Jun 2007 13:37:04 +0000
Message-ID: <20070626133704.24521.qmail@a4f750d1ddce1f.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 26 15:36:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3BDs-00079x-Kq
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 15:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754906AbXFZNgr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 09:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754780AbXFZNgr
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 09:36:47 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:45352 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754575AbXFZNgq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 09:36:46 -0400
Received: (qmail 24522 invoked by uid 1000); 26 Jun 2007 13:37:04 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50962>

Hi, on Debian unstable the current version of libsvn-perl is 1.4.4dfsg1.
With this version git-svn uses do_switch instead of do_update, which
seems to not work properly, please see

 http://bugs.debian.org/430091

on how to reproduce the problem.  The following also is showing a
problem, as it blocks in read() after do_switch

 git svn clone -T trunk -b branches -t tags \
   svn://bruce-guenter.dyndns.org/bglibs

I'm not sure whether this is a git-svn or a subversion problem, thanks
for your input.

Regards, Gerrit.
