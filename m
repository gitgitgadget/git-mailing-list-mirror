From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH V3 0/2] Extend dot repository documentation
Date: Sat, 21 Sep 2013 16:11:07 +0100
Message-ID: <1379776269-4496-1-git-send-email-philipoakley@iee.org>
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 21 17:10:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNOpT-0007pg-3v
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 17:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596Ab3IUPKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 11:10:12 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:59965 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752271Ab3IUPKK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Sep 2013 11:10:10 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsGAGG2PVJOl3GZ/2dsb2JhbABbgwcBrleMb4cjgRoXdIMCIxiBAiQBiBu6fI9lhCUDqXODJTs
X-IPAS-Result: AvsGAGG2PVJOl3GZ/2dsb2JhbABbgwcBrleMb4cjgRoXdIMCIxiBAiQBiBu6fI9lhCUDqXODJTs
X-IronPort-AV: E=Sophos;i="4.90,952,1371078000"; 
   d="scan'208";a="442604117"
Received: from host-78-151-113-153.as13285.net (HELO localhost) ([78.151.113.153])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 21 Sep 2013 16:10:08 +0100
X-Mailer: git-send-email 1.8.1.msysgit.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235123>

This completes the patch series on adding short notes about
the dot repository capability in git, which is a consequence of
the relative path '.' being used as a repository URL.

The previous 2/3 was accepted and is not repeated here.
Patch 3/3 is now an ammendment 1/2 
Patch 1/3 is corrected and is now 2/2

The first patch is a minor update that give the dot repository note
its own bullet, and updates the wording to imply repository discovery
from the current directory.

The second patch updates the Git URLs section to include a specific
note about relative paths and its use as a dot repository.

It should be noted that repository discovery is not well covered in
the documentation but is distributed among a number sections. This
could do with a small section somewhere..

Philip Oakley (2):
  doc: command line interface (cli) dot-repository dwimmery
  Doc URLs: relative paths imply the dot-respository

 Documentation/gitcli.txt | 8 ++++----
 Documentation/urls.txt   | 8 ++++++++
 2 files changed, 12 insertions(+), 4 deletions(-)

-- 
1.8.1.msysgit.1
