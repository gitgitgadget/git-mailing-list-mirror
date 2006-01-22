From: Junio C Hamano <junkio@cox.net>
Subject: Re: What is in git.git
Date: Sun, 22 Jan 2006 12:35:40 -0800
Message-ID: <7vlkx8c86b.fsf@assigned-by-dhcp.cox.net>
References: <7v3bjiuhxb.fsf@assigned-by-dhcp.cox.net>
	<200601211636.02340.lan@ac-sw.com>
	<7vek31mkyg.fsf@assigned-by-dhcp.cox.net>
	<200601220033.26321.Josef.Weidendorfer@gmx.de>
	<Pine.LNX.4.64.0601221106330.25300@iabervon.org>
	<7vu0bwdo08.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601221512470.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 22 21:36:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0lwN-0002pV-3I
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 21:35:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWAVUfn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jan 2006 15:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWAVUfn
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jan 2006 15:35:43 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:36513 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751342AbWAVUfm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2006 15:35:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060122203443.FVSK15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 22 Jan 2006 15:34:43 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0601221512470.25300@iabervon.org> (Daniel
	Barkalow's message of "Sun, 22 Jan 2006 15:26:27 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15061>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On a side topic, is there any reason not to convert ls-tree to use struct
> tree, and kill the other tree-object-parsing code, which doesn't seem to 
> be used by anything else?

ls-tree _might_ be doing something struct tree interface does
not support, but I do not know.

If you are inclined to, please go wild ;-).
