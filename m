From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 0/3] Make update refs more atomic
Date: Wed, 16 Apr 2014 23:51:09 +0200
Message-ID: <534EFB4D.2070500@alum.mit.edu>
References: <1397500163-7617-1-git-send-email-sahlberg@google.com>	<534CD376.7080108@alum.mit.edu>	<CAL=YDWmm1pDtNuibs5CrPTDkaxT9PUvZscXFicoNsNpXVXJv1A@mail.gmail.com>	<534D9741.3010404@alum.mit.edu>	<CAL=YDW=g=jkm4yhBvnZXSvLLm-6ZGhJORKv_evg66v0U=E71FA@mail.gmail.com> <xmqq1twxgjge.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 23:51:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaXji-0007Mu-CA
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 23:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754914AbaDPVvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 17:51:13 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:62962 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751390AbaDPVvM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Apr 2014 17:51:12 -0400
X-AuditID: 12074412-f79d46d000002e58-3a-534efb4f7883
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 93.0A.11864.F4BFE435; Wed, 16 Apr 2014 17:51:11 -0400 (EDT)
Received: from [192.168.69.130] (p4FC9722C.dip0.t-ipconnect.de [79.201.114.44])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3GLp9Vg003635
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 16 Apr 2014 17:51:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <xmqq1twxgjge.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqOv/2y/YYPFbfouuK91MFg29V5gt
	/k2ocWD2WLCp1OPiJWWPz5vkApijuG2SEkvKgjPT8/TtErgz9p7yKGgzr3j6ez17A+NKnS5G
	Tg4JAROJs0s6mSBsMYkL99azdTFycQgJXGaUeD/7ODuEc55JYsWNo+wgVbwC2hKT+xezgtgs
	AqoSP5bsYwax2QR0JRb1NANN4uAQFQiS+HNWEaJcUOLkzCcsILaIgK/Et/t9YGOYBfQlPv05
	ALZYWMBComX+NWaIXbuZJE6t7wGbzylgLbHw0VuwmRIC4hI9jUEQvToS7/oeMEPY8hLb385h
	nsAoOAvJullIymYhKVvAyLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdMLzezRC81pXQTIySY
	hXYwrj8pd4hRgINRiYeXodY3WIg1say4MvcQoyQHk5Iob8dPv2AhvqT8lMqMxOKM+KLSnNTi
	Q4wSHMxKIryZZ4FyvCmJlVWpRfkwKWkOFiVx3p+L1f2EBNITS1KzU1MLUotgsjIcHEoSvO6/
	gBoFi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQfEbXwyMYJAUD9BesHbe4oLEXKAo
	ROspRl2OCw0rWpiEWPLy81KlxHlngBwuAFKUUZoHtwKWul4xigN9LMwbATKKB5j24Ca9AlrC
	BLTkULgvyJKSRISUVANjmsSFeCXh6+rm9pz8SlN9oycZNHL9enVOoHXvMcmYNKaoA16VV91v
	pz1/9PxHQnLNyckn929h1Fzq4x68XPyakMypNT9lS1VlNhQ2Vew69p1B40bPxrhH 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246384>

On 04/16/2014 09:31 PM, Junio C Hamano wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
> 
>> Currently any locking of refs in a transaction only happens during the commit
>> phase. I think it would be useful to have a mechanism where you could
>> optionally take out locks for the involved refs early during the transaction.
>> So that simple callers could continue using
>> ref_transaction_begin()
>> ref_transaction_create|update|delete()*
>> ref_transaction_commit()
>>
>> but, if a caller such as walker_fetch() could opt to do
>> ref_transaction_begin()
>> ref_transaction_lock_ref()*
>> ...do stuff...
>> ref_transaction_create|update|delete()*
>> ref_transaction_commit()
>>
>> In this second case ref_transaction_commit() would only take out any locks that
>> are missing during the 'lock the refs" loop.
>>
>> Suggestion 1: Add a ref_transaction_lock_ref() to allow locking a ref
>> early during
>> a transaction.
> 
> Hmph.
> 
> I am not sure if that is the right way to go, or instead change all
> create/update/delete to take locks without adding a new primitive.

Junio's suggestion seems like a good idea to me.  Obviously, as soon as
we take out a lock we could also do any applicable old_sha1 check and
possibly fail fast.

