From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: GSoC idea: allow "git rebase --interactive" todo lines to take
 options
Date: Wed, 26 Feb 2014 12:14:11 +0100
Message-ID: <530DCC83.1060805@alum.mit.edu>
References: <530DA00E.4090402@alum.mit.edu> <20140226105249.GE25711@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 26 12:14:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIcRQ-000631-4N
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 12:14:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbaBZLOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 06:14:16 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:61267 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750755AbaBZLOP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Feb 2014 06:14:15 -0500
X-AuditID: 12074414-f79d96d000002d2b-bb-530dcc86f98d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id DE.B7.11563.68CCD035; Wed, 26 Feb 2014 06:14:14 -0500 (EST)
Received: from [192.168.69.148] (p57A2498D.dip0.t-ipconnect.de [87.162.73.141])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1QBECKe027651
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 26 Feb 2014 06:14:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <20140226105249.GE25711@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsUixO6iqNt2hjfY4P4SBYuuK91MFv3Lu9gs
	JtxvYLb40dLD7MDisXPWXXaPDx/jPJ717mH0+LxJLoAlitsmKbGkLDgzPU/fLoE7o2f3BbaC
	S/IVF96cY2lgvCzRxcjJISFgIvH6dgM7hC0mceHeerYuRi4OIYHLjBKfLvQyQzjnmSR69v1m
	BqniFdCWuLRvI5jNIqAq8frsLbBuNgFdiUU9zUwgtqhAsMTqyw9YIOoFJU7OfAJmiwjISnw/
	vJERxGYWWMUosWKHPogtLBAq0XP5DFivkECUxMre/UBXcHBwClhLbF4YCWJKCIhL9DQGgZjM
	AuoS6+cJQQyRl9j+dg7zBEbBWUh2zUKomoWkagEj8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQi
	XQu93MwSvdSU0k2MkAAX2cF45KTcIUYBDkYlHt4AFt5gIdbEsuLK3EOMkhxMSqK87ieAQnxJ
	+SmVGYnFGfFFpTmpxYcYJTiYlUR4k48D5XhTEiurUovyYVLSHCxK4rzfFqv7CQmkJ5akZqem
	FqQWwWRlODiUJHi/ngZqFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAfFbnwxMHpB
	UjxAe2eCtPMWFyTmAkUhWk8xGnPcbvv1iZHj6vZ/nxiFWPLy81KlxHlzQEoFQEozSvPgFsFS
	2ytGcaC/hXnfgVTxANMi3LxXQKuYgFYdleYBWVWSiJCSamCsP6g40Zk/54Xf9VCmOUb6d5KS
	XvveD9p8K963QLdeqi17k4qPq4lPYFBTlOCFhxw/fky5miHuxfNjpnlhstLTPW3b 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242720>

On 02/26/2014 11:52 AM, Jeff King wrote:
> On Wed, Feb 26, 2014 at 09:04:30AM +0100, Michael Haggerty wrote:
> 
>> It would be nice to support more flexibility in the todo-list commands
>> by allowing the commands to take options.  Maybe
>>
>> * Convert a commit into a merge commit:
>>
>>       pick -p c0ffeee -p e1ee712 deadbab The oneline of the commit after
> 
> This seems like a reasonable feature to me. All of your examples are
> possible with an "e"dit and another git command, but the convenience may
> be worth it (though personally, most of the examples you gave are
> particularly interesting to me[1]).
> 
> I'd worry a little that it is not a summer's worth of work, but I
> suspect there are other parts of rebase--interactive that could use
> attention once the student is familiar with the code.
> 
>> * After squashing two commits, add a "Signed-off-by" line to the
>>   commit log message:
>>
>>     pick deadbee Implement feature XXX
>>     squash --signoff f1a5c00 Fix to feature XXX
>>
>>   or GPG-sign a commit:
>>
>>     pick --gpg-sign=<keyid> deadbee Implement feature XXX
>>
>> * Reset the author of the commit to the current user or a specified
>>   user:
>>
>>     pick --reset-author deadbee Implement feature XXX
>>     pick --author="A U Thor <author@example.com>" deadbab The oneline of
>> the commit after
> 
> Your first example would need some commit-tree magic, I think. But could
> you implement these two with:
> 
>    pick deadbee Implement feature XXX
>    exec git commit --amend --signoff --reset-author
> 
> ? You could even alias the "amend" command to "exec git commit --amend",
> like:
> 
>   amend --signoff --reset-author
> 
> Maybe that is unnecessarily unfriendly to the user, though.

The whole point is to make these things easy.  But I have to admit that
"amend" would be another nice todo-list command.  Once the
infrastructure is there to handle options, it would be no big deal to
add an "amend" command with a "--signoff" option and offer the same
"--signoff" option on other, existing commands.

> [1] The one feature I would like in this vein is that editing the title
>     in the instruction-sheet would modify the commit message of the
>     relevant commit. For some reason I try to do this every few weeks,
>     but of course the changes are just thrown away.

Given that commit messages can be more than one line long, a feature
like this would be confusing, I think, and perhaps subtly encourage
people to limit their commit messages to a single line, which would be a
bad thing.  Plus, until now such edits were thrown away, so there are
backwards compatibility problems if we suddenly start preserving such edits.

But using the other ideas discussed here one could do

    pick -m "New log message" <sha1>

or

    amend -m "Revised log message"

It also might be reasonable, if the user edits the title in a way that
does not simply delete characters at the end, to do an implicit "reword"
with the edited title stuck in at the first line (and maybe the original
title following it, commented out with "#").

Another, more wonkish idea I though of would be

    pick --tree=<treeish> <sha1>

to force the tree of the commit to be set to that of the specified
<treeish> while keeping the commit metadata from <sha1>.  What would
this be useful for?  When swapping two commits, it is often the case
that conflicts have to be resolved twice.  But the tree should be the
same after both commits are applied, regardless of the order in which
they are applied.  So one could change

    pick aaaaaaa
    pick bbbbbbb

to

    pick bbbbbbb
    pick --tree=bbbbbbb aaaaaaa

On the other hand, maybe "git rebase --interactive" should have the
intelligence to do this automatically whenever the set of commits
pre/post rewriting is identical, possibly if a "--reorder-only" option
is used.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
