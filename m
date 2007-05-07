From: Junio C Hamano <junkio@cox.net>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Mon, 07 May 2007 12:31:10 -0700
Message-ID: <7v7irk77nl.fsf@assigned-by-dhcp.cox.net>
References: <vpqwszm9bm9.fsf@bauges.imag.fr>
	<8b65902a0705070440t40889af0p1fb8dbf7e2a072e4@mail.gmail.com>
	<Pine.LNX.4.64.0705071453120.4167@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Guilhem Bonnefille <guilhem.bonnefille@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 07 21:31:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl8vU-0000p2-Mi
	for gcvg-git@gmane.org; Mon, 07 May 2007 21:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966206AbXEGTbM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 15:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966239AbXEGTbM
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 15:31:12 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:47004 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966206AbXEGTbL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 15:31:11 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070507193109.IMWY26353.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Mon, 7 May 2007 15:31:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id wKXA1W00Y1kojtg0000000; Mon, 07 May 2007 15:31:10 -0400
In-Reply-To: <Pine.LNX.4.64.0705071453120.4167@racer.site> (Johannes
	Schindelin's message of "Mon, 7 May 2007 14:55:13 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46479>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 7 May 2007, Guilhem Bonnefille wrote:
>
>> As a newbie, I'm agree with Matthieu: the Git's index is surprising for 
>> people coming from CVS/SVN (mindless?) world. So a good documentation 
>> about this, even in tutorials, is really important.
>
> So, you are not only a newbie, but you have to unlearn some CVS 
> braindamage.

Well, people worried that documentation and command set before
1.5.0 exposed index too much, making learning curve too steep by
having one extra thing people need to learn before starting to
be productive with git.  Now post 1.5.0 people are confused,
quite rightly, that they are not told about index early enough.

I am not sure where to strike the right balance should be.

> I don't know how to make it even more prominent that CVS users should read 
> a special introduction first. AFAICT such a hint is in all the appropriate 
> places. (I mean, you would not expect to be able to fly a plane, just 
> because you have learnt to drive a car, wouldn't you?)

Let alone flying.  Just taxiing straight was hard for me until I
shook the habit I picked up from driving a car.
