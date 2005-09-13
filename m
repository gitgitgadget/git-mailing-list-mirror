From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Define relative .git/objects/info/alternates semantics.
Date: Tue, 13 Sep 2005 10:30:13 -0700
Message-ID: <7vvf143mfu.fsf@assigned-by-dhcp.cox.net>
References: <m3mzmjvbh7.fsf@telia.com>
	<Pine.LNX.4.58.0509110908590.4912@g5.osdl.org>
	<20050911185711.GA22556@mars.ravnborg.org>
	<Pine.LNX.4.58.0509111157360.3242@g5.osdl.org>
	<20050911194630.GB22951@mars.ravnborg.org>
	<Pine.LNX.4.58.0509111251150.3242@g5.osdl.org>
	<52irx7cnw5.fsf@cisco.com>
	<Pine.LNX.4.58.0509111422510.3242@g5.osdl.org>
	<Pine.LNX.4.58.0509111431400.3242@g5.osdl.org>
	<7virx7njxa.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509112038020.3242@g5.osdl.org>
	<7vk6hl4fd9.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509130918170.3351@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 13 19:32:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFEbs-0003ls-9c
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 19:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbVIMRaQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 13:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbVIMRaQ
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 13:30:16 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:11141 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S964915AbVIMRaO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2005 13:30:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050913173014.NVTY17436.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 13 Sep 2005 13:30:14 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509130918170.3351@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 13 Sep 2005 09:22:42 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8473>

Linus Torvalds <torvalds@osdl.org> writes:

> Which means that the _same_ "alternates" file can be shared with many
> different project.git/ directories, and thus it's not well-defined to make
> it relative to GIT_DIR.

Good point.

> You can make it relative to "GIT_OBJECTS_DIR/.." of course, which in most
> cases is the same thing as "GIT_DIR".

Again, good point.
