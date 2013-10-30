From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 10/15] fetch --tags: fetch tags *in addition to* other
 stuff
Date: Wed, 30 Oct 2013 05:26:41 +0100
Message-ID: <52708A81.7060300@alum.mit.edu>
References: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>	<1382543448-2586-11-git-send-email-mhagger@alum.mit.edu>	<xmqqob6emlxu.fsf@gitster.dls.corp.google.com>	<526A896D.7050801@alum.mit.edu> <xmqqa9htfbzn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 05:34:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbNTj-00018u-Q8
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 05:34:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733Ab3J3Edz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 00:33:55 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:45094 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750702Ab3J3Edy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 00:33:54 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Oct 2013 00:33:54 EDT
X-AuditID: 12074412-b7fc96d0000023d5-a4-52708a89b002
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id B6.12.09173.98A80725; Wed, 30 Oct 2013 00:26:49 -0400 (EDT)
Received: from [192.168.69.9] (p57A242F8.dip0.t-ipconnect.de [87.162.66.248])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9U4QfSL011348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 30 Oct 2013 00:26:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <xmqqa9htfbzn.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBKsWRmVeSWpSXmKPExsUixO6iqNvZVRBkMG+zlcX0rtUsFl1Xupks
	GnqvMFvMu7uLyWLVrWXMFitn3GC0eNpZaTHvxQs2ix8tPcwOnB6X1r1k8jj0Zwq7x7MT7Wwe
	l15+Z/N41ruH0ePiJWWPGS2vWTw+b5LzOHD5MVsAZxS3TVJiSVlwZnqevl0Cd8aUu+EF1/Ur
	Oja9YW1gnK3WxcjJISFgIrFvwhFWCFtM4sK99WxdjFwcQgKXGSUe3TrBDuGcZZI4c/8yO0gV
	r4C2xPr1vWA2i4CqxLtDM8FsNgFdiUU9zUwgtqhAiMTCVceh6gUlTs58wgJiiwioSUxsO8QC
	MpRZ4BeTRPumpWwgCWGBIIn37fPBzhAS+MUosW09D4jNKWAtMW3qTrA4s4COxLu+B8wQtrzE
	9rdzmCcwCsxCsmMWkrJZSMoWMDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI108vNLNFLTSnd
	xAiJGaEdjOtPyh1iFOBgVOLhNXiQHyTEmlhWXJl7iFGSg0lJlPdneUGQEF9SfkplRmJxRnxR
	aU5q8SFGCQ5mJRHe6ceBynlTEiurUovyYVLSHCxK4rw/F6v7CQmkJ5akZqemFqQWwWRlODiU
	JHhjO4GGChalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxINiNb4YGK0gKR6gvT4g7bzF
	BYm5QFGI1lOMuhzzvnz4xijEkpeflyolzhsOUiQAUpRRmge3ApYgXzGKA30szNsCUsUDTK5w
	k14BLWECWrKHJQ9kSUkiQkqqgZFNKcxlilmk12yd8He/vmzj2v+mjPmxu4mLaN6r 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236957>

On 10/28/2013 08:10 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>>> True but when fetching other references, tags relevant to the
>>> history being fetched by default should automatically follow, so the
>>> above explains why "fetch --tags" is not a useful thing to do daily.
>>
>> Maybe not necessary in many scenarios, but is it harmful for the common
>> case of cloning from and then periodically fetching from an upstream?
> 
> There is no mention of "harmful"; I only said "not useful". And it
> comes primarily from knowing why "--tags" was introduced in the
> first place; I should have said "less useful than before, ever since
> we started to reliably auto-follow".
> 
> The only "harmful" part is its interaction with "--prune", which
> your series nicely addresses.

OK, then we are in agreement.

>> ISTM that the result of the declarative --tags option
>>
>>     we have all upstream tags
>>
>> is easier to reason about than the history-dependent tag-following behavior
> 
> I'd say "we have all the relevant tags" and "we have all the tags
> the other side has" are equally valid things to wish for, depending
> who you are and how your project is organized, and one is not
> necessarily easy/useful than the other.  In case it was unclear, I
> was not seriously advocating to deprecate/remove "--tags".

