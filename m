From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Wed, 06 Feb 2013 11:17:01 +0100
Message-ID: <51122D9D.9040100@alum.mit.edu>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com> <5110BD18.3080608@alum.mit.edu> <7v8v72u0vw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 11:17:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U324M-0001o4-De
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 11:17:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118Ab3BFKRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 05:17:11 -0500
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:56798 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750772Ab3BFKRH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Feb 2013 05:17:07 -0500
X-AuditID: 12074411-b7fa36d0000008cc-ac-51122da13e88
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 4D.9B.02252.1AD22115; Wed,  6 Feb 2013 05:17:05 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r16AH2Es026777
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 6 Feb 2013 05:17:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <7v8v72u0vw.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsUixO6iqLtQVyjQ4PciPYuuK91MFg29V5gt
	frT0MFvMPzSR1YHF41nvHkaPi5eUPf6c38Pq8XmTXABLFLdNUmJJWXBmep6+XQJ3xqzvp1kL
	lodXnD74iaWB8YtrFyMnh4SAicSZB5PZIGwxiQv31gPZXBxCApcZJRb/bmWCcI4xSTzbO4kZ
	pIpXQFvi2ZYesA4WAVWJlouL2EFsNgFdiUU9zUwgtqhAmETv63OMEPWCEidnPmEBsUUE1CQm
	th0Cs5kF4iWeTFwPViMsoC6xq/0QO8SybkaJlz9usXYxcnBwCphJnGnUgajXkXjX94AZwpaX
	2P52DvMERoFZSFbMQlI2C0nZAkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW6pnq5mSV6qSml
	mxghAS24g3HGSblDjAIcjEo8vHMMBQOFWBPLiitzDzFKcjApifJe1xYKFOJLyk+pzEgszogv
	Ks1JLT7EKMHBrCTCG6sAlONNSaysSi3Kh0lJc7AoifPyLVH3ExJITyxJzU5NLUgtgsnKcHAo
	SfDm6QA1ChalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxINiNb4YGK0gKR6gvQUg7bzF
	BYm5QFGI1lOMxhz7n7Q/Z+TY/htICrHk5eelSonzMoKUCoCUZpTmwS2CpbJXjOJAfwvzpoFU
	8QDTINy8V0CrmIBWKeXwg6wqSURISTUwllpMPqPTI3B9cfLGyr+MTok/83v+BO4NP1rVH5V2
	0n3ebqlHvyYlxgZtnnr5W+cW/fVl7C9/nctxjbvzxOTc7++32Gv1Nxgn8my8rvCl 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215569>

On 02/05/2013 06:27 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> I would again like to express my discomfort about this feature, which is
>> already listed as "will merge to next".
> 
> Do not take "will merge to next" too literally.  One major purpose
> of marking a topic as such is exactly to solicit comments like this
> ;-)

I take "will merge to next" pretty seriously, because I know how hard it
is to get *my* patch series to this state :-)

>> * I didn't see a response to Peff's convincing arguments that this
>> should be a client-side feature rather than a server-side feature [1].
> 
> Uncluttering is not about a choice client should make.  "delayed
> advertisement" is an orthogonal issue and requires a larger protocol
> update (it needs to make "git fetch" speak first instead of the
> current protocol in which "upload-pack" speaks first).

There seem to be a few issues mixed up in this topic.  It is hard to
reason about your patch series without understanding which scenarios and
problems it is meant to address.  First the problems that we might like
to solve:

Clutter: The typical user is subjected to much unneeded clutter in the
         form of references that he/she will likely never use.

Bandwidth: Interactions with the remote repo (clone, fetch, etc) are
           slowed down by the large volume of unnecessary data.

Provenance: Users mistakenly think that content originates with the
            repository owner whereas it in fact came from some other
            (perhaps untrusted) source.


Now, what are some use-case scenarios in which these problems arise?  As
I understand it, there are a few:

Scenario 1: Some providers junk up their users' repositories with
content that is not created by the repository's owner and that the owner
doesn't want to appear to vouch for (e.g., GitHub pull requests).  These
references might sometimes be useful to fetch, singly or in bulk.

Scenario 2: Some systems junk up their users' repositories with
additional references that are not interesting to most pullers (e.g.,
Gerrit activity markers) though they don't add questionable content.

