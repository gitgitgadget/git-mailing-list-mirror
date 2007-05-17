From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 16 May 2007 21:13:34 -0700
Message-ID: <7vzm44axzl.fsf@assigned-by-dhcp.cox.net>
References: <7v646wqrvm.fsf@assigned-by-dhcp.cox.net>
	<7vfy5wcnbg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0705162057380.18541@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu May 17 06:13:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoXMx-0000IY-Ql
	for gcvg-git@gmane.org; Thu, 17 May 2007 06:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758899AbXEQENi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 00:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755103AbXEQENi
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 00:13:38 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:37830 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755821AbXEQENh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 00:13:37 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070517041336.PTNP2758.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Thu, 17 May 2007 00:13:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 04Da1X00i1kojtg0000000; Thu, 17 May 2007 00:13:35 -0400
In-Reply-To: <Pine.LNX.4.64.0705162057380.18541@iabervon.org> (Daniel
	Barkalow's message of "Wed, 16 May 2007 22:07:04 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47495>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Wed, 16 May 2007, Junio C Hamano wrote:
> ...
>> * db/remote (Tue May 15 22:50:19 2007 -0400) 5 commits
>>  - Update local tracking refs when pushing
>>  - Add handlers for fetch-side configuration of remotes.
>>  - Move refspec parser from connect.c and cache.h to remote.{c,h}
>>  - Move remote parsing into a library file out of builtin-push.
>>  + git-update-ref: add --no-deref option for overwriting/detaching
>>    ref
>
> AFAICT, this isn't really in my topic. Rebased too much, perhaps?

You have a new call to lock_any_ref_for_update() in the last
patch in your series, whose function signature is changed by
Sven's "add --no-deref".

Because the latter is already scheduled for 'master' post 1.5.2,
I rebased the remote series on top of it, to adjust to the
change early (i.e. while my memory is still fresh).

That's what

	This was rebased on to Sven's change to lock_any_ref_for_update();

comment was about in the earlier "[2/4] What's not in 1.5.2" message.
