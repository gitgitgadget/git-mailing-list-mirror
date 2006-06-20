From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: Add title attribute with unshortened value for table cells
Date: Tue, 20 Jun 2006 11:59:55 +0200
Organization: At home
Message-ID: <e78gun$65s$1@sea.gmane.org>
References: <200606201012.31684.jnareb@gmail.com> <7vd5d4chmg.fsf@assigned-by-dhcp.cox.net> <20060620124606.4e3e226c.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Jun 20 12:00:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fsd20-0001I0-2X
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 12:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560AbWFTKAU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 06:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbWFTKAU
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 06:00:20 -0400
Received: from main.gmane.org ([80.91.229.2]:24000 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932560AbWFTKAS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jun 2006 06:00:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fsd1f-0001EU-Kk
	for git@vger.kernel.org; Tue, 20 Jun 2006 12:00:03 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Jun 2006 12:00:03 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Jun 2006 12:00:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22189>

Timo Hirvonen wrote:

> http://onion.dynserv.net/git/gitweb.cgi
> 
> Global symbol "$path" requires explicit package name at
> /var/www/localhost/htdocs/git/gitweb.cgi line 1521.
> Execution of /var/www/localhost/htdocs/git/gitweb.cgi aborted due to
> compilation errors.
> 
> The line is:
> 
> $file =~ m#^/# or $file = "$projectroot/$path/$file";
> 
> $path seems to be undefined.  I don't understand perl very well so I
> can't fix it.

Temporary fix is in:
 
  "[PATCH] Fix: Support for the standard mime.types map in gitweb"
  (Message-Id: <11507843541678-git-send-email-jnareb@gmail.com>)
    http://permalink.gmane.org/gmane.comp.version-control.git/22172

BTW. I have _my_ version at 
  http://front.fuw.edu.pl/cgi-bin/jnareb/gitweb.cgi

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