Scenario 3: Some repository owners might *themselves* want to push
references to their repository but hide them from most users (e.g.,
Junio's topic branches) or make them completely hidden from the rest of
the world (e.g., proprietary vs. open-source branches).

In most of these cases, it would be desirable for at least some users to
be able to fetch and/or push hidden content.

A first weakness of your proposal is that even though the hidden refs
are (optionally) fetchable, there is *no* way to discover them remotely
or to bulk-download them; they would have to be retrieved one by one
using out-of-band information.  And if I understand correctly, there
would be no way to push hidden references remotely (whether manually or
from some automated process).  Such processes would have to be local to
the machine holding the repository.

A second weakness of your proposal is that the repository owner would
*anyway* need local access to the repo server or the help of the
provider to implement reference hiding (since hidden references cannot
be configured remotely).  Who will choose what references to hide?  Most
likely each provider will pick a one-size-fits-all configuration and
apply it to all of the repos that they manage.  All users would be at
the mercy of their provider to make wise choices and would not be able
to override the choice via their client.

A third weakness of your hidden references proposal is that it is
schizophrenic: some references are hidden and undiscoverable, but their
content can nevertheless be made fetchable if the user happens to know
the SHA1.  This is more complicated to understand and reason about than
the rule "exactly the content that is referred to by published
references is fetchable".

What would be a better way?  Providers could expose multiple views of
the same repository; for example, one view with just the uncluttered
content, and a second view that includes *all* fetchable references.
Accessing the repository via the first view would give all of the
benefits provided by your hidden reference proposal.  Accessing it via
the second view would allow the hidden references to be fetched (even in
bulk) using purely git tools.  The documentation for the second view
could explain that it contains un-vetted content.

But your proposal does not admit two-tiered access to a single
repository.  You only support one hidden reference configuration that is
applied to all remote access [1].  See below for more ideas about
implementing multiple views.

>> * I didn't see a response to my worries that this feature could be
>> abused [3].
> 
> You can choose not to advertise allow-tip-sha1-in-want capability; I
> do not think it is making things worse than the status quo.

Yes, if the feature is turned off then it is not worse than the status
quo.  But what if the feature is turned on?

Actually, I'm still not clear about how these hidden references are
supposed to be created.  I know that you would forbid updating or
deleting hidden references via the remote protocol, but would you allow
them to be created?  If so, then it seems that any pusher can create
dark content.  Or can they only be created via a separate, local channel
to the repository?  In this case, it seems rather limiting that any
process that wants to create hidden references has to be local.

>> * Why should a repository have exactly one setting for what refs should
>> be hidden?  Wouldn't it make more sense to allow multiple "views" to be
>> defined?:
> 
> You are welcome to extend to have different views, but how would
> your clients express which view they would want?

There are several possibilities:

1. Assuming the cooperation of the provider, the provider could offer
two separate URLs: one for the uncluttered view and one for the
cluttered view.  The client would choose the view by choosing which URL
to clone from.  On the provider side, both of these URLs could refer to
the same Git repository but, for example, set an environment variable
GIT_VIEW differently depending on which URL was used.  This approach
would solve clutter, bandwidth and provenance but require cooperation
from the provider.

2a. Assuming no cooperation from the provider, the git client could have
options like "git fetch --view=uncluttered URL".  This would receive all
references from the server but discard any that are not included in the
client's "uncluttered" view definition.  This would solve clutter.

2b. Again assuming no cooperation from the provider, the user could
clone all references from the remote repo, but define a local
"uncluttered" view that hides the extra references on the local side.
The view could be selected by setting a local environment variable
GIT_VIEW or via configuration option "git config view.default
uncluttered".  This would solve clutter in a more flexible way because
the clutter would still be available locally for those occasions when
the user wants to see it.

Please note that none of the above options require a new remote protocol.

If/when a new protocol is implemented, then the client could tell the
server what view it wants and the server would only advertise those refs
to the client:

3a. The client could tell the host what reference namespaces it wants to
fetch.  Its choice would only be used for the single transaction and
would not be recorded on the server side.

3b. The client could pick a server-defined view by name.  The server
would look up the name in its own configuration to translate it into a
subset of references.  The views that a particular server supports would
be documented in the same place that the URL is documented and might
also be queryable by the client.  There should probably be some standard
views like "default" and "full" that every server would be expected to
implement.  Please note that this method can fall back to 2a when
communicating with a server that does not support the new protocol.

>> * Why should this feature only be available remotely?
> 
> The whole point is to give the server side a choice to show selected
> refs, so that it can use hidden portion for its own use.  These refs
> should not be hidden from local operations like "gc".

Certainly they shouldn't be hidden from "gc", but it would be useful to
be able to hide references from user-facing commands like "log --all",
"log --decorate", "gitk", "grep --all" etc.  For example, here are some
more scenarios where clutter is annoying:

Scenario 4: I occasionally share with colleague Foo, so I want to
configure his repo as a remote for mine and fetch his latest work:

    git remote add foo $URL
    git fetch foo

But now every time I do a "gitk --all" or "git log --decorate", the
output is cluttered with all of his references (most of which are just
old versions of references from the upstream repository that we both
use).  I would like to be able to hide his references most of the time
but turn them back on when I need them.

Scenario 5: Our upstream repository has gazillions of release tags under
"refs/tags/releases/...", sometimes including customer-specific
releases.  In my daily life these are just clutter.  (This scenario is
made worse by the fact that AFAIK there is no way to tell Git to fetch
some tags but not others others.)  But sometimes I need to track down a
bug in a particular release and need to access that release tag.  So it
would be nice to be able to hide and unhide them locally.

> I appreciate the comments, but I do not think any point you raised
> in this message is very much relevant as objections.

Tl;dr summary:

* Hidden refs don't give a way to offer two-tiered remote access to a
  repository (e.g., one uncluttered view and one full view), so

  * local access to the repository would (apparently) be required to
    put *anything* in the hidden namespaces.

  * they don't help in any scenario where you *sometimes*
    want to bulk fetch the hidden refs, and even make it awkward to
    fetch single hidden refs.

* Hidden refs introduce a confusing schizophrenia between "advertised"
  and "not advertised but nonetheless fetchable".

* Hidden refs require the cooperation of the provider to configure and
  will therefore be unusable by many repository owners.

* Some small improvements (e.g. allowing *multiple* views to be
  defined) would provide much more benefit for about the same effort,
  and would be a better base for building other features in the future
  (e.g., local views).

Thanks for listening.
Michael

[1] Theoretically one could support multiple views of a single
repository by using something like "GIT_CONFIG=view_1_config git
upload-pack ..." or "git -c transfer.hiderefs=... git upload-pack ...",
but this would be awkward.

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
