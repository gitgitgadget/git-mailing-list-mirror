From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Tag peeling peculiarities
Date: Sat, 16 Mar 2013 14:38:12 +0100
Message-ID: <514475C4.7020901@alum.mit.edu>
References: <51409439.5090001@alum.mit.edu> <7vwqtb2ood.fsf@alter.siamese.dyndns.org> <20130313215800.GA23838@sigill.intra.peff.net> <51415516.2070702@alum.mit.edu> <20130314052448.GA2300@sigill.intra.peff.net> <5141B475.1000707@alum.mit.edu> <20130314134032.GA9222@sigill.intra.peff.net> <514431EA.2050402@alum.mit.edu> <20130316093441.GA26260@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 16 14:38:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGrJs-0000V5-65
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 14:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227Ab3CPNiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Mar 2013 09:38:17 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:58188 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932091Ab3CPNiQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Mar 2013 09:38:16 -0400
X-AuditID: 1207440c-b7ff06d0000008f7-64-514475c786b7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 8C.33.02295.7C574415; Sat, 16 Mar 2013 09:38:15 -0400 (EDT)
Received: from [192.168.69.140] (p57A24A2D.dip.t-dialin.net [87.162.74.45])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r2GDcCR0020143
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 16 Mar 2013 09:38:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <20130316093441.GA26260@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsUixO6iqHu81CXQYOsBK4uuK91MFg29V5gt
	frT0MDswezzr3cPocfGSssfnTXIBzFHcNkmJJWXBmel5+nYJ3Bl/ur0LzttUXDh7i7WBscug
	i5GTQ0LARGLK3jusELaYxIV769m6GLk4hAQuM0pc+tPPBOGcZpI40/qXDaSKV0Bb4uC+diCb
	g4NFQFWi/18sSJhNQFdiUU8zE4gtKhAmsffCNKhyQYmTM5+wgNgiArIS3w9vZASxmQWiJM6/
	/A8WFxZQk1g99TkjxK73TBK9B3vALuIUsJbo3PaDGWQXs4C6xPp5QhC98hLb385hnsAoMAvJ
	ilkIVbOQVC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuol5tZopeaUrqJERK2PDsYv62T
	OcQowMGoxMOr4ewcKMSaWFZcmXuIUZKDSUmU922JS6AQX1J+SmVGYnFGfFFpTmrxIUYJDmYl
	Ed79RkA53pTEyqrUonyYlDQHi5I4r+oSdT8hgfTEktTs1NSC1CKYrAwHh5IE72+QoYJFqemp
	FWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgKI0vBsYpSIoHaO9TkHbe4oLEXKAoROspRmOO
	BdcevWDk2P0OSAqx5OXnpUqJ864EKRUAKc0ozYNbBEtYrxjFgf4W5mUDpi8hHmCyg5v3CmgV
	E9CqfVecQFaVJCKkpBoYS5L1/XYseRS289rqiiXuvXIbBJckT4nlOn3NLP3yTrNTHJsLS1Y1
	+H5S0jn/8YzA13Wm/moXl/xwe5u24+Oj6lZX5/v87qo2blNCqx34b7saat6/+jrx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218303>

On 03/16/2013 10:34 AM, Jeff King wrote:
> On Sat, Mar 16, 2013 at 09:48:42AM +0100, Michael Haggerty wrote:
> 
>> My patch series is nearly done.  I will need another day or two to
>> review and make it submission-ready, but I wanted to give you an idea of
>> what I'm up to and I could also use your feedback on some points.
> 
> I was just sending out my cleaned up patches to do do fully-peeled, too.
> I think the duplication is OK, though, as your topic would be for
> "master" and mine can go to "maint".

Yes, though I'll have to rebase mine on top of yours.

>> * Implement fully-peeled packed-refs files, as discussed upthread: peel
>>   references outside of refs/tags, and keep rigorous track of
>>   which references have REF_KNOWS_PEELED.
> 
> Looks pretty similar to mine. We even added similar tests.
> 
> I notice that you do the "add REF_KNOWS_PEELED if we actually got a peel
> line" optimization. I didn't bother, because this will never be
> triggered by a git-written file (either we do not write the entry, or we
> set fully-peeled). I wonder if any other implementation does peel every
> ref, though.

We read the peeled value for refs outside of refs/tags even if
fully-peeled is not set, so it seemed somehow inconsistent not to set
REF_KNOWS_PEELED.  But I agree that Git itself should never write such
entries, except of course for the interval between your first patch and
your second patch ;-)

>> * Change pack-refs to use the peeled information from ref_entries if it
>>   is available, rather than looking up the references again.
> 
> I don't know that it matters from a performance standpoint (we don't
> really care how long pack-refs takes, as long as it is within reason,
> because it is run as part of a gc).  But it would mean that any errors
> in the file are propagated from one run of pack-refs to the next. I
> don't know if we want to spend the extra time to be more robust.

I thought about this argument too.  Either way is OK with me.  BTW would
it make sense to build a consistency check of peeled references into fsck?

