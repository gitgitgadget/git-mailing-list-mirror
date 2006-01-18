From: Junio C Hamano <junkio@cox.net>
Subject: Re: Joining Repositories
Date: Wed, 18 Jan 2006 09:33:21 -0800
Message-ID: <7v7j8xxwym.fsf@assigned-by-dhcp.cox.net>
References: <200601181325.59832.Mathias.Waack@rantzau.de>
	<20060118125158.GN28365@pasky.or.cz>
	<20060118140917.GA15438@mythryan2.michonline.com>
	<Pine.LNX.4.64.0601180813170.3240@g5.osdl.org>
	<20060118170536.GS28365@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 18:33:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzHBj-0006gW-VJ
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 18:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWARRd0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 12:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbWARRd0
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 12:33:26 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:41104 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751403AbWARRdY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 12:33:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060118173046.YGSE17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 18 Jan 2006 12:30:46 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060118170536.GS28365@pasky.or.cz> (Petr Baudis's message of
	"Wed, 18 Jan 2006 18:05:37 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14844>

Petr Baudis <pasky@suse.cz> writes:

> Well, the recursive merge strategy is at least advertised to be able to
> merge across renames (as long as they are autodetected). Not that I
> would have any practical experiences with it and I don't know how smart
> is it done (if it just runs rename detection between the merge base and
> current head, yes, that might not give very good results in this case).

If I understand and remember the code correctly, it is based on
rename detection between two heads.  When the versions have
diverged greatly beyond recognition, obviously this would not
work well.
