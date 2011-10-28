From: Gelonida N <gelonida@gmail.com>
Subject: Re: git alias and --help
Date: Fri, 28 Oct 2011 11:17:52 +0200
Message-ID: <j8ds01$fc7$1@dough.gmane.org>
References: <j8clg9$ldh$1@dough.gmane.org> <7vfwiexe6m.fsf@alter.siamese.dyndns.org> <7v8vo6xd4u.fsf@alter.siamese.dyndns.org> <buoty6t9937.fsf@dhlpc061.dev.necel.com> <7vvcr9wyje.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 28 11:18:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJiZv-0007ZP-HG
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 11:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163Ab1J1JSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 05:18:12 -0400
Received: from lo.gmane.org ([80.91.229.12]:45475 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750915Ab1J1JSL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 05:18:11 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RJiZl-0007WM-R6
	for git@vger.kernel.org; Fri, 28 Oct 2011 11:18:09 +0200
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 11:18:09 +0200
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 11:18:09 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 ""
In-Reply-To: <7vvcr9wyje.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184345>

On 10/28/2011 06:05 AM, Junio C Hamano wrote:
> Miles Bader <miles@gnu.org> writes:
> 
>> Of course, that would be the wrong thing for somebody that just wants
>> to be reminded what an alias expands too, but my intuition is that
>> this is a very tiny minority compared to people that want to examine
>> the options for the underlying command...
> 
> And it is doubly wrong if help backend is configured to be anything but
> manpages, no?

Well. Then it is already doubly wrong today, isnt it?
The output of 'git help b'
is not a man page I assume.

In my opinion chaning it to a short message + the output of a man page
is not really worse than today's behaviour.

> 
> As I said, you should be able to come up with a patch that detects and
> special cases the no frills case (replacement to single token) to get what
> you want.

That's perhaps the most comfortable one, though occasionally I am even
interested in the help text of a git command if I had an alias like

l = log --name-status

to see what other switches I could add


(Thus an alternative suggestion to display both or to have a special
syntax allowing to force displaying of a man page)



Another small detail:

Let's assume I have following alias:

log = log --name-status


In this case I directly get the help text for git log
if I typed 'git log --help' (or 'git help log').
I don't even see, that my log is in reality aliased.
