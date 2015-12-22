From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: RefTree: Alternate ref backend
Date: Tue, 22 Dec 2015 18:17:28 +0100
Message-ID: <567985A8.2020301@alum.mit.edu>
References: <CAJo=hJvnAPNAdDcAAwAvU9C4RVeQdoS3Ev9WTguHx4fD0V_nOg@mail.gmail.com>
 <56796F37.1000600@alum.mit.edu>
 <CAJo=hJtPSxY1YZgEt1AA_ukgY9cTA=1tdv_F+nCetv_Ux9E=3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>, David Turner <dturner@twopensource.com>,
	Jeff King <peff@peff.net>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 22 18:17:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBQZF-0003qf-EE
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 18:17:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956AbbLVRRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 12:17:33 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:56547 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752116AbbLVRRc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Dec 2015 12:17:32 -0500
X-AuditID: 1207440f-f79df6d000007c0f-3b-567985ab7770
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id F0.B8.31759.BA589765; Tue, 22 Dec 2015 12:17:31 -0500 (EST)
Received: from [192.168.69.130] (p4FC969CC.dip0.t-ipconnect.de [79.201.105.204])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tBMHHTFt004394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 22 Dec 2015 12:17:30 -0500
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.4.0
In-Reply-To: <CAJo=hJtPSxY1YZgEt1AA_ukgY9cTA=1tdv_F+nCetv_Ux9E=3g@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsUixO6iqLu6tTLMYMMBPov5m04wWnRd6Way
	+NHSw2wx/9BEVgcWj2e9exg9/pzfw+qx4Pl9do/Pm+QCWKK4bZISS8qCM9Pz9O0SuDOWrlvG
	VtBpXPH4wAXWBsZOzS5GTg4JAROJjbeXskLYYhIX7q1n62Lk4hASuMwosXDeSxaQhJDABSaJ
	GWuEQWxhAW2J592/wBpEBNQktl/oYYVo2MkoMb35DxtIglkgS2Lxn1dgRWwCuhKLepqZIDbI
	SfR2TwIbygs0aNKXycwgNouAqsSSec/AekUFQiT27uyAqhGUODnzCZjNKRAo0bLsPiPEfHWJ
	P/MuMUPY8hLNW2czT2AUnIWkZRaSsllIyhYwMq9ilEvMKc3VzU3MzClOTdYtTk7My0st0jXR
	y80s0UtNKd3ECAl1/h2MXetlDjEKcDAq8fBOWFARJsSaWFZcmXuIUZKDSUmUV6CuMkyILyk/
	pTIjsTgjvqg0J7X4EKMEB7OSCO+bBqAcb0piZVVqUT5MSpqDRUmcV32Jup+QQHpiSWp2ampB
	ahFMVoaDQ0mCd3sLUKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KIbji4FRDJLi
	Ado7C6Sdt7ggMRcoCtF6ilFRSpx3IUhCACSRUZoHNxaWwF4xigN9Kcx7FKSKB5j84LpfAQ1m
	Ahr8Z105yOCSRISUVAOjPcMlf6EJN/5+CzTbP7dpxoYclqLJ59ernC/7eOFxrXS9pMXLZX/u
	fvc1fBSh1b6HuWRRCnPt3Rlr3T/9fMeRaq/ZcG23wETxZZtfpHDxsR/km7c9IbhF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282889>

On 12/22/2015 05:11 PM, Shawn Pearce wrote:
> On Tue, Dec 22, 2015 at 7:41 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> On 12/17/2015 10:02 PM, Shawn Pearce wrote:
>>> I started playing around with the idea of storing references directly
>>> in Git. Exploiting the GITLINK tree entry, we can associate a name to
>>> any SHA-1.
>> [...]
>> I'm curious why you decided to store all of the references in a single
>> list, similar to the packed-refs file. [...]
> 
> I did use tree objects for each directory component. The ls-tree I
> showed was an ls-tree -r.

Silly me. Of course that was clear from your post, and I just overlooked it.

>> Another reason that I find a hierarchical layout intriguing would be
>> that one could imagine using the SHA-1s of reference namespace subtrees
>> to speed up the negotiation phase of "git fetch". [...]
> 
> Yes. Martin Fick and I were discussing a strategy like this at the
> Gerrit User Summit in November. I totally forgot about it when I
> started this thread, but I'm glad you independently proposed it. Maybe
> its not a horrible idea!  :)
> 
> One problem is clients don't mirror the heads tree exactly; they add
> in HEAD as a symbolic reference in a way that the remote peer doesn't
> have. Minor detail.

