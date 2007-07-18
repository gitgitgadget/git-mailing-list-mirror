From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Empty directories...
Date: Tue, 17 Jul 2007 19:23:15 -0700
Message-ID: <7v8x9ea1rg.fsf@assigned-by-dhcp.cox.net>
References: <85lkdezi08.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 04:23:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAzCB-0003wj-Q5
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 04:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757074AbXGRCXR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 22:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756426AbXGRCXR
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 22:23:17 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:46964 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755137AbXGRCXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 22:23:16 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070718022315.LHHF1428.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 17 Jul 2007 22:23:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id QqPF1X00D1kojtg0000000; Tue, 17 Jul 2007 22:23:16 -0400
In-Reply-To: <85lkdezi08.fsf@lola.goethe.zz> (David Kastrup's message of "Wed,
	18 Jul 2007 02:13:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52820>

David Kastrup <dak@gnu.org> writes:

> or has somebody a better idea or interface or rationale?  I understand
> that there are use cases where one does not bother about empty
> directories, but for a _content_ tracker, not tracking directories
> because they are empty seems quite serious.

No objections as long as a patch is cleanly made without
regression.  It's just nobody agreed that it is "quite serious"
yet so far, and no fundamental reason against it.
