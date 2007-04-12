From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 8/6] Teach directory traversal about subprojects
Date: Wed, 11 Apr 2007 19:03:02 -0700
Message-ID: <7vtzvml57t.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704111439210.6730@woody.linux-foundation.org>
	<7vfy76mn4d.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704111853050.4061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 04:03:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HboeT-0006xX-KK
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 04:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161470AbXDLCDG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 22:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161452AbXDLCDG
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 22:03:06 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:37828 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161471AbXDLCDF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 22:03:05 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070412020303.OMPG1268.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Apr 2007 22:03:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id m2321W00q1kojtg0000000; Wed, 11 Apr 2007 22:03:03 -0400
In-Reply-To: <Pine.LNX.4.64.0704111853050.4061@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 11 Apr 2007 18:53:28 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44309>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 11 Apr 2007, Junio C Hamano wrote:
>> > diff --git a/dir.h b/dir.h
>> > index 33c31f2..1931609 100644
>> > --- a/dir.h
>> > +++ b/dir.h
>> > @@ -33,7 +33,8 @@ struct dir_struct {
>> >  	int nr, alloc;
>> >  	unsigned int show_ignored:1,
>> >  		     show_other_directories:1,
>> > -		     hide_empty_directories:1;
>> > +		     hide_empty_directories:1,
>> > +		     no_dirlinks;
>> >  	struct dir_entry **entries;
>> >  
>> >  	/* Exclude info */
>> 
>> Did you mean a bitfield here?
>
> I did indeed. Please fix.

Will try to remember when I get around to it.  I'm mucking with
'maint' right now to push 1.5.1.1 out, and then merge it in to
'master'.  It will be a while before I can get to any of the
topics.
