From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-checkout changes the index but not the checked out files?
Date: Sun, 22 Apr 2007 17:30:04 -0700
Message-ID: <7vabx0kk4z.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90704221625k216864cdwb2b35bc035fac7e9@mail.gmail.com>
	<7virbokmx1.fsf@assigned-by-dhcp.cox.net>
	<46a038f90704221717i8e5c1bkff066dcbdb0a0523@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 02:30:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfmRx-0006mB-0w
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 02:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965661AbXDWAaH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 20:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbXDWAaH
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 20:30:07 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:50811 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965661AbXDWAaF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 20:30:05 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070423003005.SIIB1257.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sun, 22 Apr 2007 20:30:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id qQW41W00a1kojtg0000000; Sun, 22 Apr 2007 20:30:05 -0400
In-Reply-To: <46a038f90704221717i8e5c1bkff066dcbdb0a0523@mail.gmail.com>
	(Martin Langhoff's message of "Mon, 23 Apr 2007 12:17:19 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45292>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> but the ambiguous "git-rev-parse --verify 'mdl18-local^0'" returns the
> SHA1 for a head called 'mdl18-topnz' that I am not asking for. Why?

Maybe you have a branch that is exactly the same name as a tag?
