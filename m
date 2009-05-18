From: Pedro de Barros <pedrocontebarros@gmail.com>
Subject: msysgit - cygcrypto-0.9.8.dll was not found!!
Date: Mon, 18 May 2009 09:34:21 +0000 (UTC)
Message-ID: <loom.20090518T092421-992@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 11:40:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5zKW-0005WG-Nt
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 11:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758447AbZERJkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 05:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758338AbZERJkL
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 05:40:11 -0400
Received: from main.gmane.org ([80.91.229.2]:42898 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758168AbZERJkI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 05:40:08 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1M5zKE-0004Ih-DD
	for git@vger.kernel.org; Mon, 18 May 2009 09:40:02 +0000
Received: from 168.202.99.127 ([168.202.99.127])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 May 2009 09:40:02 +0000
Received: from pedrocontebarros by 168.202.99.127 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 May 2009 09:40:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 168.202.99.127 (Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; .NET CLR 3.0.04506.648))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119434>

Dear all,

I am experiencing what seems to be some conflict between cygwin and msysgit, 
even though cygwin was long uninstalled.

I use mostly two computers, and keep them synchronized by using bare git 
repositories in an external (USB) HD. I had msysgit in one of the computers, 
and had cygwin (with git) on the other, but recently I started experiencing 
some errors when running git push on the cygwin-based machine, so I decided to 
replace it with msysgit.
I uninstalled cygwin fully, including removing the two registry keys mentioned 
on several posts, and after a hard reboot, installed msysgit.

The problem is that whenever I try to start msysgit, I get the following 
message:
"This application has failed to start because cygcrypto-0.9.8.dll was not 
found. Re-installing the application may fix this problem."
But in my other computer there is no cygcrypto-0.9.8.dll, and everything works 
fine!

How can I get solve this?

Thanks,
Pedro
