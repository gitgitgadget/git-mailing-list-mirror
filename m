From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: t5801-remote-helpers.sh fails
Date: Sat, 10 Nov 2012 14:48:23 +0100
Message-ID: <509E5B27.5080808@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: felipe.contreras@gmail.com, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 10 14:48:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXBQM-0007fo-RR
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 14:48:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444Ab2KJNs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 08:48:26 -0500
Received: from mout.web.de ([212.227.17.12]:49607 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810Ab2KJNsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 08:48:25 -0500
Received: from birne.lan ([195.67.191.23]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0MWS3S-1TqMzl3LHW-00X2pd; Sat, 10 Nov 2012 14:48:23 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
X-Provags-ID: V02:K0:Hdts9qfz6lEKQwrwLoMGUsCTiYw012BV8p0nIrDl8V9
 A13JlYj/dmABKCmM7/5ox/li0n/yGeZgwwjPD8IfxgElQkjXgL
 qgTzYqq+mw9q6xiOywimx3xQfmK85zpu1Snt6/BrLaM5KrdKtm
 C7i6MnygF9bM8CjN6dBUdoMInC6HDQXW1x8P7cjtq+NHmREPoH
 INMp3ot0sqLhRkgkkErRQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209275>

Hej,
on peff/pu t5801 fails, the error is in git-remote-testgit, please see below.

That's on my Mac OS X box.

I haven't digged further into the test case, but it looks as if 
"[-+]A 	make NAMEs associative arrays"
is not supported on this version of bash.
/Torsten


/Users/tb/projects/git/git.peff/git-remote-testgit: line 64: declare: -A: invalid option
declare: usage: declare [-afFirtx] [-p] [name[=value] ...]
/Users/tb/projects/git/git.peff/git-remote-testgit: line 66: refs/heads/master: division by 0 (error token is "/master")
error: fast-export died of signal 13
fatal: Error while running fast-export
