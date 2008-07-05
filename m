From: Martin <html-kurs@gmx.de>
Subject: remote does not support deleting refs
Date: Sat, 05 Jul 2008 23:22:10 +0200
Message-ID: <486FE602.3060301@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 05 23:24:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFFEv-00016n-1x
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 23:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914AbYGEVWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 17:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752941AbYGEVWM
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 17:22:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:60963 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752409AbYGEVWL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 17:22:11 -0400
Received: (qmail invoked by alias); 05 Jul 2008 21:22:09 -0000
Received: from p54B213DF.dip0.t-ipconnect.de (EHLO [192.168.0.116]) [84.178.19.223]
  by mail.gmx.net (mp008) with SMTP; 05 Jul 2008 23:22:09 +0200
X-Authenticated: #4107867
X-Provags-ID: V01U2FsdGVkX1+HAfNXlIKH2W3xuzGIyc2RppGBn63P92Uc0l5v03
	544gE9TA2QWIR+
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87468>

Hi,

I tried to setup a central git repository. Access is via ssh.
How do I delete a remote branch? If I try it using
 > git branch -d -r origin/testbranch
 > git push origin :refs/heads/testbranch
I get the error

To ssh://myserver.com/my/path/to/repository
  ! [rejected]        testbranch (remote does not support deleting refs)
error: failed to push some refs to 
'ssh://myserver.com/my/path/to/repository'

So how do I setup my remote repository to allow deleting remote branches?

Thanks,
Martin
