From: "Konrad Karl" <kk_konrad@gmx.at>
Subject: git gui blame: git-blame loops at 100% cpu
Date: Sun, 18 Apr 2010 01:13:27 +0200
Message-ID: <20100417231327.162560@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 18 01:13:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3HCt-0001Yo-3J
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 01:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752959Ab0DQXN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 19:13:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:44689 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751999Ab0DQXN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 19:13:28 -0400
Received: (qmail 28509 invoked by uid 0); 17 Apr 2010 23:13:27 -0000
Received: from 88.117.116.4 by www046.gmx.net with HTTP;
 Sun, 18 Apr 2010 01:13:27 +0200 (CEST)
X-Authenticated: #25381063
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
X-Provags-ID: V01U2FsdGVkX18t5lgJorYtzoH3XAzEu2NEWpzKI9pO6ZRIuQBdol
 +t6bEOThMfaHm+mU6Qw8CMlI5E+A4uFOLpdQ== 
X-GMX-UID: rnj8Ash4QEV/IPB+6nRpe/9CNzg2NYL+
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145191>

Dear list,

I have converted one of our Visual Source Safe repos to git (about 47000 commits, about 11 years of history, .git about 200 MB git gc'ed). 

Everything seems to be working fine but git gui blame some_file seems to
procedure correct output in the file viewer but the progress bar stops 
at 1271 of 2783 lines for one specific file and then the git-blame process
consumes 100% cpu. 
 
Plain git blame completes in a fraction of a second just fine.

git-1.7.0.1-1.fc13.x86_64 (Fedora 13). I have also tested git 1.7.0.5
- same behaviour. ditto for the latest msys git in Windows.

perhaps I should mention that most of the source files in the repo are
using crlf line endings.

The hang does not happen on all files but on many - progress percentage 
varying.

Konrad


-- 
Sicherer, schneller und einfacher. Die aktuellen Internet-Browser -
jetzt kostenlos herunterladen! http://portal.gmx.net/de/go/atbrowser
