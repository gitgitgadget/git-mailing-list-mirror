From: Resul Cetin <Resul-Cetin@gmx.net>
Subject: Specifying default checkout branch in url
Date: Thu, 11 Dec 2008 12:21:36 +0100
Message-ID: <200812111221.36561.Resul-Cetin@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 11 12:28:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAjiL-0003IG-1H
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 12:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754925AbYLKLVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 06:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753867AbYLKLVk
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 06:21:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:57388 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751130AbYLKLVk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 06:21:40 -0500
Received: (qmail invoked by alias); 11 Dec 2008 11:21:37 -0000
Received: from unknown (EHLO rowo) [89.246.222.158]
  by mail.gmx.net (mp069) with SMTP; 11 Dec 2008 12:21:37 +0100
X-Authenticated: #13824512
X-Provags-ID: V01U2FsdGVkX18itcpGVA8ioUyIraLRJ8JoNI9D0BqzaNiG4hMhGF
	+ydKSt3jQOzylI
User-Agent: KMail/1.10.3 (Linux/2.6.26-1-amd64; KDE/4.1.3; x86_64; ; )
Content-Disposition: inline
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102794>

Hi,
I have the problem that I want to checkout a specific branch in a git-clone 
run. Someone at the debian-mentors mailing list[1] has suggested to use a url 
like git://git.myserver.org/project.git#branchname to checkout a branch with 
the name branchname by default. But this doesn't seem to work. Is there 
already another way to encode this in the url?
More information why I cannot change HEAD of the repository can be found in a 
bug report against debcheckout[2].

Regards,
	Resul

[1] http://article.gmane.org/gmane.linux.debian.devel.mentors/34421
[2] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=508433
