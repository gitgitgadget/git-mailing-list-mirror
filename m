From: Johan Herland <johan@herland.net>
Subject: Re: RFC: submodule terminology
Date: Mon, 21 May 2007 01:10:01 +0200
Message-ID: <200705210110.01223.johan@herland.net>
References: <20070520214417.GM5412@admingilde.org>
 <200705210006.47266.johan@herland.net>
 <7v3b1rje45.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, Martin Waitz <tali@admingilde.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 21 01:11:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpuYB-0004Kx-Pl
	for gcvg-git@gmane.org; Mon, 21 May 2007 01:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760501AbXETXKd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 19:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760480AbXETXKd
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 19:10:33 -0400
Received: from smtp.getmail.no ([84.208.20.33]:38837 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760418AbXETXKc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 19:10:32 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JID005034DJRN00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 21 May 2007 01:10:31 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JID0022R4CPBR30@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 21 May 2007 01:10:01 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JID00C934CP0I40@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 21 May 2007 01:10:01 +0200 (CEST)
In-reply-to: <7v3b1rje45.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47949>

On Monday 21 May 2007, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> 
> > On Sunday 20 May 2007, Martin Waitz wrote:
> >> hoi :)
> >> 
> >> I think we should agree to one name for what currently is named
> >> submodule / subproject / dirlink / gitlink.
> >> 
> >> Or use one name for the low-level plumbing (have a tree entry
> >> which points to another commit): dirlink or gitlink and another
> >> one for the high-level UI think: submodule or subproject.
> >> But then we should use those names consequently.
> >> 
> >> Oppinions?
> >
> > For the high-level concept, "subproject" seems to me the best 
> > alternative. I think it is much better than "submodule" at 
> > describing that the subproject is a stand-alone project/repo in
> > itself.
> 
> I was wondering if we can get away by just calling them
> "projects", "projects containd in the superproject", etc., as I
> tend to agree with Linus, who used the term "superproject
> support" in his talk, that this is not really about creating
> "subproject" which are somehow different from ordinary projects,
> but more about supporting superprojects that can contain/point
> at other projects, which we did not have before 1.5.2 happened.

I agree that superproject is probably the best term of all. However, 
I think it's a good idea to be explicit so as to avoid unnecessary 
confusion. My vote therefore goes to "superproject/subproject" 
rather than "superproject/project".


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
