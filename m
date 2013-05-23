From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] Add new git-related helper to contrib
Date: Thu, 23 May 2013 15:44:16 -0700
Message-ID: <7vhahtco5b.fsf@alter.siamese.dyndns.org>
References: <1368978823-18247-1-git-send-email-felipe.contreras@gmail.com>
	<7vr4gyizti.fsf@alter.siamese.dyndns.org>
	<CAMP44s0pXLmjVUwsVWiN2G5QReh80spXjvy_6GuUGRz1RmUbLQ@mail.gmail.com>
	<7vd2siiqsr.fsf@alter.siamese.dyndns.org>
	<CAMP44s2ETSxebGxXJV_BYEqTC5gJMVdQLbnTUomrie2rHhdmDg@mail.gmail.com>
	<7v8v36iq3e.fsf@alter.siamese.dyndns.org>
	<7v4nduipvb.fsf@alter.siamese.dyndns.org>
	<7vzjvmh98r.fsf@alter.siamese.dyndns.org>
	<CAMP44s1_=HSgZA=abHJ3sgDbUyfkF78qO+sR1+Aact3o7bAgLA@mail.gmail.com>
	<7vvc6ah81g.fsf@alter.siamese.dyndns.org>
	<CAMP44s37a0_wVVef+QVnLNvc8Uos_XpCZAtpX0RmQyMcuJHUHw@mail.gmail.com>
	<CAMP44s18ps9JtY7+mvXVbuZu3cm7bHnK1vCzMWqBdvawLr+zzA@mail.gmail.com>
	<7v8v35hc11.fsf@alter.siamese.dyndns.org>
	<CAMP44s0X-79Pn4gq_rqBbti-xUobyYDc8Gy-3-g=sq8siZqq8g@mail.gmail.com>
	<7vppwhcqjq.fsf@alter.siamese.dyndns.org>
	<CAMP44s3LcEkTghg-cBRux7sA54L-U93w5Znqa1jz2MnUWj8Rhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 24 00:44:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfeFE-0007Ju-Da
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 00:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759810Ab3EWWoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 18:44:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49988 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759752Ab3EWWoT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 18:44:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC63C2289B;
	Thu, 23 May 2013 22:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uqWoMnVlm9sEu6T7y4bvUrOW6rU=; b=gdtbNC
	Y8BkoYigR/HT0y+IOxAIj2OQrFCgMmJdaOaHeKaH7Bp6ctNQ+uBRh4ksAA86AEkU
	vA1iX7hnD5FYpdvOjWNtw6ZPMUzN1N9ziVkhr057Kt3B5Ct62UFij0SVp2cAU5Eo
	Zu/yVJeyFYVqNBX01S1vtHNk7xbjGnP3waVRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QuE7vyEkeKgay626tr5kkUoaq1uqv/EU
	D56AJ3vx2XC3SLpH6hLtetjzzHq1hfGDCORflY4K2bGhXh1lvGDObG09X6IPjFHH
	tPbn7woAgf+76jNjSm+P3lAB7y5wPqJQo+MIFCL6CKpUq/R15Kxa/V4hRAG4EqJM
	Rr8ef8xMrUU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D34D62289A;
	Thu, 23 May 2013 22:44:18 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2792022898;
	Thu, 23 May 2013 22:44:18 +0000 (UTC)
In-Reply-To: <CAMP44s3LcEkTghg-cBRux7sA54L-U93w5Znqa1jz2MnUWj8Rhw@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 23 May 2013 16:58:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4D5D5BA2-C3FA-11E2-AF27-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225310>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> Then in that "next iteration", we pick blame entry for A and decide
>> to see if HEAD^, which is the suspect for A, can be exonerated of
>> blames for _any_ (not just A) blame entry it currently is suspected
>> for.  We call pass_blame() and it will find and process both A and
>> C with a single "git diff-tree", attempting to pass blame to HEAD^^
>> and its ancestors.
>
> All right, my code still works in that situation.

When HEAD^ was processed, pass_blame() finds that the first line in
A is attributable to HEAD^ (our current suspect) while the rest were
copied from a different file in HEAD^^ .  All lines in C are found
to be copy from a different file in HEAD^^.

Then your scoreboard would have:

  1. a blame entry that failed to pass blame to parents of HEAD^ (the
     first line in A), which still has suspect == HEAD^

  2. a blame entry that covers the remainder of A, blaming HEAD^^.

  3. a blame entry that covers all of B, whose final guilty party is
     known already.

  4. a blame entry that covers all of C, blaming a different file in
     HEAD^^.

Your "Take responsibility" loop goes over these blame entries, sets
found_guilty to true because of the first blame entry (the first
line of A), and calls print_guilty_entry() for blame entry 1,
showing that HEAD^ is guilty for the first line of A.

After the loop, your "if we did not find anybody guilty" logic does
not kick in, and the original line range for block A you saved in
tmp_ent is not used.

You lost the fact that the second and remainder of A were in this
file at the commit HEAD^ but not in HEAD^^ (i.e. these lines were
moved by HEAD^ from elsewhere).

The fact that HEAD^ touched _something_ is not lost, so if _all_ you
care about is "list all the commits, but I do not care about what
line range was modified how", you can claim it "working", but that
is a very limited definition of "working" and is not very reusable
or extensible in order to help those like gitk that currently have
to run two separate blames.  They need an output that lets them tell
between

 - this is the earliest we saw these lines in the path (it may have
   been copied from another path, but this entry in the incremental
   output stream is not about that final blame); and

 - this is the final blame where these lines came from, possibly
   from different path"

and coalesce both kind of origin..

Also the fact that the entire C was copied from elsewhere by HEAD^
is lost but that is the same issue.  The next round will not find
any blame entry that is !ent->guity because the call to pass_blame()
for HEAD^ already handled the final blame not just for blame entries
1 and 2, but also for 4 during this round.

If the change in HEAD^ in the above example were to copy the whole A
and C from a different file, then your !found_guilty logic would
kick in and say all lines of A where copied from elsewhere in HEAD^,
but again we would not learn the same information for C.

I do not think "I care only about a single bit per commit, i.e. if
the commit touched the path; screw everybody else who wants to
actually know where each line came from" can be called "working".
