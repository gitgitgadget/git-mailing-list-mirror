From: Philip Oakley <philipoakley@iee.org>
Subject: [RFC/PATCH 0/2] Improve rebase documenation
Date: Sun, 19 May 2013 12:52:07 +0100
Message-ID: <1368964329-1600-1-git-send-email-philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 19 13:52:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue29k-0005Zj-E0
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 13:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431Ab3ESLv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 07:51:58 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:56289 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754178Ab3ESLv5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 07:51:57 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AtIZAMa7mFFZ8YNG/2dsb2JhbABbgwiDArdvhnUEfhd0gnw7gQIkiCScLZ9JjgSEeAOoeIMQOw
X-IronPort-AV: E=Sophos;i="4.87,703,1363132800"; 
   d="scan'208";a="429336251"
Received: from host-89-241-131-70.as13285.net (HELO localhost) ([89.241.131.70])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 19 May 2013 12:51:56 +0100
X-Mailer: git-send-email 1.8.1.msysgit.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224866>

Recent discussions have shown that rebase isn't as well understood as
as perhaps it should be for the basic user. 

Add a softer introductory paragraph to the man page description, and
in the second patch, add a second paragraph explaining the build up of
the command so that users have a historical context in which to
rationalise the command structure.

The second patch/paragraph will probably need the quoting checking as
to which are quoting the generic command and which are the same text
as a command example.

Basic wording is borrowed from on-list clarifications.

Philip Oakley (2):
  Doc rebase: Describe rebase as excluding merge commits
  Doc rebase: describe the priority of published work

 Documentation/git-rebase.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
1.8.1.msysgit.1
