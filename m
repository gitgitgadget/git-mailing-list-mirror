From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Simplified GIT usage guide
Date: Fri, 19 Dec 2008 10:26:16 +0100
Message-ID: <494B68B8.20107@drmicha.warpmail.net>
References: <20081212182827.28408.40963.stgit@warthog.procyon.org.uk> <c6d9bea0812181647n55fbb6b9w333702fc80127198@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Howells <dhowells@redhat.com>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: "C. Scott Ananian" <cscott@laptop.org>
X-From: git-owner@vger.kernel.org Fri Dec 19 10:27:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDbe0-0004kX-CI
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 10:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbYLSJ0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 04:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbYLSJ0W
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 04:26:22 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:32959 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750853AbYLSJ0U (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Dec 2008 04:26:20 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id DCFF41E725B;
	Fri, 19 Dec 2008 04:26:18 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 19 Dec 2008 04:26:18 -0500
X-Sasl-enc: n+fN1dgr/jZ6yXDJdJCxn65bs5MaEwlj+QQb/22o7WDS 1229678778
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 140E212479;
	Fri, 19 Dec 2008 04:26:17 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081105)
In-Reply-To: <c6d9bea0812181647n55fbb6b9w333702fc80127198@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103556>

C. Scott Ananian venit, vidit, dixit 19.12.2008 01:47:
> On Fri, Dec 12, 2008 at 1:28 PM, David Howells <dhowells@redhat.com> wrote:
>> Add a guide to using GIT's simpler features.
>> diff --git a/Documentation/git-haters-guide.txt b/Documentation/git-haters-guide.txt
>> +In the above example, I've assumed that you've got your own tree with the head
>> +at commit C3, and that you've got a branch that you want to merge, which has
>> +its head at commit B3.  After merging them, you'd end up with a directed,
>> +cyclic tree:
> 
> That should be, "acyclic".  There are no cycles, because the graph is directed.

Well, directed graphs can have cycles. But the revision graph of a
revision control system has to be an acyclic directed graph. Otherwise
parenthood would be a complicated matter ;)

And no, trees by definition don't have cycles. Also, a "tree" in git
lingo is not the graph theoretic notion (which David uses, though
incorrectly); this only adds unnecessary points of confusion.

For whatever reason the graphs in version control systems are called
"dag"s, i.e. directed acyclic graphs, even though "acyclicity" depends
on whether you look at the directed or undirected graphs. (Branching
then merging gives an undirected cycle.) I guess one may read "directed"
as an attribute to "acyclic" here, i.e. ((directed acyclic) graph)
rather than (directed (acyclic graph)); so to say "directedly acyclic
graph". Or it's just that "dag" reads much better than "adg"...

So, please: Simplification yes, but not if it's unnecessarily misleading
or even plain wrong (referring to the original proposal, not the comment).

Cheers,
Michael
