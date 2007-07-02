From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make '!' aliases more useful
Date: Mon, 02 Jul 2007 16:11:21 -0700
Message-ID: <7vr6nqwgdi.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707012249590.4438@racer.site>
	<20070702145549.GB4720@thunk.org>
	<Pine.LNX.4.64.0707021654450.4071@racer.site>
	<20070702160810.GD4720@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Jul 03 01:11:41 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5V3O-00086c-Fa
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 01:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757020AbXGBXLY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 19:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756992AbXGBXLY
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 19:11:24 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:64860 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756925AbXGBXLW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 19:11:22 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070702231121.LHCZ1204.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Mon, 2 Jul 2007 19:11:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JnBM1X0071kojtg0000000; Mon, 02 Jul 2007 19:11:21 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51423>

Theodore Tso <tytso@mit.edu> writes:

> On Mon, Jul 02, 2007 at 04:55:24PM +0100, Johannes Schindelin wrote:
>> > But what if you don't want the argument passed at the end of the
>> > alias, but somewhere else?  I suspect the better answer would be to
>> > support $* and $1, $2, $3, et. al interpolation, no?  It was on my
>> > list of things to do when I had a spare moment, but I never got around
>> > to it.
>> 
>> There is a point where you do not want to complicate git, but rather write 
>> a script. This is such a point IMHO.
>
> Such a point exists, I agree, but I would draw after $* and $1/$2/$3
> interpolation.  There is a lot more value that gets added with
> positional arguments support, and it makes git aliases more usable on
> platforms such as Windows where scripting capability is much more
> limited.

That actually sounds sensible, but you could alias

	!sh -c 'command $2 $1 $3'

to reorder the parameters, couldn't you?
	
