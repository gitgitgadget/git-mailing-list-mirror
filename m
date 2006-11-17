X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Cleaning up git user-interface warts
Date: Fri, 17 Nov 2006 13:20:45 +0100
Message-ID: <20061117122045.GC20729@diana.vm.bytemark.co.uk>
References: <200611151858.51833.andyparkins@gmail.com> <Pine.LNX.4.64.0611151111250.3349@woody.osdl.org> <f2b55d220611151139v66fba16ax97ce6b9966b33ce7@mail.gmail.com> <Pine.LNX.4.64.0611151203450.3349@woody.osdl.org> <Pine.LNX.4.64.0611151516360.2591@xanadu.home> <Pine.LNX.4.64.0611151226590.3349@woody.osdl.org> <87velgs9hx.wl%cworth@cworth.org> <7virhgjt25.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611151638550.2591@xanadu.home> <7vac2sjs28.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 17 Nov 2006 12:21:27 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vac2sjs28.fsf@assigned-by-dhcp.cox.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31693>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl2iP-00042a-1I for gcvg-git@gmane.org; Fri, 17 Nov
 2006 13:21:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754189AbWKQMUx convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006 07:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754160AbWKQMUx
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 07:20:53 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:18451 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1754189AbWKQMUw
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 07:20:52 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1Gl2i5-0001oA-00; Fri, 17 Nov 2006 12:20:45 +0000
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 2006-11-15 13:52:47 -0800, Junio C Hamano wrote:

> That means that updated "git merge" (not the current one) would not
> be able to assume it's parameter is a branch name, and still has to
> come up with the merge message "Merge <branch>".

Often, it would be a branch or a tag, so no problem there. For commits
in general, it should not be hard to compute the set of branches and
tags the commit is part of, and in the (probably) common case where
this set has exactly one element, the problem is solved. For the
remaining cases, it should not be too horrible to ask the user to
describe what is being merged.

--=20
Karl Hasselstr=F6m, kha@treskal.com
