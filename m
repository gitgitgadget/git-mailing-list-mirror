From: Mark Rada <marada@uwaterloo.ca>
Subject: [PATCHv6 0/7] Gitweb: fill in missing parts of minify support
Date: Fri, 02 Apr 2010 20:32:54 -0400
Message-ID: <4BB68CB6.2000704@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 03 02:33:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxrIw-0006x1-Cs
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 02:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128Ab0DCAdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 20:33:33 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:54119 "EHLO
	mailchk-m05.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752419Ab0DCAdc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Apr 2010 20:33:32 -0400
Received: from karakura.local (bas1-toronto01-1177657512.dsl.bell.ca [70.49.160.168])
	(authenticated bits=0)
	by mailchk-m05.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id o330Wt3N015616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 Apr 2010 20:32:56 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
X-UUID: bacff9fc-0bc5-4c01-8869-968c383ae33c
X-Miltered: at mailchk-m05 with ID 4BB68CB7.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.2 at mailchk-m05
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m05.uwaterloo.ca [129.97.128.141]); Fri, 02 Apr 2010 20:32:57 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143868>

Minify support was added to gitweb.js, but that build feature was not
really fleshed out too much; let's get changed!

Added the missing ignore and clean rules, updated the documentation,
added support in the autoconfigure script, enabled minification of
gitweb.css, and fixed git-instaweb to use the minified files when they
are generated.

I went ahead and changed things based on the feedback that I have
received from the last revision. Changes are noted in individual patches.

Jakub, thanks for reviewing the patches last round, everything should
be all fixed up this around.

Mark Rada (6):
	Gitweb: add ignore and clean rules for minified files
	Gitweb: add support for minifying gitweb.css
	Gitweb: add autoconfigure support for minifiers
	instaweb: add minification awareness
	gitweb: add documentation to INSTALL regarding gitweb.js
	gitweb: update INSTALL to use shorter make target


 .gitignore      |    1 +
 Makefile        |   32 +++++++++++++++++++++++---------
 configure.ac    |   20 ++++++++++++++++++++
 git-instaweb.sh |    6 ++++--
 gitweb/INSTALL  |   26 ++++++++++++++++----------
 gitweb/Makefile |   30 +++++++++++++++++-------------
 gitweb/README   |    3 ++-
 7 files changed, 83 insertions(+), 35 deletions(-)


-- 
Mark Rada (ferrous26)
marada@uwaterloo.ca
