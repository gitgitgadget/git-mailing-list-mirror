From: Ron Garret <ron1@flownet.com>
Subject: Re: git-mv redux: there must be something else going on
Date: Wed, 03 Feb 2010 16:10:16 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-C4BB38.16101603022010@news.gmane.org>
References: <ron1-32BD5F.10255403022010@news.gmane.org> <32541b131002031048i26d166d9w3567a60515235c34@mail.gmail.com> <ron1-5F71CB.11234903022010@news.gmane.org> <alpine.LFD.2.00.1002031436490.1681@xanadu.home> <ron1-34F9C6.12273203022010@news.gmane.org> <32541b131002031240p6b67536ame6b69c6d662a7968@mail.gmail.com> <ron1-9FA846.14332803022010@news.gmane.org> <32541b131002031518t1017d351xcf9071f0a937474e@mail.gmail.com> <76718491002031555i2c1558f9qe0c97d07ceb86bb6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 01:10:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcpIy-0003Ad-29
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 01:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757881Ab0BDAKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 19:10:38 -0500
Received: from lo.gmane.org ([80.91.229.12]:44359 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757740Ab0BDAKi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 19:10:38 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NcpIq-00035Y-RC
	for git@vger.kernel.org; Thu, 04 Feb 2010 01:10:37 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 01:10:36 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 01:10:36 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138918>

In article 
<76718491002031555i2c1558f9qe0c97d07ceb86bb6@mail.gmail.com>,
 Jay Soffian <jaysoffian@gmail.com> wrote:

> On Wed, Feb 3, 2010 at 6:18 PM, Avery Pennarun <apenwarr@gmail.com> wrote:
> > More about this: http://marc.info/?l=git&m=114123702826251
> 
> I think the canonical email on the subject is this one:
> 
> http://article.gmane.org/gmane.comp.version-control.git/217
> 

The upshot seems to be this:

> And that "where did this come from" decision should be done at _search_ 
> time, not commit time.

And I'm mostly convinced, except for the one screw case that I outlined 
above.  In that case the search-time result is ambiguous, and file 
tracking information could be used to resolve the ambiguity.  But it 
certainly does seem like a rare enough situation that it's not worth 
worrying about.

I think I'm starting to git it :-)

rg
