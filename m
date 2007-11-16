From: Sergei Organov <osv@javad.com>
Subject: Re: [PATCH] user-manual.txt: fix a few mistakes
Date: Fri, 16 Nov 2007 14:34:22 +0300
Message-ID: <87sl361l1d.fsf@osv.gnss.ru>
References: <87bq9x7w4d.fsf@osv.gnss.ru> <20071114181858.GH14254@fieldses.org>
	<87lk8z3idj.fsf@osv.gnss.ru> <20071116035416.GF18909@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Fri Nov 16 12:34:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IszTF-0006UU-JL
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 12:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757501AbXKPLec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 06:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757393AbXKPLec
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 06:34:32 -0500
Received: from javad.com ([216.122.176.236]:4487 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754717AbXKPLec (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 06:34:32 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lAGBYSi09122;
	Fri, 16 Nov 2007 11:34:28 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1IszSo-0000t1-Av; Fri, 16 Nov 2007 14:34:22 +0300
In-Reply-To: <20071116035416.GF18909@fieldses.org> (J. Bruce Fields's message of "Thu\, 15 Nov 2007 22\:54\:16 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65218>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> On Thu, Nov 15, 2007 at 01:36:40PM +0300, Sergei Organov wrote:
>> "J. Bruce Fields" <bfields@fieldses.org> writes:
[...]
>> >> @@ -1567,8 +1567,8 @@ old history using, for example,
>> >>  $ git log master@{1}
>> >>  -------------------------------------------------
>> >>  
>> >> -This lists the commits reachable from the previous version of the head.
>> >> -This syntax can be used to with any git command that accepts a commit,
>> >
>> > I actually prefer "head" here.  On something like:
>> >
>> > 		 A--B--C
>> > 		/
>> > 	o--o--o
>> > 		\
>> > 		 o--o--o
>> >
>> >
>> > The term "branch" could be used to refer to the whole line of
>> > development consisting of A, B, and C.  The term "head", on the other
>> > hand, refers to either C or a ref that points to it.  We also use the
>> > terms "branch head" or just "branch" for that case, but I think "head"
>> > is more precise.
>> 
>> Then I'd suggest to be precise here, e.g.:
>> 
>> "This lists the commits reachable from the previous version of the
>> "master" branch head."
>
> That sounds sensible to me, sure.

OK, I've just submitted patch for that.

-- 
Sergei.
