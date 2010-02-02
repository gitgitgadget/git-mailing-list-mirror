From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 0/2] gitweb misc fixes mkII
Date: Tue,  2 Feb 2010 13:56:52 -0800
Message-ID: <1265147814-13284-1-git-send-email-warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 22:57:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcQkP-0002eN-MT
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 22:57:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756881Ab0BBV5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 16:57:05 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:42434 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754430Ab0BBV5E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 16:57:04 -0500
Received: from localhost.localdomain (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o12Luseu009001
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 2 Feb 2010 13:57:03 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.6.6
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Tue, 02 Feb 2010 13:57:03 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138765>

This is a new patch series dealing with the slightly controversial
option to force version matching, and this adds a new patch that solves 
a minor issue discovered on kernel.org.

John 'Warthog9' Hawley (2):
  gitweb: Add an option to force version match
  gitweb: Fix chop_str to allow for & characters in strings

 gitweb/README                            |    5 ++++
 gitweb/gitweb.perl                       |   33 ++++++++++++++++++++++++++++-
 t/gitweb-lib.sh                          |    1 +
 t/t9501-gitweb-standalone-http-status.sh |   27 ++++++++++++++++++++++++
 4 files changed, 64 insertions(+), 2 deletions(-)