Does a "verify" operation require holding a lock?  If not, when is the
verification done--early, or during the commit, or both?  (I realize
that we don't yet *have* a verify operation at the API level, but we
should!)

We also need to think about for what period of time we have to hold the
packed-refs lock.

Finally, we shouldn't forget that currently the reflog files are locked
by holding the lock on the corresponding loose reference file.  Do we
need to integrate these files into our system any more than they
currently are?

[By the way, I noticed the other day that the command

    git reflog expire --stale-fix --expire-unreachable=now --all

can hold loose reference locks for a *long* time (like 10s of minutes),
especially in weird cases like the repository having 9000 packfiles for
some reason or another :-)  The command execution time grows strongly
with the length of the reference's log, or maybe even the square of the
length assuming the history is roughly linear and reachability is
computed separately for each SHA-1.  This is just an empirical
observation so far; I haven't looked into the code yet.]

>> A second idea is to change the signatures for
>> ref_transaction_create|update|delete()
>> slightly and allow them to return errors early.
>> We can check for things like add_update() failing, check that the
>> ref-name looks sane,
>> check some of the flags, like if has_old==true then old sha1 should
>> not be NULL or 0{40}, etc.
>>
>> Additionally for robustness, if any of these functions detect an error
>> we can flag this in the
>> transaction structure and take action during ref_transaction_commit().
>> I.e. if a ref_transaction_update had a hard failure, do not allow
>> ref_transaction_commit()
>> to succeed.
>>
>> Suggestion 2: Change ref_transaction_create|delete|update() to return an int.
>> All callers that use these functions should check the function for error.
> 
> I think that is a very sensible thing to do.
> 
> The details of determining "this cannot possibly succeed" may change
> (for example, if we have them take locks at the point of
> create/delete/update, a failure to lock may count as an early
> error).
> 
> Is there any reason why this should be conditional (i.e. you said
> "allow them to", implying that the early failure is optional)?

Also a good suggestion.  We should make it clear in the documentation
that the create/delete/update functions are not *obliged* to return an
error (for example that the current value of the reference does not
agree with old_sha1) because future alternate ref backends might
possibly not be able to make such checks until the commit phase.  For
example, checking old_sha1 might involve a round-trip to a database or
remote repository, in which case it might be preferable to check all
values in a single round-trip upon commit.

So, callers might be informed early of problems, or they might only
learn about problems when they try to commit the transaction.  They have
to be able to handle either type of error reporting.

So then the question arises (and maybe this is what Ronnie was getting
at by suggesting that the checks might be conditional): are callers
*obliged* to check the return values from create/delete/update, or are
they allowed to just keep throwing everything into the transaction,
ignoring errors, and only check the result of ref_transaction_commit()?

I don't feel strongly one way or the other about this question.  It
might be nice to be able to write callers sloppily, but it would cost a
bit more code in the reference backends.  Though maybe it wouldn't even
be much extra code, given that we would probably want to put consistency
checks in there anyway.

>> Suggestion 3: remove the qsort and check for duplicates in
>> ref_transaction_commit()
>> Since we are already taking out a lock for each ref we are updating
>> during the transaction
>> any duplicate refs will fail the second attempt to lock the same ref which will
>> implicitly make sure that a transaction will not change the same ref twice.
> 
> I do not know if I care about the implementation detail of "do we
> have a unique set of update requests?".  While I do not see a strong
> need for one transaction to touch the same ref twice (e.g. create to
> point at commit A and update it to point at commit B), I do not see
> why we should forbid such a use in the future.

I agree.  For example, we might very well want to allow multiple updates
to a single reference, as long as they are mutually consistent, to be
coalesced into a single update.  I also expect that the error message in
the current code is more illuminating than the generic error message
that would result from the inability to lock a reference (because it is
already locked by an earlier update in the same transaction!)  Let's
leave this aspect the way it is now and revisit the topic later when we
have learned more.

I see, though, that this will be a little tricky to implement early
locking.  Currently we sort all of the updates and look for duplicates
*before* we acquire any locks.  But if we want to acquire locks
immediately, then (since the list isn't sorted yet) it will be expensive
to look for duplicates before attempting to lock.  I can see two
possibilities:

1. Use a different data structure, like a hash map, for storing updates,
so that we have a cheap way to lookup whether there is already an update
involving a reference.

2. Try to lock the reference, and if the lock fails *then* look back
through the list to see if we're the ones holding the lock already.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
