From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: tree view: eliminate redundant "blob"
Date: Sun, 01 Oct 2006 20:49:02 +0200
Organization: At home
Message-ID: <efp2ia$4rb$1@sea.gmane.org>
References: <20060926053816.54951.qmail@web31815.mail.mud.yahoo.com> <efapsl$e65$1@sea.gmane.org> <20060926160729.GH20017@pasky.or.cz> <7v3baekp5p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Oct 01 20:49:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GU6NG-0000yH-2d
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 20:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWJAStL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 14:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWJAStL
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 14:49:11 -0400
Received: from main.gmane.org ([80.91.229.2]:9394 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932181AbWJAStK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Oct 2006 14:49:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GU6N3-0000vq-DP
	for git@vger.kernel.org; Sun, 01 Oct 2006 20:49:01 +0200
Received: from host-81-190-17-45.torun.mm.pl ([81.190.17.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 01 Oct 2006 20:49:01 +0200
Received: from jnareb by host-81-190-17-45.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 01 Oct 2006 20:49:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-45.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28187>

Junio C Hamano wrote:

> Petr Baudis <pasky@suse.cz> writes:
> 
>> Dear diary, on Tue, Sep 26, 2006 at 10:54:49AM CEST, I got a letter
>> where Jakub Narebski <jnareb@gmail.com> said that...
>>> I'd rather not. The fact that the file name and tree name is link,
>>> and the fact that commit title and tag title is link is a _convenience_.
>>> Not always it is visible (without mouseover) that it is link.
>>> And it is _not_ visible in the case of files!
>>
>> Then that should be fixed.
>>
>> And directories should have trailing slash in their name in the tree
>> listing, for people with non-UNIX background who don't understand the
>> ls -l like output.
> 
> I am with you on both counts.  For the latter, people might
> actually like mode string to be changed to pretty pictures,
> though.

And perhaps we could also use yet another decoration for symbolic links.
Perhaps different color? Perhaps 'ls -l' view, i.e. 'link -> target'? 

But if we use different colors for tree entries and blob entries (and
perhaps yet another color for symbolic links), it is impossible to mark all
of them clearly as links. So I'd rather have redundancy, than hidden
functionality (BTW. I hate MS idea of vanishing menu entries based on
usage).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
