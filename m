From: Graeme Geldenhuys <graemeg@gmail.com>
Subject: Re: requirements to compile git-svn support
Date: Fri, 03 Jul 2009 11:34:57 +0200
Message-ID: <h2kjg8$5at$1@ger.gmane.org>
References: <alpine.DEB.2.00.0907021352300.24169@vinegar-pot.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 03 11:37:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMfD9-0005am-GS
	for gcvg-git-2@gmane.org; Fri, 03 Jul 2009 11:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755267AbZGCJh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2009 05:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754016AbZGCJh0
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jul 2009 05:37:26 -0400
Received: from main.gmane.org ([80.91.229.2]:44229 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755754AbZGCJhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2009 05:37:25 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MMfCt-0004xe-CS
	for git@vger.kernel.org; Fri, 03 Jul 2009 09:37:23 +0000
Received: from dsl-245-91-189.telkomadsl.co.za ([41.245.91.189])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Jul 2009 09:37:23 +0000
Received: from graemeg by dsl-245-91-189.telkomadsl.co.za with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Jul 2009 09:37:23 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsl-245-91-189.telkomadsl.co.za
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
In-Reply-To: <alpine.DEB.2.00.0907021352300.24169@vinegar-pot.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122693>

Anders Kaseorg wrote:
> 
> I maintain up-to-date Git packages for Ubuntu 8.04, 8.10, and 9.04 at

Thanks, I'll take a look at that. If I apt-get install the original git 
(v1.5.x) from the apt repository, 'git svn' works fine, but when using 
my own compiled git, I get the following output.


Yes I know that the command is 'git svn', but I followed the syntax as 
used in the documentation, adding the hyphen followed by the command. If 
I run 'git svn', I get the following output on my system.

==============================
$ git svn
Can't locate SVN/Core.pm in @INC (@INC contains: 
/usr/local/share/perl/5.8.8 /etc/perl /usr/local/lib/perl/5.8.8 
/usr/lib/perl5 /usr/share/perl5 /usr/lib/perl/5.8 /usr/share/perl/5.8 
/usr/local/lib/site_perl .) at /usr/local/libexec/git-core/git-svn line 29.
==============================


Regards,
   - Graeme -

-- 
fpGUI Toolkit - a cross-platform GUI toolkit using Free Pascal
http://opensoft.homeip.net/fpgui/
