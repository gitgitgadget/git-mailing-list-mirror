From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Convert Content-Disposition filenames into qtext
Date: Sat, 07 Oct 2006 02:46:48 -0700
Message-ID: <7vk63ctq47.fsf@assigned-by-dhcp.cox.net>
References: <20061006192006.GW20017@pasky.or.cz>
	<20061006193059.21334.qmail@web31807.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Oct 07 11:47:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GW8lh-0005AY-LN
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 11:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWJGJqu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 05:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWJGJqu
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 05:46:50 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:38078 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750719AbWJGJqt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Oct 2006 05:46:49 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061007094649.VHJR21457.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Sat, 7 Oct 2006 05:46:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XMmr1V00D1kojtg0000000
	Sat, 07 Oct 2006 05:46:52 -0400
To: ltuikov@yahoo.com
In-Reply-To: <20061006193059.21334.qmail@web31807.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Fri, 6 Oct 2006 12:30:59 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28464>

Luben Tuikov <ltuikov@yahoo.com> writes:

>> > +# Convert a string (e.g. a filename) into qtext as defined
>> > +# in RFC 822, from RFC 2183.  To be used by Content-Disposition.
>> > +sub to_qtext {
>> > +	my $str = shift;
>> > +	$str =~ s/\\/\\\\/g;
>> > +	$str =~ s/\"/\\\"/g;
>> > +	$str =~ s/\r/\\r/g;
>> 
>> \r? Not \n?
>
> Yes, \r, not \n.

\r to \\r? Not to \\\r?
