From: Claudio Scordino <cloud.of.andor@gmail.com>
Subject: Git error on Cygwin
Date: Mon, 30 Jul 2007 19:18:47 +0200
Message-ID: <46AE1D77.8040609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 31 09:29:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFmAR-0004pb-1K
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 09:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680AbXGaH3A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 03:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbXGaH3A
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 03:29:00 -0400
Received: from ms01.sssup.it ([193.205.80.99]:54997 "EHLO sssup.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752482AbXGaH2t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 03:28:49 -0400
Received: from [193.205.82.7] (HELO gandalf.sssup.it)
  by sssup.it (CommuniGate Pro SMTP 4.1.8)
  with ESMTP-TLS id 32422669 for git@vger.kernel.org; Tue, 31 Jul 2007 09:19:35 +0200
Received: from [10.30.3.110] ([10.30.3.110])
	by gandalf.sssup.it (8.12.10/8.12.10) with ESMTP id l6V6Prqi004690
	for <git@vger.kernel.org>; Tue, 31 Jul 2007 08:25:54 +0200
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54324>

Hi all,

   I just installed cygwin on Windows XP and I have the following error when
using git-clone.

(Consider that the same command on the same repository works on Linux).

Regards,

            Claudio


$ git-clone <username>@<host>:/<path>/<project>
Initialized empty Git repository in /home/Claudio/<project>/.git/
<username>@<host>'s password:
remote: Generating pack...
remote: Done counting 30387 objects.
remote: Deltifying 30387 objects...
remote:  100% (30387/30387) done
Indexing 30387 objects...
remote: Total 30387 (delta 4446), reused 30188 (delta 4351)
  100% (30387/30387) done
Resolving 4446 deltas...
  100% (4446/4446) done
       3 [main] git-read-tree 2160 C:\cygwin\bin\git-read-tree.exe: *** fatal
error - could not load shell32, Win32 error 487
/usr/bin/git-clone: line 404:  2160 Hangup                  git-read-tree -m -u
$v HEAD HEAD
