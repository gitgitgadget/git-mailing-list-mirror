From: pasky@suse.cz
Subject: [PATCH 0/3] [RFC] Support for publishing projects at central site
Date: Thu, 25 Sep 2008 01:57:34 +0200
Message-ID: <20080924235734.697978308@suse.cz>
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 25 02:03:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KieKM-0003We-HK
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 02:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489AbYIYACJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 20:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752206AbYIYACJ
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 20:02:09 -0400
Received: from 132-201.104-92.cust.bluewin.ch ([92.104.201.132]:50386 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751866AbYIYACI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 20:02:08 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id 54F522AC8DA; Thu, 25 Sep 2008 02:01:56 +0200 (CEST)
User-Agent: quilt/0.46_cvs20080326-19.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96719>

This series implements a special variant of the 'add remote' dialog
designed for publishing new projects at a central site - it fixes
certain parameters and launches web browser during the push for
project registration in a repo.or.cz-like fashion. The feature is
aimed especially at corporate Git deployment.

This is not really meant for as-is application, of course, but more
to see if people think it is good idea to have this kind of functionality
in git-gui at all and how generic it should be. This mini-series depends
on pretty much all the other patches I have submitted tonight.
