From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Repository Security
Date: Tue, 23 Jan 2007 12:06:09 +0100
Organization: At home
Message-ID: <ep4q5e$ioc$1@sea.gmane.org>
References: <200701221433.13257.andre@masella.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Jan 23 12:05:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9JTG-0006pj-F1
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 12:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932965AbXAWLFn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 06:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932967AbXAWLFn
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 06:05:43 -0500
Received: from main.gmane.org ([80.91.229.2]:53831 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932965AbXAWLFm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 06:05:42 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H9JT5-0002R4-Qt
	for git@vger.kernel.org; Tue, 23 Jan 2007 12:05:35 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 12:05:35 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 12:05:35 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37497>

Andre Masella wrote:

> I've been using git for a while and really like it, but I have a concern about 
> security.
> 
> As I understand it, none of the repository backends allow any per-user 
> per-branch access control. SSH and HTTP come the closest with the right 
> hooks, but since the repository is writeable by those users, there is little 
> to stop them from changing the repository directly.

I wonder if it would be enought for SSH (and perhaps HTTP/WebDAV access)
just to rely on filesystem write access to refs/heads files (different
files having different access rights), and filesystem ACLs.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
