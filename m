From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Syntax highlighting for combined diff
Date: Sat, 21 Oct 2006 00:48:36 -0700
Message-ID: <7vslhigld7.fsf@assigned-by-dhcp.cox.net>
References: <ehbq0k$24l$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 09:48:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbBaz-00063g-3y
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 09:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWJUHsi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 03:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161177AbWJUHsi
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 03:48:38 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:57820 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932222AbWJUHsh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 03:48:37 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061021074837.KMUE2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Sat, 21 Oct 2006 03:48:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id cvoM1V00B1kojtg0000000
	Sat, 21 Oct 2006 03:48:22 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ehbq0k$24l$1@sea.gmane.org> (Jakub Narebski's message of "Sat,
	21 Oct 2006 02:35:41 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29588>

Jakub Narebski <jnareb@gmail.com> writes:

> So the question is how to color combined diff format (what should be syntax
> highlighting for combined diff format). If branches columns have only
> pluses we use the same color as for adding line in ordinary diff; if
> branches column consist only of minuses we use the same color as for
> removing line in ordinary diff. Can there be mixture of plusses and
> minuses? How git-diff --color solves this?

UTSL ;-).

Otherwise (iow, if you refuse to use the source), you could
cheat and let "git diff" do the coloring for you, and then
regexp replace the output.  You could even use the same coloring
logic for normal diff if you did so.
