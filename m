From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 00/14] ref-transactions-reflog
Date: Tue, 18 Nov 2014 20:46:36 +0100
Message-ID: <546BA21C.9030803@alum.mit.edu>
References: <1416274550-2827-1-git-send-email-sbeller@google.com>	<546B2CE0.6020208@alum.mit.edu> <CAL=YDWn1x9TMGOWrmT5KMpQ_iBR0AQ5Ej1yr1pBb4==k0-vchw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 20:46:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqojk-0001JW-5Y
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 20:46:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbaKRTqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 14:46:48 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:47811 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932112AbaKRTqr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Nov 2014 14:46:47 -0500
X-AuditID: 1207440d-f79976d000005643-cb-546ba21f02cc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id D1.4B.22083.F12AB645; Tue, 18 Nov 2014 14:46:39 -0500 (EST)
Received: from [192.168.69.130] (p5DDB3D42.dip0.t-ipconnect.de [93.219.61.66])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAIJkbhB022304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 18 Nov 2014 14:46:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <CAL=YDWn1x9TMGOWrmT5KMpQ_iBR0AQ5Ej1yr1pBb4==k0-vchw@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsUixO6iqCu/KDvE4O8GJYuuK91MFg29V5gt
	/k2osdi8uZ3FgcVjwaZSj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M7YeeQ6U8EW84p3t/6x
	NjC26XQxcnJICJhI7Ll5jBXCFpO4cG89WxcjF4eQwGVGidn/T0I555gkfh9rYgep4hXQljg0
	5RUziM0ioCrRu/s9WJxNQFdiUU8zE4gtKhAkcXLPdah6QYmTM5+wgNgiApoSN/tPg9UwC3Qy
	SkyfWtjFyMEhLGAq0bydEWLXMkaJ45dfgF3EKRAosfL7T3aIenWJP/MuMUPY8hLNW2czT2AU
	mIVkxSwkZbOQlC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGukl5tZopeaUrqJERLCvDsY
	/6+TOcQowMGoxMObMDUrRIg1say4MvcQoyQHk5Iob9S87BAhvqT8lMqMxOKM+KLSnNTiQ4wS
	HMxKIryC3UA53pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IE760FQI2C
	RanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoFiNLwZGK0iKB2jvB5B23uKCxFygKETr
	KUZFKXFeyYVACQGQREZpHtxYWGJ6xSgO9KUw71qQdh5gUoPrfgU0mAlo8JwNmSCDSxIRUlIN
	jEavk6t3xBcdW3tYPW+b//EbPbfe+fyfp7v3YcGmmu+LXfvFdy6Qjpj/74fh3MAy53wZXWPu
	97FS3Hnr/y9QCOITUv54e8tM1vSDElseFnbPPnOgoHH6yprCp9O/qXzurU+bvMp2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/18/2014 07:36 PM, Ronnie Sahlberg wrote:
