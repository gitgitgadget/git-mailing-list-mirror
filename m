From: Thomas Koch <thomas.koch@ymc.ch>
Subject: how does git svn work
Date: Mon, 30 Jun 2008 21:57:21 +0200
Organization: young media concepts
Message-ID: <200806302157.21567.thomas.koch@ymc.ch>
Reply-To: thomas.koch@ymc.ch
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 30 22:23:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDPtz-00011W-J5
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 22:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755784AbYF3UWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 16:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755400AbYF3UWJ
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 16:22:09 -0400
Received: from hera.ymc.ch ([217.113.37.19]:42375 "EHLO hera.ymc.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752427AbYF3UWI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 16:22:08 -0400
X-Greylist: delayed 1479 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Jun 2008 16:22:07 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by hera.ymc.ch (Postfix) with ESMTP id 885C430B2C
	for <git@vger.kernel.org>; Mon, 30 Jun 2008 21:57:23 +0200 (CEST)
Received: from hera.ymc.ch ([127.0.0.1])
	by localhost (mail.volano.ch [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S9QmyEPcpmYs for <git@vger.kernel.org>;
	Mon, 30 Jun 2008 21:57:23 +0200 (CEST)
Received: from jona.local (225-18.203-62.cust.bluewin.ch [62.203.18.225])
	by hera.ymc.ch (Postfix) with ESMTP id 507243082E
	for <git@vger.kernel.org>; Mon, 30 Jun 2008 21:57:23 +0200 (CEST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86937>

Hi,

is there a document explaining the internals of GIT-SVN? I'd like to
know, which SVN commands are executed in the background and how git-svn
recognizes branch creation in SVN.

In particular I want to follow the repository at:
http://pubsvn.ez.no/nextgen/

The layout is like
/trunk
/stable
  |- 4.0
  |- 3.9
  |- 3.8
  ...
/releases
  |- 4.0
  |- 4.0r1
  |- 3.9
  |- 3.9r1
  |- 3.9r2


I do not know, whether git-svn can create branches automatically for
each directory under /stable and one main branch for trunk or whether I
need to create one svn-remote definition for every svn directory I want
to track.


Best regards,
-- 
Thomas Koch, Software Developer
http://www.koch.ro

Young Media Concepts GmbH
Sonnenstr. 4
CH-8280 Kreuzlingen
Switzerland

Tel    +41 (0)71 / 508 24 86
Fax    +41 (0)71 / 560 53 89
Mobile +49 (0)170 / 753 89 16
Web    www.ymc.ch
