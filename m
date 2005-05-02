From: Dave Kleikamp <shaggy@austin.ibm.com>
Subject: Re: More problems...
Date: Mon, 02 May 2005 14:44:38 -0500
Message-ID: <1115063079.8041.5.camel@kleikamp>
References: <20050429170127.A30010@flint.arm.linux.org.uk>
	 <20050429182708.GB14202@pasky.ji.cz>
	 <20050429195055.GE1233@mythryan2.michonline.com>
	 <Pine.LNX.4.58.0504291311320.18901@ppc970.osdl.org>
	 <7vhdhp47hq.fsf@assigned-by-dhcp.cox.net>
	 <20050429221903.F30010@flint.arm.linux.org.uk>
	 <Pine.LNX.4.60.0504292254430.25700@hermes-1.csi.cam.ac.uk>
	 <20050502193327.GB20818@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Anton Altaparmakov <aia21@cam.ac.uk>,
	Russell King <rmk@arm.linux.org.uk>,
	Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 21:40:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSgko-0002n8-Lo
	for gcvg-git@gmane.org; Mon, 02 May 2005 21:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVEBTo6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 15:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbVEBTo6
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 15:44:58 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:61689 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261734AbVEBToy
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 2 May 2005 15:44:54 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j42Jilua364578
	for <git@vger.kernel.org>; Mon, 2 May 2005 15:44:47 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j42Jig5K129882
	for <git@vger.kernel.org>; Mon, 2 May 2005 13:44:42 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j42Jid4L001847
	for <git@vger.kernel.org>; Mon, 2 May 2005 13:44:40 -0600
Received: from dyn95390155.austin.ibm.com (dyn95390155.austin.ibm.com [9.53.90.155])
	by d03av01.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j42JidPq001824;
	Mon, 2 May 2005 13:44:39 -0600
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050502193327.GB20818@pasky.ji.cz>
X-Mailer: Evolution 2.0.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2005-05-02 at 21:33 +0200, Petr Baudis wrote:
> Dear diary, on Fri, Apr 29, 2005 at 11:57:53PM CEST, I got a letter
> where Anton Altaparmakov <aia21@cam.ac.uk> told me that...
> > There should definitely be an option to either enable or disable this as 
> > there are legitimate cases for not wanting hard links or indeed using 
> > file systems which do not support them.
> 
> Are there legitimate cases for not wanting hard links when you are able
> to create them? (Same filesystem, filesystem supports them...)

Cloning a different user's repo?
-- 
David Kleikamp
IBM Linux Technology Center

