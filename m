From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Fri, 08 Sep 2006 11:11:09 +0200
Organization: At home
Message-ID: <edrc2e$cpq$1@sea.gmane.org>
References: <200609021817.09296.jnareb@gmail.com> <edqeco$ums$1@sea.gmane.org> <7vzmdbp38k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Sep 08 11:11:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLcOU-0006WU-Kj
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 11:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWIHJLF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 05:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWIHJLF
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 05:11:05 -0400
Received: from main.gmane.org ([80.91.229.2]:7893 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750734AbWIHJLB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Sep 2006 05:11:01 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GLcO0-0006R4-RX
	for git@vger.kernel.org; Fri, 08 Sep 2006 11:10:56 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Sep 2006 11:10:56 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Sep 2006 11:10:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26692>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> I have very preliminary work, where gitweb uses @enabled_committags as list
>> of committags to use, and %committags_info for actual committags info.
>> Examples of committags includes current linking of commit sha1,
>> gitweb-xmms2 linking of BUG(n) and FEATURE(n) to site-wide based URL
>> (Mantis), and RELEASE x.y.z to site-wide based URL (Wiki); perhaps "bug n"
>> to site-wide/project-wide URL (Bugzilla)... any other ideas?
> 
> Use a regexp as %committags key and its value to be whatever
> that takes the matched string and munge it into a URL form
> perhaps?  A site that does not have commit tags do not have any
> element in that hash.

The problem is when you have a bunch of projects, all server by the same 
gitweb, but otherwise unrelated, so needing different committags (e.g. one 
project uses Mantis and needs "BUG(n)" and "FEATURE(n)", another uses 
Bugzilla and needs "bug nn", yet another doesn't use any bugtracker).
And for committag you would want also information if to use it in summary
(title) in shortlog, head, history etc. views.

But this might be a good idea.

We loop over all enabled (active) committags.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
