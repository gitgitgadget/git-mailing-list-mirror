From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Announce] gitview-0.1
Date: Wed, 01 Feb 2006 12:34:39 -0800
Message-ID: <7vzmlaakdc.fsf@assigned-by-dhcp.cox.net>
References: <cc723f590601312016vabba201ye6d3739b3927f1a@mail.gmail.com>
	<20060201042930.GV16557@redhat.com>
	<cc723f590601312041o1dc594c7t69418b735ef29ee@mail.gmail.com>
	<cc723f590602010328w7b4a7befr40a76620e197d00c@mail.gmail.com>
	<7v3bj2df1b.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602011206040.21884@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aneesh Kumar <aneesh.kumar@gmail.com>,
	Dave Jones <davej@redhat.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 21:35:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4Oge-0006RE-HD
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 21:34:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161106AbWBAUem (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 15:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWBAUem
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 15:34:42 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:18106 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932453AbWBAUel (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 15:34:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060201203446.QMFN25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Feb 2006 15:34:46 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602011206040.21884@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 1 Feb 2006 12:17:02 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15443>

Linus Torvalds <torvalds@osdl.org> writes:

> Btw, I think we should change
>
> 	git-diff-tree --stdin
>
> to look at the rest of the line.

Yes it is one of the "broken things I am aware of".  It does not
even show --pretty for the same reason, and I was planning to do
a fake commit objects to handle them (taking the message from
commit, locally grafting the parents from the line to it).
