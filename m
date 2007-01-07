From: Junio C Hamano <junkio@cox.net>
Subject: Re: Simple UI question...
Date: Sun, 07 Jan 2007 03:40:41 -0800
Message-ID: <7vk5zz12va.fsf@assigned-by-dhcp.cox.net>
References: <204011cb0701070302y54837c5bp967e2cddd3fb655d@mail.gmail.com>
	<20070107111305.GD10351@spearce.org>
	<204011cb0701070321w18942a3w7fb4f7ecd26fc457@mail.gmail.com>
	<20070107112944.GF10351@spearce.org>
	<204011cb0701070338i5f8a8b4bw8b39050aeb192edb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jan 07 12:40:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3WOP-00079d-F0
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 12:40:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbXAGLkp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 06:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbXAGLkp
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 06:40:45 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:51014 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932514AbXAGLko (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 06:40:44 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070107114044.EXCZ18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Sun, 7 Jan 2007 06:40:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8Bgx1W00X1kojtg0000000; Sun, 07 Jan 2007 06:40:59 -0500
To: git@vger.kernel.org
In-Reply-To: <204011cb0701070338i5f8a8b4bw8b39050aeb192edb@mail.gmail.com>
	(Chris Lee's message of "Sun, 7 Jan 2007 03:38:27 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36164>

"Chris Lee" <clee@kde.org> writes:

> On 1/7/07, Shawn O. Pearce <spearce@spearce.org> wrote:
>> Chris Lee <clee@kde.org> wrote:
>> > I assume 'removing everything in the working tree' counts as "local
>> > modifications"? :)
>>
>> Yes!  That's what's going wrong.  Don't do "rm -rf *".  Let Git take
>> care of the empty directories for you.  If Git deletes all source
>> files in that directory (as they don't belong in this version that
>> you are checking out) it will also delete the now empty directory.
>>
>> The only time it fails is if you are on Windows and some process
>> has the directory busy.  :-)
>
> So, if I were starting with an empty working directory, and I had just
> synced over the .git folder from the place where I'm doing the actual
> importing - how would I populate the working directory with a copy of
> the contents of the tree from (say)
> 07058310db903317faa300b93004a5a2e0fc2dcc ?

git reset --hard 070583
