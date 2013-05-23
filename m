From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] Add new git-related helper to contrib
Date: Thu, 23 May 2013 14:52:25 -0700
Message-ID: <7vppwhcqjq.fsf@alter.siamese.dyndns.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 23 23:52:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfdR5-0001Os-8j
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 23:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759632Ab3EWVwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 17:52:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57605 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759458Ab3EWVwa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 17:52:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15E2D216EC;
	Thu, 23 May 2013 21:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u6I4kNvrMQn63pAtb+GMzjoCpSk=; b=eEQGK1
	za4caQp4MA4EaDHN/nbSJzmtsBfMdMCHwK1a1ukUTLfXK3lCp6v6xCSKUOl3M0Vd
	WmswBUu7UprZLSimIYklvdBD4x3c/r+WNnx/i53wfea2aAYBVstJTuGbFLmP0eBB
	DWF4AThwtYvjfT4mPVI9DOLeDR3jYZwJR6C4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dCU1BSDAh5faxAiBrzJ6av5jPfD7XIw7
	GIMfPickPrZ0ed3Oe03pntXQCv0Y2msXxKtFsTWb4ZHj1zlIvcl6prtie25PoNVo
	c5gWtc4VElwqf+FCtofuMe874NX4dKM3qLRLHBeFcV80TjTpZgY3Ufdkm5JML0nA
	x/HiZ9ON8b4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A8BE216EB;
	Thu, 23 May 2013 21:52:28 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 66F9B216E9;
	Thu, 23 May 2013 21:52:27 +0000 (UTC)
In-Reply-To: <CAMP44s0X-79Pn4gq_rqBbti-xUobyYDc8Gy-3-g=sq8siZqq8g@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 23 May 2013 16:33:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F381CEC-C3F3-11E2-898A-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225304>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> Imagine that your scoreboard originally has three blocks of text
>> (i.e. blame_entry) A, B, and C, and the current suspect for A and C
>> are the same, while we already know what the final guilty party for
>> B is (which may be some descendant of the "suspect").
>
> I don't see how that's possible, but whatever.

The tree in your latest commit HEAD has a file with block of text A
followed by block of text B followed by block of text C.  The latest
commit was the one that added B (perhaps new lines were inserted, or
perhaps existing contiguous block of text was replaced, there is no
difference between these two cases).  You start digging the history
of this file from HEAD.

Your scoreboard begins with a single blame-entry that covers all
three segments, with its suspect set to HEAD.  Then pass_blame()
discovers that top and bottom segments are older than this latest
commit, and splits the originally-one blame entry into three blame
entries.  The first and the third blame entries cover the block A
and the block C respectively, and their suspect fields are both set
to HEAD^.  The second blame entry covers the block B and its suspect
does not change (it still is HEAD).  Then it returns to the caller.

The caller of pass_blame() looks at the scoreboard and finds these
three blame entries.  The second one's supect is still the original
suspect the caller asked pass_blame() to exonerate blames for, and
the suspect failed to do so for block B.  The final blame for the
middle block is now known to be HEAD.

After all of the above, the next iteration of while(1) loop begins.
That is how you arrive to the "whatever" situation.  You have three
blame entries, A, B and C, and suspect of A and C are the same,
while B has a different suspect.

Then in that "next iteration", we pick blame entry for A and decide
to see if HEAD^, which is the suspect for A, can be exonerated of
blames for _any_ (not just A) blame entry it currently is suspected
for.  We call pass_blame() and it will find and process both A and
C with a single "git diff-tree", attempting to pass blame to HEAD^^
and its ancestors.
