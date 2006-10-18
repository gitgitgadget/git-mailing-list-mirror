From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 12:33:32 -0700
Message-ID: <7vr6x51ks3.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<200610172351.17377.jnareb@gmail.com> <4535590C.4000004@utoronto.ca>
	<200610180057.25411.jnareb@gmail.com>
	<Pine.LNX.4.64.0610171610270.3962@g5.osdl.org>
	<20061018053647.GA3507@coredump.intra.peff.net>
	<Pine.LNX.4.64.0610180739230.3962@g5.osdl.org>
	<20061018185225.GU20017@pasky.or.cz>
	<20061018185907.GV20017@pasky.or.cz>
	<7vy7rd1m4q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610181510510.1971@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 21:33:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaHAd-0001GL-AZ
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 21:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161316AbWJRTdf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 15:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161318AbWJRTde
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 15:33:34 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:44001 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1161316AbWJRTdd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 15:33:33 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061018193333.YLOX18180.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Wed, 18 Oct 2006 15:33:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id bvZc1V00X1kojtg0000000
	Wed, 18 Oct 2006 15:33:36 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0610181510510.1971@xanadu.home> (Nicolas Pitre's
	message of "Wed, 18 Oct 2006 15:13:15 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29257>

Nicolas Pitre <nico@cam.org> writes:

> Ah true.  I missed the "thin" pack.
>
> Any idea why we should still prevent this?  It is not like it was a 
> technical limitation.

It is a technical limitation.  We have never assumed that the
virtual address space is big enough to hold more than one whole
pack mmapped at the same time.

Lifting this needs the piecemeal mmap() change somebody was
talking about.

I might bite the bullet and do that myself but I've been hoping
to get an appliable patch from somewhere else ;-).