Yes, I agree that both are valid things to wish for.  I guess I was
mostly thinking about which would be a better default.

"clone" and "remote add", by default, configure the repo to fetch all
branches on the remote.  For this default setup, what are the pros and
cons of the two tag-fetching options (assuming that this patch series
has fixed the problem with tag pruning)?

Pros of auto-following:

* Doesn't require a change to the status quo

* The the user can change the refspec to be more restrictive without
having to change the tag-following option and it continues to do the
right thing.

* If the project has branches outside of refs/heads (which would not, by
default, be fetched--think continuous integration artifacts) and also
has tags pointing at those branches, the user might get unwanted
contents with "--tags", but not with auto-following.


Pros of --tags:

* Easier to understand (?) because result is not history-dependent.

* Avoids missing tags that are not directly on a branch:

      o---o---o---o    <- branch
           \
            o      <- tag

So it's not obvious that one is better than the other.  I think if I
were choosing the behavior for the first time, I would favor --tags.
But I don't think the advantage is strong enough to make it worth
changing the existing default.

>> Regarding your first point: if it matters which of the duplicates is
>> chosen, then it can only matter because they differ in some other way
>> than their reference names, for example in their flags.  So a robust way
>> of de-duping them (if it is possible) would be to compare the two
>> records and decide which one should take precedence based on this other
>> information rather than based on which one happened to come earlier in
>> the list.  Then the list order would be immaterial and (for example) it
>> wouldn't be a problem to reorder the items.
> 
> But that changes the behaviour to those who has cared to rely on the
> ordering.  With the change to first collect and then sort unstably
> before deduping, the series already tells them not to rely on the
> order, and two of us tentatively agreed in this discussion that it
> is not likely to matter.  If later this agreement turns out to be a
> mistake and there are people who *do* rely on the ordering, the only
> acceptable fix for them is by making sure we restore the "first one
> trumps" semantics, not by defining an alternative, arguably better,
> behaviour---that is not a regression fix.

Please note that the current patch series does *not* change the
algorithm to use an unstable sort; that was only a suggestion for the
future should somebody discover that the O(N^2) algorithm in this
function is a performance bottleneck.

What the old patch series *did* do was change the ordering that
get_ref_map() adds references to the list in the case of (refspec_count
&& tags == TAGS_SET) by moving the (tags == TAGS_SET) handling outside
of the "true" branch of the (refspec_count) conditional.  This had the
result that the references added by

       get_fetch_map(remote_refs, tag_refspec, &tail, 0);

came after, rather than before, the references opportunistically being
fetched with FETCH_HEAD_IGNORE status.

But I dug even deeper and found that there was a (rather obscure)
situation where the ordering change could lead to incorrect behavior,
namely if all of the following are true:

* there is a configured refspec for tags, like refs/tags/*:refs/tags/*

* the user runs fetch with the --tags option and also with an explicit
refspec on the command line to fetch a remote tag (e.g.,
refs/tags/foo:refs/heads/foo).

In that case (after this version of this patch), an entry for
refs/tags/foo:refs/heads/foo would be added to the list, then the
opportunistic "refs/tags/foo:refs/tags/foo" would be added with
FETCH_HEAD_IGNORE.  Then the --tags option would be processed, adding a
second record "refs/tags/foo:refs/tags/foo" to the list, but this time
with FETCH_HEAD_NOT_FOR_MERGE.  The call to ref_remove_duplicates()
would remove the last entry, leaving the entry with FETCH_HEAD_IGNORE
instead of the (correct) entry with FETCH_HEAD_NOT_FOR_MERGE.  The
result would be that refs/tags/foo would not be written to FETCH_HEAD.

So I will re-roll this series with a few extra patches that first, avoid
subjecting the --tags entries to the opportunistic-update machinery (it
is redundant), and also preserve the old order where the --tags entries
precede the opportunistic entries in the list.

Thanks again for your comments!
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
