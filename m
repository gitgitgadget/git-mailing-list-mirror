From: Philip Oakley <philipoakley@iee.org>
Subject: [RFC/PATCH 0/2] Test the Git version string
Date: Sun, 14 Apr 2013 15:27:24 +0100
Message-ID: <1365949646-1988-1-git-send-email-philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 14 16:27:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URNu8-00034e-8S
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 16:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837Ab3DNO1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 10:27:23 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:43307 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751600Ab3DNO1X (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Apr 2013 10:27:23 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Au0YACu8alFZ8Yth/2dsb2JhbAAuIoMGATU0ghO3foZ2BIEDF3SCfDuBAiSIK5lNoCaNXxuEZQOoFoMMO4Eu
X-IronPort-AV: E=Sophos;i="4.87,471,1363132800"; 
   d="scan'208";a="572180598"
Received: from host-89-241-139-97.as13285.net (HELO localhost) ([89.241.139.97])
  by out1.ip06ir2.opaltelecom.net with ESMTP; 14 Apr 2013 15:27:21 +0100
X-Mailer: git-send-email 1.8.1.msysgit.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221137>

In $gmane/217004 I was noted that the git version string is used
in the wild for confirming which git version is in use.

This patch series seeks to add tests for the version string format
and document it.

The key questions to be answered are:
* should the test be inside t0000, or somewhere else?
* should the version string be limited to one line, <80 characters?
* how to format the asciidoc of the ERE.

Philip Oakley (2):
  test git version string
  Doc: State the exact git version string

 Documentation/git.txt | 4 ++++
 t/t0000-basic.sh      | 8 ++++++++
 2 files changed, 12 insertions(+)

-- 
1.8.1.msysgit.1
