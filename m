From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] The diff-raw format updates.
Date: Sun, 22 May 2005 12:15:05 -0700
Message-ID: <7vbr73dqdi.fsf@assigned-by-dhcp.cox.net>
References: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net>
	<7v1x80dluj.fsf@assigned-by-dhcp.cox.net>
	<7vvf5cc779.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505221108000.2307@ppc970.osdl.org>
	<20050522183645.GA1866@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 21:14:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZvtg-0005Lz-HQ
	for gcvg-git@gmane.org; Sun, 22 May 2005 21:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVEVTPM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 15:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVEVTPM
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 15:15:12 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:35571 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261556AbVEVTPH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2005 15:15:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050522191507.PZJM22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 22 May 2005 15:15:07 -0400
To: Niklas Hoglund <nhoglund@gmail.com>
In-Reply-To: <20050522183645.GA1866@localhost.localdomain> (Niklas Hoglund's
 message of "Sun, 22 May 2005 19:36:45 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "NH" == Niklas Hoglund <nhoglund@gmail.com> writes:

NH> On Sun, May 22, 2005 at 11:35:34AM -0700, Linus Torvalds wrote:
>> :000000 100644 0000000000000000000000000000000000000000 25ab9eda939ad92bb746c2419d083b1e52117a56	diffcore-pathspec.c	diffcore-pathspec.c

NH> Don't you think it would be easier to read if the SHA1 field was, say, a
NH> dash and 19 spaces, instead of an obviously bogus SHA1?

My understanding of the purpose of the diff-raw format is
primarily about machine readablility; 0{40} was far easier to
code cleanly---please see why in diff-helper.c.


