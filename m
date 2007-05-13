From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 13 May 2007 16:33:48 -0700
Message-ID: <7vzm48pacj.fsf@assigned-by-dhcp.cox.net>
References: <7v646wqrvm.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0705132348290.4791@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Mon May 14 01:33:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnNZa-0002nI-2V
	for gcvg-git@gmane.org; Mon, 14 May 2007 01:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758401AbXEMXdu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 19:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758390AbXEMXdu
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 19:33:50 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:48446 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758233AbXEMXdt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 19:33:49 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070513233348.LULU22040.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sun, 13 May 2007 19:33:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ynZo1W00N1kojtg0000000; Sun, 13 May 2007 19:33:49 -0400
In-Reply-To: <Pine.LNX.4.64.0705132348290.4791@beast.quantumfyre.co.uk>
	(Julian Phillips's message of "Sun, 13 May 2007 23:58:11 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47194>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> On Sun, 13 May 2007, Junio C Hamano wrote:
>
>> * db/remote (Sat May 12 11:46:03 2007 -0400) 3 commits
>> - Add handlers for fetch-side configuration of remotes.
>> - Move refspec parser from connect.c and cache.h to remote.{c,h}
>> - Move remote parsing into a library file out of builtin-push.
>>
>> Hopefully be in 'next' after v1.5.2; I haven't really played
>> with it.  The next step would probably be to add some stuff that
>> use this series in fetch--tool, to further rewrite git-fetch
>> itself in C, or maybe wholesale rewrite of git-fetch in C.
>
> FWIW, I've got a largely functional C version of git-fetch ... the
> main functionality is there - but it's not complete yet.  In addition
> to some of the non-core functionality being missing (e.g. --tags or
> --no-tags in tagopt), I haven't been keeping up with recent updates to
> fetch/fetch-tool.  I was hoping to have it ready for post-1.5.2 -
> unfortunately I've been rather busy the last couple of weeks, and
> haven't managed to get as far as I'd hoped.

Thanks for the status updates.  Although I do not recall Daniel
saying it explicitly, I have been assuming that his series was
aiming for the same all along.  It might be a good idea for you
two to compare notes sometime between now and v1.5.2?
