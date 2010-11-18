From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 0/3] Improvements to mergetool-lib
Date: Thu, 18 Nov 2010 11:40:16 +0100
Message-ID: <4CE50290.90600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 18 11:40:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ1uw-0003oh-MM
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 11:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756186Ab0KRKkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 05:40:32 -0500
Received: from lo.gmane.org ([80.91.229.12]:35515 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210Ab0KRKkb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 05:40:31 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PJ1ul-0003hs-Ok
	for git@vger.kernel.org; Thu, 18 Nov 2010 11:40:27 +0100
Received: from berry.zib.de ([130.73.68.143])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 11:40:27 +0100
Received: from sschuberth by berry.zib.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 11:40:27 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: berry.zib.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161659>

This small series adds Beyond Compare 3 as a diff / merge tool
and performs some minor improvements.

Sebastian Schuberth (3):
  mergetool--lib: Sort tools alphabetically for easier lookup
  mergetool--lib: Add Beyond Compare 3 as a tool
  mergetool--lib: Add the proper executable name for ECMerge

 Documentation/git-difftool.txt         |    4 +-
 Documentation/git-mergetool.txt        |    4 +-
 Documentation/merge-config.txt         |    8 +-
 contrib/completion/git-completion.bash |    2 +-
 git-gui/lib/mergetool.tcl              |  101 +++++++------
 git-mergetool--lib.sh                  |  243 +++++++++++++++++---------------
 6 files changed, 195 insertions(+), 167 deletions(-)

-- 
1.7.3.2.msysgit.11
