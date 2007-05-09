From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH v2] Custom compression levels for objects and packs
Date: Tue, 08 May 2007 22:59:21 -0700
Message-ID: <7vr6pqy1ty.fsf@assigned-by-dhcp.cox.net>
References: <4640FBDE.1000609@gmail.com>
	<7vk5vi27ko.fsf@assigned-by-dhcp.cox.net>
	<56b7f5510705081725v655d2ce1j28712507cfa7fa55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Dana How" <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 07:59:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlfCz-0001qt-R1
	for gcvg-git@gmane.org; Wed, 09 May 2007 07:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935245AbXEIF7Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 01:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935222AbXEIF7X
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 01:59:23 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:54193 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935189AbXEIF7W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 01:59:22 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070509055921.DFXV24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 9 May 2007 01:59:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id wtzM1W00B1kojtg0000000; Wed, 09 May 2007 01:59:21 -0400
In-Reply-To: <56b7f5510705081725v655d2ce1j28712507cfa7fa55@mail.gmail.com>
	(Dana How's message of "Tue, 8 May 2007 17:25:24 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46665>

"Dana How" <danahow@gmail.com> writes:

> On 5/8/07, Junio C Hamano <junkio@cox.net> wrote:
>> Dana How <danahow@gmail.com> writes:
>> ...
>> > This applies on top of the git-repack --max-pack-size patchset.
>
>> Hmph, that makes the --max-pack-size patchset take this more
>> trivial and straightforward improvements hostage.  In general,
>> I'd prefer more elaborate ones based on less questionable
>> series.
>
> The max-pack-size and pack.compression patches touch the same lines.
> I thought my options were:
> * Submit independently and make you merge; or
> * Make one precede the other.
> Since max-pack-size has been out there since April 4 and
> the first acceptable version was May 1 (suggested by 0 comments),
> I didn't realize it was a "questionable series".

No, what I meant was that it is much "more elaborate" series
than this custom compression which is much "less questionable".

I think this custom compression is 1.5.2 material.  I have not
studied the code for the max-pack-size enough to be confident to
put it in 1.5.2, at least not yet, and was planning to park the
latter in 'next' until 1.5.2 final.
