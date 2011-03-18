From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [RFD] Gitweb: Source configuration from file separate from the
	CGI script
Date: Fri, 18 Mar 2011 10:07:23 -0400
Message-ID: <1300457243.12245.13.camel@drew-northup.unet.maine.edu>
References: <1300285582.28805.25.camel@drew-northup.unet.maine.edu>
	 <m3lj0e59ps.fsf@localhost.localdomain>
	 <1300361067.3010.1.camel@drew-northup.unet.maine.edu>
	 <201103171641.29021.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 15:07:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0aLH-000471-Lo
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 15:07:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756521Ab1CROHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 10:07:47 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:33479 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754075Ab1CROHp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 10:07:45 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p2IE7R6Q022566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 18 Mar 2011 10:07:32 -0400
In-Reply-To: <201103171641.29021.jnareb@gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=2
	Fuz1=2 Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p2IE7R6Q022566
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1301062054.84378@DpQ+2z8AEW5VilZiLi/cBg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169319>


On Thu, 2011-03-17 at 16:41 +0100, Jakub Narebski wrote:
> Drew Northup wrote:
> 
> > I'm obviously a moron because I didn't to bother to scroll through the
> > whole thing first. I'm just not going to fight with you.
> > I'm going to crawl back under my rock now.
> 
> I came to strong; I am very, very sorry about that.  We are really
> interested how we can make existence and use of gitweb config file
> more obvious.
> 
> The "Build time configuration" section in gitweb/INSTALL is 
> unfortunately after the one-page fold, so that's probably why
> you didn't notice that.  It was probably pushed out by changes
> in previous section.
> 
> What were your changes to gitweb.cgi script, i.e. where in gitweb
> sources we should add notification about build time and runtime
> gitweb configuration?

Jakub,
I'll have another look soon, perhaps this weekend depending on when I'm
done my other obligations. 
At the very least I'm considering making a man page for the
configuration file. I don't know off-hand how much that will be
seemingly repetitive of the README, but I suspect I'm not the only one
who often finds monolithic files tucked away in /usr/share/doc (/usr/doc
for some systems) a daunting reading prospect when I really don't care
about the project history since 1937 (which, all too often, was the
apparent perspective taken when writing the README). I don't think the
gitweb README rises quite to that level, but I do think that benefit may
be drawn from doing to it what has been proposed for the rest of
gitweb--making it into smaller digestible chunks. I don't plan on
bothering anybody here about that until I've had a chance to make a mess
in my own repo hacking it to pieces for a while.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
