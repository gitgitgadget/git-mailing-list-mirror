From: drafnel@gmail.com
Subject: Make mktag a builtin
Date: Thu,  8 May 2008 21:19:44 -0500
Message-ID: <2127798.1210299520397.JavaMail.teamon@b301.teamon.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 04:34:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuIQo-00053E-55
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 04:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755072AbYEICdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 22:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754788AbYEICdJ
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 22:33:09 -0400
Received: from mailproxy01.teamon.com ([64.85.68.137]:18864 "EHLO
	b301.teamon.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755072AbYEICdI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 22:33:08 -0400
X-Greylist: delayed 866 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 May 2008 22:33:07 EDT
Received: from b301.teamon.com (localhost [127.0.0.1])
	by b301.teamon.com (8.11.7 DSN_MOD/8.11.7) with ESMTP id m492IeG10292;
	Fri, 9 May 2008 02:18:40 GMT
X-Mailer: git-send-email 1.5.5.67.g9a49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81588>



This series makes mktag a builtin and unifies the verification of
created tags between git-tag and git-mktag.

 Makefile      |    2 +-
 builtin-tag.c |  183 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h     |    1 +
 git.c         |    1 +
 mktag.c       |  180 --------------------------------------------------------
 5 files changed, 186 insertions(+), 181 deletions(-)

-brandon
