From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make git-branch a builtin
Date: Tue, 24 Oct 2006 10:00:51 -0700
Message-ID: <7v8xj5ir7g.fsf@assigned-by-dhcp.cox.net>
References: <11616396262982-git-send-email-hjemli@gmail.com>
	<20061023215506.GB8344@spearce.org>
	<7vfydewqbb.fsf@assigned-by-dhcp.cox.net>
	<20061024054408.GA9724@spearce.org>
	<7vy7r6qkmg.fsf@assigned-by-dhcp.cox.net>
	<20061024113924.GC20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 19:01:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcPeC-0002UF-MJ
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 19:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030438AbWJXRAx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 13:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030434AbWJXRAx
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 13:00:53 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:5249 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1030438AbWJXRAw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 13:00:52 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061024170052.GWFQ6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Tue, 24 Oct 2006 13:00:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id eH0b1V00F1kojtg0000000
	Tue, 24 Oct 2006 13:00:35 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061024113924.GC20017@pasky.or.cz> (Petr Baudis's message of
	"Tue, 24 Oct 2006 13:39:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29989>

Petr Baudis <pasky@suse.cz> writes:

>> Think of a future when you can shallowly clone near the tip of
>> git repository that does not have shell-script git-branch.sh
>> anymore.  You cannot expect to already have the preimage of the
>> patch in such a case.  You would still want to be able to revert
>> the change with "git apply -R".
>
> Hmm, how is this argument not applying to binary diffs you can't revert
> either?

Earlier you cannot, but because now you can, perhaps? ;-)
