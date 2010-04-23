From: Konrad Karl <kk_konrad@gmx.at>
Subject: multiple .gitignore and friends  in same workdir possible?
Date: Fri, 23 Apr 2010 14:46:40 +0200
Message-ID: <14436.0321261503$1272026818@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 23 14:46:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5IHU-0005xB-W9
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 14:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757340Ab0DWMqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 08:46:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:48695 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757200Ab0DWMqp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 08:46:45 -0400
Received: (qmail invoked by alias); 23 Apr 2010 12:46:43 -0000
Received: from dinoc9.indmath.uni-linz.ac.at (EHLO localhost) [140.78.117.79]
  by mail.gmx.net (mp047) with SMTP; 23 Apr 2010 14:46:43 +0200
X-Authenticated: #25381063
X-Provags-ID: V01U2FsdGVkX19GApNZbihGQilRXTra4pb/oflm79wAnjVdWPnMRZ
	77qRVgbqyfAvNJ
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-08-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71999999999999997
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145614>

Hi,

while trying to move our Windows people from VSS to git i am
facing the following problem:

I want to have two (or three) git repos wich all share the
same working directory (this is manageable by environment variables),
one for the real source files and the other for 3'rd party binaries 
(*.dll, *.lib + perhaps include files for those)
and perhaps a third one for debugging symbol files (*.pdb and such)

In order to have .gitignore (and .gitattributes) files versioned
and also distributed on git clone they need to be inside the
work dir. Unfortunately the sources and binaries are co-located
inside the work dir subfolders - for historic reasons.

So i would like to have a mechanism to be able to specify different
filenames for .gitignore and .gitattributes  without having to
recompile git, perhaps by an environment variable.
(e.g by a suffix like .gitignore.src .gitignore.bin etc)

Is this currently possible or am I missing something? It would ease
my task a lot. 

Greetings,
Konrad