Yes, and this is a side effect of leaving out a layer of the remote
reference namespace in the local refs/remotes layout. Naively one would
expect

    refs/remotes/origin/HEAD
    refs/remotes/origin/refs/heads/master

etc. But we store branches into the main "refs/remotes/origin/"
namespace, leaving no reserved space for the remote "HEAD" (not to
mention other namespaces that might appear on the remote, such as
"refs/changes/*", "refs/pull/*", a separate record of the remote's
"refs/tags/*", etc).

Maybe that is why my gut reaction to your proposal to elide the "refs"
part of the reference hierarchy and store "HEAD" as (effectively)
"refs/..HEAD" was negative, even though I can't think of any practical
objections.

At a deeper level, the "refs/" part of reference names is actually
pretty useless in general. I suppose it originated in the practice of
storing loose references under "refs/" to keep them separate from other
metadata in $GIT_DIR. But really, aside from slightly helping
disambiguate references from paths in the command line, what is it good
for? Would we really be worse off if references' full names were

    HEAD
    heads/master
    tags/v1.0.0
    remotes/origin/master (or remotes/origin/heads/master)

etc? This notation is already recognized in most places (though not in
"update-ref"). I think your decision to elide "refs/" in the reftree
hierarchy is a reflection of its uselessness. In any case, your decision
is much less questionable than the decision to mash "refs/heads/*" all
the way up to the top level like we do in "refs/remotes/".

> Martin and I were really thinking about server-server negotiation more
> than client-server. [...]

Yes, that's also an interesting application.

>> There are a lot of "if"s in that last paragraph, and maybe it's not
>> workable. For example, if I'm not pruning on fetch, then my reference
>> tree won't be identical to one that was ever present on the server and
>> this technique wouldn't necessarily help. But if, for example, we change
>> the default to pruning, or perhaps record some extra reftree SHA-1's,
>> then in most cases I would expect that this trick could reduce the
>> effort of negotiation to negligible in most cases, and reduce the time
>> of the whole fetch to negligible in the case that the clone is already
>> up-to-date.
> 
> Right, maybe the client just remember's the server's reftree SHA-1 and
> offers it back on reconnection. The server can then diff between the
> two reftrees and shows the client only refs that were modified that
> the client cares about.

The client not only has to remember the server's reftree, but also must
verify that it still has all of the objects implied by that reftree, in
case a reference somehow got deleted under "refs/remotes/origin/*". At
that point, there is no special reason to use a SHA-1 in the
negotiation; any unique token generated by the server would suffice if
the server can connect it back to a set of references that was sent to
the client in the past.

The advantage of using hierarchical reftree SHA-1s in the negotiation is
that they can be used to name part of the reftree. For example, if I
fetch "refs/heads/*" from a remote but not "refs/changes/*", then what
do I report as my "have-tree"? I can't claim to have *all* of the
references that the remote had at the time. But with SHA-1s I can say
that I have the reftree that corresponds to my
"refs/remotes/origin/heads/", which the remote can notice is identical
to an old reftree that it happened to have for "refs/heads/" (without
even caring what path it represented). Bingo, we've just agreed about a
big part of the reference namespace without having to agree about the
whole namespace.

In practice, in my first "haves" announcement I would probably list a
few "famous" namespaces in the hope that one or more of them are
recognized by the server:

    have-tree <SHA-1 for "refs/">
    have-tree <SHA-1 for "refs/heads/">
    have-tree <SHA-1 for "refs/tags/">
    have-tree <SHA-1 for "refs/remotes/origin/heads/">
    have-tree <SHA-1 for "refs/remotes/other/heads/">

> [...]
> FWIW, JGit is able to scan the canonical trees out of a pack file and
> inflate them in approximately the same time it takes to scan the
> packed-refs file for some 70k references. So we don't really slow down
> much to use this. And there's huge gains to be had by taking advantage
> of the tree structure and only inflating the components you need to
> answer a particular read.

Yes, that's another nice aspect of the design.

I do worry a bit that the hierarchical storage only helps if people
shard their reference namespace reasonably. Somebody who stores 100k
references in a single reference "directory" (imagine a
"refs/ci-tests/*") is going to suffer from expensive reference update
performance. But I guess they will suffer from poor performance within
Git as well, and that will probably encourage them to improve their
practices :-) I suppose this is not really much different than people
who store 100k files within a single directory of their working tree.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
