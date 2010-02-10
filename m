From: "John J. Franey" <jjfraney@gmail.com>
Subject: Re: A Visual Git Reference
Date: Wed, 10 Feb 2010 03:40:18 +0000 (UTC)
Message-ID: <hkt9r2$gi8$1@ger.gmane.org>
References: <ca433831002081134m698f531bwa22f0474db0cdcb@mail.gmail.com>
	<alpine.LNX.2.00.1002081513430.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 10 05:00:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf3kW-00046V-CA
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 05:00:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755281Ab0BJEAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 23:00:09 -0500
Received: from lo.gmane.org ([80.91.229.12]:48510 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755039Ab0BJEAH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 23:00:07 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nf3kD-0003xJ-HD
	for git@vger.kernel.org; Wed, 10 Feb 2010 05:00:05 +0100
Received: from pool-70-21-128-48.nwrk.east.verizon.net ([70.21.128.48])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Feb 2010 05:00:05 +0100
Received: from jjfraney by pool-70-21-128-48.nwrk.east.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Feb 2010 05:00:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pool-70-21-128-48.nwrk.east.verizon.net
User-Agent: Pan/0.133 (House of Butterflies)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139480>

On Mon, 08 Feb 2010 16:57:12 -0500, Daniel Barkalow wrote:

> On Mon, 8 Feb 2010, Mark Lodato wrote:
> 
>> All,
>> 
>> I put together a "Visual Git Reference" containing visualizations of
>> the most common git commands, for people who prefer to see images over
>> text.  It is designed as a reference, not a tutorial, so readers need
>> to have some amount of experience before the page will become useful.
>> 
>> URL: http://marklodato.github.com/visual-git-guide/ Git repo:
>> http://github.com/marklodato/visual-git-guide/
>> 
>> If you have any feedback or suggestions, please let me know!
> 
> The "3-way merge" node should graphically distinguish the base from the
> two sides, rather than having all three just go in. The "3-way merge"
> operation is tricky to understand visually without some sort of "split
> and rejoin, with specific points" thing.
> 
> Also, it would probably be worth showing the use of the index in the
> process of a 3-way merge: all three versions go into the blue box, and a
> combination (with conflict markers) goes into the pink box; the user
> cleans up the pink box, and replaces the 3-part blue box content with
> the cleaned-up single result content; then the commit gives the diagram
> you have for "git merge other".
> 

I often have difficulty trying to internally visualize a mapping from the 
commits of a merge to the panes of a kdiff3 session.  I have special 
difficulty keeping straight which commit is the LOCAL and which is the 
REMOTE.  Looking at your visual guide, I can almost see a kdiff session 
in this section on three way merge where each commit sits in one of the 
panes. b325c in upper left, ed489 in upper middle, and 33104 in upper 
right, "Working Directory" on the bottom pane.  Not sure if that graphic 
would be useful to anyone else.  Thought I'd throw it in for grins.

I learned a few things from your guide.  I've been using git for about a 
year and a half.  Thanks.

John
