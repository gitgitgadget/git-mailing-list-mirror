From: Junio C Hamano <junkio@cox.net>
Subject: Re: Summary of core GIT while you are away.
Date: Thu, 26 May 2005 20:36:13 -0700
Message-ID: <7vk6ll2vde.fsf@assigned-by-dhcp.cox.net>
References: <7vzmuy13od.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505160837080.28162@ppc970.osdl.org>
	<20050526004411.GA12360@vrfy.org>
	<Pine.LNX.4.58.0505251826460.2307@ppc970.osdl.org>
	<20050526202712.GA6024@vrfy.org>
	<7vd5rdbtif.fsf@assigned-by-dhcp.cox.net>
	<20050526232953.GA6215@vrfy.org>
	<7vll618rnw.fsf@assigned-by-dhcp.cox.net> <42967CFE.7030007@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Linus Torvalds <torvalds@osdl.org>, pasky@ucw.cz,
	braddr@puremagic.com, nico@cam.org, david@dgreaves.com,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 05:34:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbVcH-00056E-NG
	for gcvg-git@gmane.org; Fri, 27 May 2005 05:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbVE0Dg0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 23:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVE0Dg0
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 23:36:26 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:44939 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261874AbVE0DgR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 23:36:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050527033614.JJVO7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 26 May 2005 23:36:14 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <42967CFE.7030007@zytor.com> (H. Peter Anvin's message of "Thu,
 26 May 2005 18:50:54 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "HPA" == H Peter Anvin <hpa@zytor.com> writes:

HPA> Junio C Hamano wrote:
KS> The cgi doesn't need it. Cogito has the spec file and the
KS> Mekefile with support for it - that was the reason the RPM
KS> made it on the machines there.
>> Ah, just installation convenience.  I see.

HPA> Not "just" an installation convenience.  Right now cogito and git-core
HPA> *conflict*.  That's why cogito really needs to be broken out from
HPA> git-core, so git-core can be updated independently.

What I learned from this thread are these:

 (1) CGI does not need Cogito but just needs core GIT.
 (2) Nobody said he uses Cogito on kernel.org machines.
 (3) But Cogito is installed nevertheless.
 (4) Installation of Cogito is done via RPM "with Makefiles and
     spec files" and both Cogito and core GIT comes bundled in.
 (5) I gather that there is no core GIT only RPM (nobody said
     this explicitly in this thread, though, so I may be
     mistaken about this point).

And that was where my comment about "just an installation
convenience" came from.

If somebody said Cogito _is_ used on kernel.org machines, then I
would not have said "just" nor "convenience".  That would mean
there is a real need to have Cogito and having just core GIT
would not be enough.

