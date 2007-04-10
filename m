From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 11/10] allow forcing index v2 and 64-bit offset treshold
Date: Mon, 09 Apr 2007 17:23:24 -0700
Message-ID: <7vejmtxekj.fsf@assigned-by-dhcp.cox.net>
References: <alpine.LFD.0.98.0704091727300.28181@xanadu.home>
	<7vps6dxjvb.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704091901290.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Apr 10 06:29:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hb48w-0008U7-5F
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 02:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965578AbXDJAX0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 20:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965826AbXDJAX0
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 20:23:26 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:47575 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965578AbXDJAXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 20:23:25 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070410002325.BNR373.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Mon, 9 Apr 2007 20:23:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id lCPQ1W00E1kojtg0000000; Mon, 09 Apr 2007 20:23:25 -0400
In-Reply-To: <alpine.LFD.0.98.0704091901290.28181@xanadu.home> (Nicolas
	Pitre's message of "Mon, 09 Apr 2007 19:04:52 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44102>

Nicolas Pitre <nico@cam.org> writes:

> On Mon, 9 Apr 2007, Junio C Hamano wrote:
>
>> Nicolas Pitre <nico@cam.org> writes:
>> 
>> > This is necessary for testing the new capabilities in some automated 
>> > way without having an actual 4GB+ pack.
>> >
>> > Signed-off-by: Nicolas Pitre <nico@cam.org>
>> > ---
>> >
>> > I should write some tests... when I have more time.
>> 
>> It appears everybody is short of time.  I am having two
>> troubles.  Nobody seems to have positive nor negative reports or
>> comments on what are cooking in 'next' so nothing can graduate,
>> and I am behind list discussions on certain areas myself.
>
> At least my latest patch series received two positive reviews.  ;-)

They are _not_ even in 'pu'.  I am talking about things that
have been cooking.

>> > ddiff --git a/t/Makefile b/t/Makefile
>> 
>> ???
>
> Remnant of a change to that file which was later reverted but mtime 
> doesn't match the index.

Double 'd'?