>> * repack_without_ref() writes peeled refs to the packed-refs file.
>>   Use the old values if available; otherwise look them up.
> 
> Whereas here we probably _do_ want the performance optimization, because
> we do care about the performance of a ref deletion.

Agreed.

>> 1. There are multiple functions for peeling refs:
>>    peel_ref() (and peel_object(), which was extracted from it);
>>    peel_entry() (derived from pack-refs.c:pack_one_ref()).  It would be
>>    nice to combine these into the One True Function.  But given the
>>    problem that you mentioned above (which is rooted in parts of the
>>    code that I don't know) I don't know what that version should do.
> 
> I'm not sure I understand the question. Just skimming your patches, it
> looks like peel_entry could just call peel_object?

I believe that the version in peel_object() is the one that you
optimized in your now-famous 435c833 patches, which your earlier email
said was connected to a null pointer dereference.  I'm not at all
familiar with the API being used there, so I don't know whether the two
versions are interchangeable, or whether you need to fix your
optimization, or whether your optimization will need to be reverted
because of the problem you discovered.

>> 2. repack_without_ref() now writes peeled refs, peeling them if
>>    necessary.  It does this *without* referring to the loose refs
>>    to avoid having to load all of the loose references, which can be
>>    time-consuming.  But this means that it might try to lookup SHA1s
>>    that are not the current value of the corresponding reference any
>>    more, and might even have been garbage collected.
> 
> Yuck. I really wonder if repack_without_ref should literally just be
> writing out the exact same file, minus the lines for the deleted ref.
> Is there a reason we need to do any processing at all? I guess the
> answer is that you want to avoid re-parsing the current file, and just
> write it out from memory. But don't we need to refresh the memory cache
> from disk under the lock anyway? That was the pack-refs race that I
> fixed recently.

It would certainly be thinkable to rewrite the file textually without
parsing it again.  But I did it this way for two reasons:

1. It would be better to have one packed-refs file parser and writer
rather than two.  (I'm working towards unifying the two writers, and
will continue once I understand their differences.)

2. Given how peeled references were added, it seems dangerous to read,
modify, and write data that might be in a future format that we don't
entirely understand.  For example, suppose a new feature is added to
mark Junio's favorite tags:

    # pack-refs with: peeled fully-peeled junios-favorites \n
    ce432cac30f98b291be609a0fc974042a2156f55 refs/heads/master
    83b3dd7151e7eb0e5ac62ee03aca7e6bccaa8d07 refs/tags/evil-dogs
    ^e1d04f8aad59397cbd55e72bf8a1bd75606f5350
    7ed863a85a6ce2c4ac4476848310b8f917ab41f9 refs/tags/lolcats
    ^990f856a62a24bfd56bac1f5e4581381369e4ede
    ^^^junios-favorite
    b0517166ae2ad92f3b17638cbdee0f04b8170d99 refs/tags/nonsense
    ^4baff50551545e2b6825973ec37bcaf03edb95fe

This would be backwards-compatible with the current code (granted, one
would lose the favorite information if the file is rewritten with an
older version of the code).  But if we delete the lolcats tag textually,
we would cause the favorite annotation to be moved to a different tag
and thereby corrupt the data.

>> Is the code that
>>    I use to do this, in peel_entry(), safe to call for nonexistent
>>    SHA1s (I would like it to return 0 if the SHA1 is invalid)?:
>>
>> 	o = parse_object(entry->u.value.sha1);
>> 	if (o->type == OBJ_TAG) {
>> 		o = deref_tag(o, entry->name, 0);
>> 		if (o) {
>> 			hashcpy(entry->u.value.peeled, o->sha1);
>> 			entry->flag |= REF_KNOWS_PEELED;
>> 			return 1;
>> 		}
>> 	}
>> 	return 0;
> 
> I think this approach is safe, as parse_object will silently return NULL
> for a missing object. You do need to check for "o != NULL" in your
> conditional, though.

Thanks; will fix.

>> 3. This same change to repack_with_ref() means that it could become
>>    significantly slower to delete a packed ref if the packed-ref file
>>    is not fully-peeled.  On the plus side, once this is done once, the
>>    packed-refs files will be rewritten in fully-peeled form.  But if
>>    two versions of Git are being used in a repository, this cost could
>>    be incurred repeatedly.  Does anybody object?
> 
> I think it's OK in concept. But I still am wondering if it would be
> simpler still to just pass the file through while locked.

See above.

>> 4. Should I change the locking policy as discussed in this thread?:
>>
>>        http://article.gmane.org/gmane.comp.version-control.git/212131
> 
> I think it's overall a sane direction. It does increase lock contention
> slightly when two processes are deleting at the same time, but it would
> fix the weird corner cases I described (mostly deleted refs reappearing
> due to races). And the lock contention is already there in a
> fully-packed repo anyway. I.e., right now we read the packed-refs file
> and lock it if our to-delete ref is in there; with the proposed change,
> we would lock before even reading it. So the increased contention is
> only when two deleters race each other, _and_ one of them is not
> deleting a packed ref.

OK, I'll work on that too.

Thanks for your feedback!
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
