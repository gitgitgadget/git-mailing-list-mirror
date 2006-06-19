From: Junio C Hamano <junkio@cox.net>
Subject: Re: Add specialized object allocator
Date: Mon, 19 Jun 2006 14:38:45 -0700
Message-ID: <7vhd2g966y.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0606191028540.5498@g5.osdl.org>
	<7vejxl9bi0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606191327240.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 19 23:39:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsRSX-0001Yz-Ap
	for gcvg-git@gmane.org; Mon, 19 Jun 2006 23:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWFSVis (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 17:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWFSVir
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 17:38:47 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:37318 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S964902AbWFSViq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jun 2006 17:38:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060619213846.JUFJ22974.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Jun 2006 17:38:46 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606191327240.5498@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 19 Jun 2006 13:30:29 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22139>

Linus Torvalds <torvalds@osdl.org> writes:

> On Mon, 19 Jun 2006, Junio C Hamano wrote:
>>
>> Impressed.  I wonder if we want to deal with any_object
>> structure as well.
>
> Well, it would certainly be very easily doable, but none of the core code 
> actually uses it, so it wasn't even on my radar. 

I think the definition of "the core" in your earlier message was
"stuff I [jc: Linus] use myself", and I think the above
statement is in line with that definition.

It is hereby officially declared that commit walkers are not
part of the core ;-).

Even the commit walker uses lookup_unknown only for the starting
object and all the rest are of known type, so it does not help
even if we did "union any_object" that much.