> On Tue, Nov 18, 2014 at 3:26 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> On 11/18/2014 02:35 AM, Stefan Beller wrote:
>>> The following patch series updates the reflog handling to use transactions.
>>> This patch series has previously been sent to the list[1].
>>> [...]
>>
>> I was reviewing this patch series (I left some comments in Gerrit about
>> the first few patches) when I realized that I'm having trouble
>> understanding the big picture of where you want to go with this. I have
>> the feeling that the operations that you are implementing are at too low
>> a level of abstraction.
>>
>> What are the elementary write operations that are needed for a reflog?
>> Off the top of my head,
>>
>> 1. Add a reflog entry when a reference is updated in a transaction.
>> 2. Rename a reflog file when the corresponding reference is renamed.
>> 3. Delete the reflog when the corresponding reference is deleted [1].
>> 4. Configure a reference to be reflogged.
>> 5. Configure a reference to not be reflogged anymore and delete any
>>    existing reflog.
>> 6. Selectively expire old reflog entries, e.g., based on their age.
>>
>> Have I forgotten any?
>>
>> The first three should be side-effects of the corresponding reference
>> updates. Aside from the fact that renames are not yet done within a
>> transaction, I think this is already the case.
>>
>> Number 4, I think, currently only happens in conjunction with adding a
>> line to the reflog. So it could be implemented, say, as a
>> FORCE_CREATE_REFLOG flag on a ref_update within a transaction.
>>
>> Number 5 is not very interesting, I think. For example, it could be a
>> separate API function, disconnected from any transactions.
>>
>> Number 6 is more interesting, and from my quick reading, it looks like a
>> lot of the work of this patch series is to allow number 6 to be
>> implemented in builtin/reflog.c:expire_reflog(). But it seems to me that
>> you are building API calls at the wrong level of abstraction. Expiring a
>> reflog should be a single API call to the refs API, and ultimately it
>> should be left up to the refs backend to decide how to implement it. For
>> a filesystem-based backend, it would do what it does now. But (for
>> example) a SQL-based backend might implement this as a single SELECT
>> statement.
> 
> I agree in principle. But things are more difficult since
> expire_reflog() has very complex semantics.
> To keep things simple for the reviews at this stage the logic is the
> same as the original code:
>   loop over all entries:
>      use very complex conditionals to decide which entries to keep/remove
>      optionally modify the sha1 values for the records we keep
>      write records we keep back to the file one record at a time
> 
> So that as far as possible, we keep the same rules and behavior but we
> use a different API for the actual
> "write entry to new reflog".
> 
> 
> We could wrap this inside a new specific transaction_expire_reflog()
> function so that other types of backends, for example an SQL backend,
> could optimize, but I think that should be in a separate later patch
> because expire_reflog is almost impossibly complex.
> It will not be a simple SELECT unfortunately.
> 
> The current expire logic is something like :
>   1, expire all entries older than timestamp
>   2, optionally, also expire all entries that refer to unreachable
> objects using a different timestamp
>       This involves actually reading the objects that the sha1 points
> to and parsing them!
>   3, optionally, if the sha1 objects can not be referenced, they are
> not commit objects or if they don't exist, then expire them too.
>       This also involves reading the objects behind the sha1.
>   4, optionally, delete reflog entry #foo
>   5, optionally, if any log entries were discarded due to 2,3,4 then
> we might also re-write and modify some of the reflog entries we keep.
> or any combination thereof
> 
>   (6, if --dry-run is specified, just print what we would have expired)
> 
> 
> 2 and 3 requires that we need to read the objects for the entry
> 4 allows us to delete a specific entry
> 5 means that even for entries we keep we will need to mutate them.

Thanks for the explanation. I now understand that it might be more than
a single SELECT statement.

Regarding the complicated rules for expiring reflogs (1, 2, 3, 4): For
now I think it would be fine for the new expire_reflog() API function to
take a callback function as an argument.

Regarding the stitching together of the survivors (5), it seems like the
API function would be the right place to handle that.

Regarding 6, it sounds like you could run the reflog entries through
your callback and report what it *would* have expired.

>> I also don't have the feeling that reflog expiration has to be done
>> within a ref_transaction. For example, is there ever a reason to combine
>> expiration with other reference updates in a single atomic transaction?
> 
> --updateref
> In expire_reflog() we not only prune the reflog. When --updateref is
> used we update the actual ref itself.
> I think we want to have both the ref update and also the reflog update
> both be part of a single atomic transaction.

ISTM that --updateref is another aspect of stitching together the
surviving reflog entries and could properly be done by the API
expire_reflog() function. Maybe the implementation would use an
*internal* transaction. But I still don't see a need for the caller to
be able to combine *arbitrary* reflog changes with *arbitrary* reference
updates in a single transaction, and the unneeded flexibility seems to
require the API to become more complicated than necessary.

>> I think not.
>>
>> So it seems to me that it would be more practical to have a separate API
>> function that is called to expire selected entries from a reflog [2],
>> unconnected with any transaction.
> 
> I think it makes the API cleaner if we have a
> 'you can only update a ref/reflog/<other things added in the future>/
> from within a transaction.'
> 
> Since we need to do reflog changes within a transaction for the expire
> reflog case as well as the rename ref case
> I think it makes sense to enforce that reflog changes must be done
> within a transaction to just make it consistent.

I'm still not convinced. For me, "reflog_expire()" is an unusual outlier
operation, much like "git gc" or "git pack-refs" or "git fsck". None of
these are part of the beautiful Git data model; they are messy
maintenance operations. Forcing reference transactions to be general
enough to allow reflog expiration to be implemented *outside* the refs
API sacrificies their simplicity for lots of infrastructure that will
probably only be used to implement this single operation. Better to
implement reflog expiration *inside* the refs API.

That's my take on it, anyway.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
