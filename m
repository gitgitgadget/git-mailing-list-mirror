From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please remerge git-gui.git into git.git
Date: Mon, 11 Jun 2007 22:25:13 -0700
Message-ID: <7vk5u9n3ra.fsf@assigned-by-dhcp.pobox.com>
References: <20070611231013.GM6073@spearce.org>
	<7vd502niu3.fsf@assigned-by-dhcp.pobox.com>
	<20070612022747.GP6073@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jun 12 07:25:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxysk-0007Qo-3F
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 07:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbXFLFZQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 01:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752689AbXFLFZQ
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 01:25:16 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:51901 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbXFLFZP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 01:25:15 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070612052516.XUZK1594.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Tue, 12 Jun 2007 01:25:16 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id AVRD1X00B1kojtg0000000; Tue, 12 Jun 2007 01:25:14 -0400
In-Reply-To: <20070612022747.GP6073@spearce.org> (Shawn O. Pearce's message of
	"Mon, 11 Jun 2007 22:27:47 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49919>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> I'll be happy when the subproject support is mature enough that
> git-gui can be unmerged from git.git, and we can instead just point
> git.git at the git-gui project.  But I still think its a good idea to
> distribute git-gui as part of the release tarball for core Git; users
> have come to expect they can find a stable version of git-gui there,
> much as they also expect to find a reasonably stable version of gitk.

Of course.  

That would require git-tar-tree to learn --recurse-into-subprojects
option ;-)  Hint, hint...
