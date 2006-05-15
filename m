From: Junio C Hamano <junkio@cox.net>
Subject: Re: The git newbie experience
Date: Sun, 14 May 2006 22:18:46 -0700
Message-ID: <7vy7x3x3ux.fsf@assigned-by-dhcp.cox.net>
References: <446778B8.7080201@inoi.fi>
	<7vfyjcntro.fsf@assigned-by-dhcp.cox.net> <44680C54.8040206@inoi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 07:19:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfVTv-00059v-By
	for gcvg-git@gmane.org; Mon, 15 May 2006 07:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWEOFSs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 01:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWEOFSs
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 01:18:48 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:20704 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751420AbWEOFSs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 01:18:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060515051847.PGMC24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 May 2006 01:18:47 -0400
To: Tommi Virtanen <tv@inoi.fi>
In-Reply-To: <44680C54.8040206@inoi.fi> (Tommi Virtanen's message of "Mon, 15
	May 2006 08:06:28 +0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20017>

Tommi Virtanen <tv@inoi.fi> writes:

> Oh, I'd love to have a quick stash, that's what we actually ended up
> doing a lot. Although I'd rather see a real implementation use a branch
> and not just a diff file, but.. yes please.

I'd rather do that with a diff file that can be used to do a
3-way (see how rebase does it with --full-index diff with am -3).
No point creating and forgetting to remove a throw away branch
and getting more complaints.
