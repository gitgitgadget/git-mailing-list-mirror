From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Applying a graft to a tree and "rippling" the changes through the history
Date: Sun, 06 Nov 2005 17:45:40 -0800
Message-ID: <7vll01ut6j.fsf@assigned-by-dhcp.cox.net>
References: <436E85DA.1080904@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 02:47:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYw4v-00037B-Hp
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 02:45:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbVKGBpm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 20:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbVKGBpm
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 20:45:42 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:18325 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932401AbVKGBpm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 20:45:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051107014444.SIAQ2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 6 Nov 2005 20:44:44 -0500
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <436E85DA.1080904@michonline.com> (Ryan Anderson's message of
	"Sun, 06 Nov 2005 17:38:18 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11246>

Ryan Anderson <ryan@michonline.com> writes:

> I've written a tool that will take a single commit, add it as a parent
> of another commit, and recreate the history above that second commit in
> a fully compatible manner.

I think the procedure is reproducible, which is a very nice
property to have for a tool like this, but I am not sure what
you mean by "in a fully compatible manner".  What are you
compatible with?

Also another rhetorical, tongue-in-cheek question.  What is your
plan to ripple the graft through to update signed tags?  ;-)
