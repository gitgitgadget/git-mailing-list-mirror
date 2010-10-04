From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: allow the mergeinfo property to be set
Date: Mon, 04 Oct 2010 10:38:02 -0700
Message-ID: <7vhbh197ut.fsf@alter.siamese.dyndns.org>
References: <20100924162704.GA4513@dcvr.yhbt.net>
 <1285386710-27905-1-git-send-email-stevenrwalter@gmail.com>
 <20100925042457.GA28899@dcvr.yhbt.net> <4CA9889E.1020604@debugon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Steven Walter <stevenrwalter@gmail.com>
To: Mathias Lafeldt <misfire@debugon.org>
X-From: git-owner@vger.kernel.org Mon Oct 04 19:38:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2ozV-0004kL-Mv
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 19:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755867Ab0JDRiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 13:38:16 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49654 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752962Ab0JDRiP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 13:38:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C1387DBC5C;
	Mon,  4 Oct 2010 13:38:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d4VuujvDteuQd77+VBViR6a1IKQ=; b=GsHQgp
	2BGGEk5YQMEiK0ZTruLZJV72gz3MNmQFHxe/ISRuwmDpBzN6cZjyYXMnAmuBsMNn
	aL70GNC3iQvHL8yScsqOab90dTYlZk4WWfjrWS5Ee5W3i8S2iUijMLKfpnk6MJ7U
	MFGboaYrWy56y46V/WLLzn2nblhXKfPIhefDE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tK62AKG/eK9vST8HCJoPx/KVpshHOC6A
	AecDG0BKwn0yNjJucmTJQf+8zU1Pm4LSsuyb342VdOu33v7EQSAVHo7fQVqrC0nv
	C+UFI2lie8ZYaZqvX7nz6FMIUxITwIbKsldktmRu5Aq9cBpRCMJPWzjYK07x4VSJ
	kr49gXtwqfw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 76DA2DBC55;
	Mon,  4 Oct 2010 13:38:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64AB4DBC51; Mon,  4 Oct
 2010 13:38:04 -0400 (EDT)
In-Reply-To: <4CA9889E.1020604@debugon.org> (Mathias Lafeldt's message of
 "Mon\, 04 Oct 2010 09\:56\:14 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 27F6D284-CFDE-11DF-96DB-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158071>

Mathias Lafeldt <misfire@debugon.org> writes:

>> I fixed a bashism and style issues in test case, but nonetheless acked
>> and pushed it out to git://git.bogomips.org/git-svn along with a few
>> others I had forgotten to tell Junio about while I was on vacation:
>> 
>> Eric Wong (1):
>>       Documentation/git-svn: discourage "noMetadata"
>> 
>> Mathias Lafeldt (1):
>>       git-svn: fix processing of decorated commit hashes
>> 
>> Steven Walter (2):
>>       git-svn: check_cherry_pick should exclude commits already in our history
>>       git-svn: allow the mergeinfo property to be set
>> 
>
> So, is Junio aware of those patches? Or is it better to resubmit my fix
> separately?

Now I am ;-)  Thanks for reminding me.

I found these four near Eric's 'master':

  833fde5 git-svn: allow the mergeinfo property to be set
  8565a56 git-svn: fix processing of decorated commit hashes
  a3c7505 git-svn: check_cherry_pick should exclude commits already in our history
  c9be27f Documentation/git-svn: discourage "noMetadata"

They all (perhaps except the very tip one) look fixes not enhancements, so
I'll merge it to 'maint', so it can appear in 'master' and also in 1.7.3.2
in due course.

If 833fde5 needs to be excluded from 'maint', please advise.
