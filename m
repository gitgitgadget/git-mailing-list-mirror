From: Junio C Hamano <junkio@cox.net>
Subject: Re: Moved files and merges
Date: Mon, 05 Sep 2005 11:08:57 -0700
Message-ID: <7vzmqr5qva.fsf@assigned-by-dhcp.cox.net>
References: <4318E754.9000703@zytor.com>
	<7vek87djat.fsf@assigned-by-dhcp.cox.net>
	<7vek867e29.fsf@assigned-by-dhcp.cox.net>
	<7vy86erntu.fsf@assigned-by-dhcp.cox.net>
	<20050903190500.GB8379@mars.ravnborg.org>
	<7voe7arlqk.fsf@assigned-by-dhcp.cox.net>
	<20050903220355.GA1895@mars.ravnborg.org>
	<7v64thl248.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0509041329340.23242@iabervon.org>
	<7vvf1gejjf.fsf@assigned-by-dhcp.cox.net> <431C6167.4070703@zytor.com>
	<Pine.LNX.4.58.0509050825170.3568@evo.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 20:10:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECLPJ-0001iu-LO
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 20:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbVIESJA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 14:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbVIESJA
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 14:09:00 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:43690 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932369AbVIESI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2005 14:08:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050905180859.EDRF7185.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 5 Sep 2005 14:08:59 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509050825170.3568@evo.osdl.org> (Linus Torvalds's
	message of "Mon, 5 Sep 2005 08:47:40 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8104>

Linus Torvalds <torvalds@osdl.org> writes:

> Of course, if you don't push it back, but keep the two trees separate and 
> keep on modifying files that have different names in the other repository, 
> you'll keep on getting into the situation that the trivial merge doesn't 
> work. So we _do_ want to get an automated "phase 3" (and maybe 4..) merge 
> that can figure out renames, but the point here is that it's something we 
> _can_ figure out.

Thanks.  You very well said exactly what I should have said; I
failed to explain where that `reusing rename information from
previous merge` algorithm should fit in the bigger picture.

And the algorithm you describe (and Daniel briefly outlined) is
slightly different from what I had in mind in that it does not
have to depend on previous merge, which is also nice.
