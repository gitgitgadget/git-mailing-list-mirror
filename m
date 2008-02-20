From: Glenn Rempe <glenn@rempe.us>
Subject: Re: git on Solaris?
Date: Wed, 20 Feb 2008 22:59:20 +0000 (UTC)
Message-ID: <loom.20080220T224704-454@post.gmane.org>
References: <200802202158.m1KLw2wM014330@rs40.luxsci.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 21 00:05:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRy0g-0007zN-SF
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 00:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225AbYBTXFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 18:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752729AbYBTXFK
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 18:05:10 -0500
Received: from main.gmane.org ([80.91.229.2]:39208 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752225AbYBTXFI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 18:05:08 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JRxzq-0006T8-SI
	for git@vger.kernel.org; Wed, 20 Feb 2008 23:05:02 +0000
Received: from www.rempe.org ([64.142.55.10])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Feb 2008 23:05:02 +0000
Received: from glenn by www.rempe.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Feb 2008 23:05:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 64.142.55.10 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-us) AppleWebKit/523.15.1 (KHTML, like Gecko) Version/3.0.4 Safari/523.15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74562>


Daniel Quinlan <danq <at> brtt.com> writes:

> 
> I'm investigating moving to git for our development, but I'm having  
> difficulty getting a functional
> version on Solaris. 


I am using Git on OpenSolaris (a Joyent accelerator).  I found the process
of compiling Git on Solaris impossible to figure out myself as well.  
The solution I found lay in installing Git from a package that 
Joyent provides which has been working well for me deploying 
Rails apps to Joyent using Capistrano and Git.

I did the following:

On my accelerator I downloaded this entire package dir to 
my local home dir:

http://pkgsrc.joyent.com/2007Q3/All/

I copied the whole thing recursively with this command:

wget -q -r -nc http://pkgsrc.joyent.com/2007Q3/All/

Then:

sudo /opt/local/sbin/pkg_add \
~/pkgsrc.joyent.com/2007Q3/All/scmgit-1.5.3.2.tgz

You might be able to deduce what was done to get it working by 
digging into the scmgit package file.

Here is a wiki page with instructions for compiling Git on solaris, but I could 
not get them to work reliably (I could compile but tests would not pass).

http://discuss.joyent.com/viewtopic.php?pid=145354

I too would love to find a way to do a simple compile and install 
similar to what I do on OS X.

Glenn
