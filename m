From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: REQUEST-PULL: some msysgit build patches for upstream
Date: Fri, 07 Jun 2013 07:50:15 +0100
Message-ID: <87sj0uwh20.fsf@fox.patthoyts.tk>
Reply-To: patthoyts@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 07 08:56:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukqak-0004CB-5w
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 08:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462Ab3FGG4B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 02:56:01 -0400
Received: from know-smtprelay-omc-1.server.virginmedia.net ([80.0.253.65]:36081
	"EHLO know-smtprelay-omc-1.server.virginmedia.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752042Ab3FGG4A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 02:56:00 -0400
X-Greylist: delayed 341 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Jun 2013 02:55:59 EDT
Received: from fox.patthoyts.tk ([94.171.229.22])
	by know-smtprelay-1-imp with bizsmtp
	id lJqG1l0020VeUS601JqGEX; Fri, 07 Jun 2013 07:50:17 +0100
X-Originating-IP: [94.171.229.22]
X-Spam: 0
X-Authority: v=2.0 cv=RN7rhPe+ c=1 sm=1 a=qXJDgLqI18Q8M6O+O33hhA==:17
 a=F0HhOJWMmYsA:10 a=9Yl5yNQ7HcsA:10 a=CtgcEeagiGAA:10 a=kj9zAlcOel0A:10
 a=FP58Ms26AAAA:8 a=mTsz9k-Ffh8A:10 a=NEAV23lmAAAA:8 a=kls9lMIUJHy9MCaZbnkA:9
 a=CjuIK1q_8ugA:10 a=XCGtuk3KgoEOCl3j:21 a=JQmBSrSta2HgJSZm:21
 a=qXJDgLqI18Q8M6O+O33hhA==:117
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id B663122ECD; Fri,  7 Jun 2013 07:50:15 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226610>

The following changes since commit b5c26758639cd934780620d4dd16854c8fdf8c34:

  Sync with maint (2013-06-03 13:00:09 -0700)

are available in the git repository at:


  http://github.com/msysgit/git tags/post183-for-junio

for you to fetch changes up to 65db0443710f59a1c05a85688cdccc215ff48333:

  Set the default help format to html for msys builds. (2013-06-04 10:12:32 +0100)

----------------------------------------------------------------
Collected msysgit build patches for upstream

This set of patches collects a number of build fixes that have been
used on the msysgit port for a while and merging upstream should
simplify future maintenance.

----------------------------------------------------------------
Johannes Schindelin (2):
      Define NO_GETTEXT for Git for Windows
      Windows resource: handle dashes in the Git version gracefully

Pat Thoyts (3):
      Provide a Windows version resource for the git executables.
      Ensure the resource file is rebuilt when the version changes.
      Set the default help format to html for msys builds.

Pierre le Riche (1):
      msysgit: Add the --large-address-aware linker directive to the makefile.

Sebastian Schuberth (1):
      Makefile: Do not use OLD_ICONV on MINGW anymore

 .gitignore       |  1 +
 Makefile         |  8 +++++++-
 config.mak.uname |  6 +++++-
 git.rc           | 22 ++++++++++++++++++++++
 4 files changed, 35 insertions(+), 2 deletions(-)
 create mode 100644 git.rc
