From: Alenoosh Baghumian <alenoosh@opensourceclub.org>
Subject: git cvsimport problem
Date: Wed, 30 Apr 2008 10:27:11 +0430
Message-ID: <48180A37.7020204@opensourceclub.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 06:57:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr4NH-00021b-1v
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 06:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325AbYD3E4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 00:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbYD3E4K
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 00:56:10 -0400
Received: from static.88-198-8-89.clients.your-server.de ([88.198.8.89]:48779
	"EHLO julius.technotux.org" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750708AbYD3E4K (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Apr 2008 00:56:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by julius.technotux.org (Postfix) with ESMTP id 1DA01F6C0C6
	for <git@vger.kernel.org>; Wed, 30 Apr 2008 06:56:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at julius.technotux.org
Received: from julius.technotux.org ([127.0.0.1])
	by localhost (julius.technotux.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TBZDLgjuZ0Gj for <git@vger.kernel.org>;
	Wed, 30 Apr 2008 06:56:39 +0200 (CEST)
Received: from [192.168.1.2] (unknown [80.191.128.153])
	by julius.technotux.org (Postfix) with ESMTP id 6263CF6C0B5
	for <git@vger.kernel.org>; Wed, 30 Apr 2008 06:56:37 +0200 (CEST)
User-Agent: Icedove 1.5.0.14pre (X11/20080208)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80790>

Hi

I want to import a remote cvs repository to git , here's what I do :

$ mkdir git-test
$ chmod 775 git-test/
$ chmod +s git-test/
$ chmod +t git-test/
$ cd git-test
git-test$ git-cvsimport -k -i -d 
:pserver:anonymous@lib-pkp.lib.sfu.ca:/cvs -C myproj ojs2 -v

output is the following :

Initialized empty Git repository in /home/tux/git-test/myproj/.git/
Running cvsps...

.
.
.

cvs rlog: Logging ojs2/classes/session
cvs rlog: Logging ojs2/classes/site
cvs rlog: Logging ojs2/classes/submission
cvs rlog: Logging ojs2/classes/subscription
cvs rlog: Logging ojs2/classes/subscription/form
cvs rlog: Logging ojs2/classes/tasks

.
.
.
.


cvs rlog: Logging ojs2/pages/layoutEditor
cvs rlog: Logging ojs2/pages/login
cvs rlog: Logging ojs2/pages/manager
cvs rlog: Logging ojs2/pages/oai
cvs rlog: Logging ojs2/pages/payment
cvs rlog: Logging ojs2/pages/proofreader
cvs rlog: Logging ojs2/pages/reviewer
git-cvsimport: fatal: cvsps reported error

and every time I run this , it stops at the same point and gives that error.

Do you have any idea ?
Thanks in advance .

Alenoosh
