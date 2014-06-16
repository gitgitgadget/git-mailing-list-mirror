From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/4] commit: Add commit.verbose configuration
Date: Mon, 16 Jun 2014 13:28:19 -0700
Message-ID: <xmqqsin4ppjw.fsf@gitster.dls.corp.google.com>
References: <1402601942-45553-1-git-send-email-caleb@calebthompson.io>
	<20140612203010.GA17761@hudson.localdomain>
	<20140613164910.GA87252@sirius.local>
	<20140614041452.GA1375@hudson.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Caleb Thompson <caleb@calebthompson.io>, git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 22:28:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwdW7-00040q-Qk
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 22:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755685AbaFPU21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 16:28:27 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50941 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755298AbaFPU20 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 16:28:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4A0FE205E6;
	Mon, 16 Jun 2014 16:28:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tUqprRAxAMMmKYbInJuSWJUi/vY=; b=VHkFay
	gEJ0kXK3uoPGnJjgpTwR72dR+El/+Jkpp4E/ae7obptfLBo9dXg4RlHwEuKJo8iu
	EcQMihyIpQxwjdAN5ApU8PM9VuoaB7hc7iM6/CF6/zSHVYaykQLUvU57GS8hyLjh
	Biu5CwZOCiqCDVM+2Q9eNZS281Uw2eDYmbtSg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Uun3u68yqFDKlZ6EFEJi3j+u+P4i79a2
	DqdDOHQzK3GWKohvYRefAjrr8GwdLJGSkJnk/u2PSRT3hEWhBYj4fEqZX820C9uf
	59SQhfyhelgTpHOSUpGXyXODrR30gB1fv/rlIFApIAE+HpYXO1Pp+ZBIQcsg4+aW
	0t3E6N15Piw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3DC0D205E5;
	Mon, 16 Jun 2014 16:28:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0C77E205E0;
	Mon, 16 Jun 2014 16:28:18 -0400 (EDT)
In-Reply-To: <20140614041452.GA1375@hudson.localdomain> (Jeremiah Mahler's
	message of "Fri, 13 Jun 2014 21:14:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C0D861AE-F594-11E3-B7B9-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251820>

Jeremiah Mahler <jmmahler@gmail.com> writes:

> On Fri, Jun 13, 2014 at 11:49:10AM -0500, Caleb Thompson wrote:
> ...
>> > The patches look good, they apply clean ('git am'), and all tests pass.
>> >
>> > Reviewed-by: Jeremiah Mahler <jmmahler@gmail.com>
>> 
>> So that I'm clear on the etiquitte, is it appropriate for me to add this
>> Reviewed-by line to the commit messages at this point, provided that the
>> patches don't change?
>
> I am not sure of the etiquette either.  But personally, since I hardly
> contributed anything, I don't think it is necessary to put my tag in
> your patches.

It is correct that it is not necessary for Caleb to resend these
patches if it is done only to add "Reviewed-by:" from you (but it
does not hurt to do so, either).

In the review process, "Reviewed-by:" sent for a patch by one of the
trusted reviewers will reduce workload from other reviewers because
there will be one less reason to read such a patch [*1*].  A
corollary to this is that other reviewers will ignore an extra
"Reviewed-by:" by somebody whose review quality is still unknown, so
it will not hurt.

Your reading others patches and commenting on is appreciated very
much, and sending a "Reviewed-by:" is perfectly fine.  As you gain
experience and as others see your review comments more and more,
people will start trusting your reviews.  Everybody begins at a
"novice" state, after all ;-)

By the way, speaking of netiquette, please refrain from using
"Mail-Followup-To:" while working on this list [*2*].

Thanks.

[Footnotes]

*1* We usually read a patch for one of the two reasons: either the
reviewer personally finds what the patch wants to do interesting and
worthwhile, and wants to make sure it is done in the right way.  Or
the reviewer thinks that applying the patch is detrimental to the
overall project, perhaps the design and/or the implementation is
wrong, and point the problems out.  A "Reviewed-by" from a trusted
reviewer will allow other reviewers to simply skip/ignore the patch
if what it does is "Meh" to them, saying "I am not particularly
interested, but as long as it does not hurt, I would not be opposed,
and the other guy reviewed and says it would not hurt, and I tend to
trust his judgment."  The maintainer does not have the luxury of
skip/ignore such a patch because he needs to at least apply and test
the integration result, though ;-).

Now, who are the "trusted reviewers"?  Anybody who is knows s/he is
one of them ;-)

*2* http://thread.gmane.org/gmane.comp.version-control.git/165477/focus=165549
