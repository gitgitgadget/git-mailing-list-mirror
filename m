From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Thu, 03 Nov 2011 11:29:28 -0700
Message-ID: <7vzkgdf493.fsf@alter.siamese.dyndns.org>
References: <20111026202235.GA20928@havoc.gtf.org>
 <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike>
 <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org>
 <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <7vwrbjlj5r.fsf@alter.siamese.dyndns.org>
 <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
 <7vk47jld5s.fsf@alter.siamese.dyndns.org>
 <CA+55aFz7TeQQH3D4Tpp31cZYZoQKeK37jouo+2Kh61Wa07knfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ted Ts'o <tytso@mit.edu>, git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Thu Nov 03 19:30:36 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RM23g-0002yV-3j
	for glk-linux-kernel-3@lo.gmane.org; Thu, 03 Nov 2011 19:30:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934380Ab1KCSa1 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 3 Nov 2011 14:30:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35533 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933797Ab1KCSaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2011 14:30:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB463584D;
	Thu,  3 Nov 2011 14:30:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=Gu8dUoog8rbdZPIy1pIKvhd2dkU=; b=O0VxAmGUe0X9l15O5dGv
	nqoW3l65Xbzgpr2D3KrHZmJecxHtiOvoLIPIkTI9ACva7+eI33zip0e0Mumr0Pbt
	bo0K8s1c87FtiXH9kcCwoxwjrQRMAhwxmtROHnfPzcQ31otXc/h2hPR8sLWaIOwt
	0nofcsLC8U6o7iS7WPkIpxc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=KN3Nmga1CiMkxHC7A7RRBe6OGqyQYmyEgeDl/81Leyo9fv
	cVRBKemNeVH+gOUOHn+EC0u3mK4TCsyrMjwLK92i6RV9ZG5p0hQbj7qPEP3QbCIj
	2gBtJ89d/9JDJ9d1wHViLByA9M+CZJJfPqibefST09Zl/g6MAaC3l6pYKCO+k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B19B4584A;
	Thu,  3 Nov 2011 14:30:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21FB45837; Thu,  3 Nov 2011
 14:30:18 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E167526E-0649-11E1-859F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184733>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, Nov 1, 2011 at 2:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> But on the other hand, in many ways, publishing your commit to the outside
>> world, not necessarily for getting pulled into the final destination
>> (i.e. your tree) but merely for other people to try it out, is the point
>> of no return (aka "don't rewind or rebase once you publish"). "pushing
>> out" might be less special than "please pull", but it still is special.
>
> So I really think that signing the top commit itself is fundamentally wrong.

It merely is a stronger form of the "committer" line in the commit
object. A random repository at Github anybody can create repositories at
can serve you a random commit with any random name on "committer" line,
and the new gpgsig header is a way to let the committer certify it
genuinely is from the committer.

I do not think for that purpose, in-commit signature is fundamentally
wrong. I was hoping it would be more useful than it turned out to be, but
I agree that it just is not suitable as a vehicle to convey "I made that
commit some time ago, and now I want you to pull it for such and such
reasons" in a larger workflow.

The "now I want you to pull it for such and such reasons" part is the pull
request, and if we are to protect them with GPG signatures, and perhaps
copy the signed part in the resulting merge, don't we have a reasonable
solution, without all the downsides the signed tag approach would cause if
we wanted to allow third party auditors to have access to the signatures
for independent auditing purposes (described in a separate message)?

Perhaps what is causing the problem is the desire to allow third party
auditors finer grained audit trail, but after having heard that $DAYJOB
folks went through each and every commit after known release points with
fine-toothed comb, I am not brave/rude/blunt enough to dismiss it as
unimportant.
