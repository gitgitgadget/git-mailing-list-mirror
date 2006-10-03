From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: tree view: eliminate redundant "blob"
Date: Mon, 02 Oct 2006 21:14:03 -0700
Message-ID: <7v1wpqujck.fsf@assigned-by-dhcp.cox.net>
References: <20061002191115.84730.qmail@web31811.mail.mud.yahoo.com>
	<200610022203.44733.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 03 06:14:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUbfW-0005PM-Q2
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 06:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965080AbWJCEOH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 00:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965081AbWJCEOH
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 00:14:07 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:33525 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S965080AbWJCEOE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 00:14:04 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061003041403.LPLR18985.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Tue, 3 Oct 2006 00:14:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id VgE61V00H1kojtg0000000
	Tue, 03 Oct 2006 00:14:06 -0400
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28243>

Jakub Narebski <jnareb@gmail.com> writes:

> Luben Tuikov wrote:
>> --- Jakub Narebski <jnareb@gmail.com> wrote:
>>> I think that redundancy in a visual interface (and not only visual, as 
>>> seen in the example of Perl programming language) is a good idea, 
>>> contrary to the redundancy in code or data (database).
>> 
>> Jakub,
>> 
>> Your opinion here is highly subjective.
>
> Yours too.
>  
>> Years of experience make certain things "make sense" and other
>> "make less sense".  Note that that is in itself subjective.
>> 
>> Give it 10 years, your opinion will change.
>
> Perhaps. Perhaps not.
>
> I guess we have to agree to disagree. It's Junio opinion that
> matters (which patches would get accepted).

Honestly, I _hate_ to be in the position to decide in which
color the bikeshed should be, but sometimes that is what a
maintainer has to do.

I personally feel that in a list that is one line per item, like
the shortlog, we do not necessarily have to underline the log
message even though they are clickable.  The purpose of the list
is to show things so people can read them.  Readability matters.
At the same time we would want to give access to object details;
I think it is Ok not to give underline to them, as long as
people can easily pick up the convention that each of these
listed items is clickable to obtain details about it.  We should
probably make other clickable links at the right, such as "tree"
and "snapshot", visually stand out, by giving underline as we
already do.  They are not really "text", but clickable icons
that happen to be done with text (as opposed to being done with
img).

By the same logic, the purpose of the tree view is to show
contents of a tree object.  If the user picks up the convention
for the short log that each listed commit can be clicked to
obtain details about it, it probably is natural for the user to
expect that each listed entry in the tree view can be clicked to
obtain details about it, so not showing the redundant tree/blob
link is in line with that.  And it would be consistent not to
give underline to the file or directory names.

By the way, you are right in saying if we were to do icons they
should be out-of-line img with help for text browsers.  That
patch was done as illustration not as a serious patch (I am not
a serious gitweb hacker, so anything I do with gitweb, unless it
is an obvious and trivial bugfix, is not meant for direct
inclusion).
