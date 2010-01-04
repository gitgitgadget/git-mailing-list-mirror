From: Bas Driessen <bas.driessen@xobas.com>
Subject: Re: git file sharing/versioning.
Date: Mon, 04 Jan 2010 14:47:06 +1000
Organization: Xobas Software
Message-ID: <1262580426.9041.21.camel@ams.xobas.net>
References: <1262579824.9041.15.camel@ams.xobas.net>
	 <1262580346.9041.20.camel@ams.xobas.net>
Reply-To: bas.driessen@xobas.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 04 05:47:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NReqd-0004IV-1j
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 05:47:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919Ab0ADErO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jan 2010 23:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752869Ab0ADErO
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jan 2010 23:47:14 -0500
Received: from atl.xobas.net ([74.207.232.85]:35879 "EHLO atl.xobas.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752861Ab0ADErO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jan 2010 23:47:14 -0500
Received: from [192.168.1.14] (ppp214-42.static.internode.on.net [59.167.214.42])
	(authenticated bits=0)
	by atl.xobas.net (8.13.8/8.13.8) with ESMTP id o044l7hE021597
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 4 Jan 2010 14:47:10 +1000
In-Reply-To: <1262580346.9041.20.camel@ams.xobas.net>
X-Mailer: Evolution 2.26.3 (2.26.3-1.fc11) 
X-xobas-MailScanner-Information: Please contact the ISP for more information
X-xobas-MailScanner-ID: o044l7hE021597
X-xobas-MailScanner: Found to be clean
X-xobas-MailScanner-From: bas.driessen@xobas.com
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136091>

Hello,

I have a project where I have 2 trees with several hundreds of files.
Let's call them tree1 and tree2. Only a handful of files in tree2 are
different. What is the best way to set this up in GIT? Basically most
files in tree2 should act as a symbolic link to tree1. So if the file
changes in tree 1, it automatically changes in tree 2. Obviously, I
don't want to store everything double. Branching does not appear to be
an option as changes in tree1 would not be visible in the tree2 branch. 

Any advise of how to set this up?

Thanks in advance for your help.

Bas.



-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.
