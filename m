Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 210092018E
	for <e@80x24.org>; Mon,  8 Aug 2016 17:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200AbcHHRmi (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 13:42:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59621 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752128AbcHHRmh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 13:42:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4EF8F3383D;
	Mon,  8 Aug 2016 13:42:36 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ekxqVg53+NHgoAD7KvT7GE4O8oY=; b=kZbIJV
	D63WjilZYLqPV/0yPPLiz/eLVe3w4oh7OfSmxJfRxerFYHG1+fgGTkIH4RNMDUIo
	NRNEcaG7wkIJxASXFteLrCe4g3FKL5RNk90dud0Z2MjEg2nycfWcbQZ5H56c7xTb
	rOIpleBDHWmEDDCdHp1FLIZJa3UngI26lYh9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ki6vwGZlxOzH1gcVMYZ8t91+VUxPDNFD
	eOpuj6FnV1KsgrJFKeKEvA+sIy5fPhGB+qDZnRReF5QkwLEwtCPgyjwcTzLfCXFv
	FsTrBrN9iecvNXpSzRgQbdp/f9MFMYK7WJUs9Zk4fFGI49a/N0bIefNurK9pxodN
	mxw/uO8S138=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 43E373383C;
	Mon,  8 Aug 2016 13:42:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C03853383B;
	Mon,  8 Aug 2016 13:42:35 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	"Michael S. Tsirkin" <mst@redhat.com>,
	Martin Fick <mfick@codeaurora.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Git List <git@vger.kernel.org>, repo-discuss@googlegroups.com
Subject: Re: storing cover letter of a patch series?
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
	<xmqqh9n241el.fsf@gitster.mtv.corp.google.com>
	<18979417.pyyHNUINeQ@mfick1-lnx>
	<xmqqzj0u2k5m.fsf@gitster.mtv.corp.google.com>
	<20160804234920.GA27250@redhat.com>
	<xmqqy44bxm0h.fsf@gitster.mtv.corp.google.com>
	<20160807080857-mutt-send-email-mst@kernel.org>
	<CACsJy8DhDMkmq-WCVHSMYVTTfEXNFUUzz5Cq9hQj_tGRUTj3ZA@mail.gmail.com>
Date:	Mon, 08 Aug 2016 10:42:33 -0700
In-Reply-To: <CACsJy8DhDMkmq-WCVHSMYVTTfEXNFUUzz5Cq9hQj_tGRUTj3ZA@mail.gmail.com>
	(Duy Nguyen's message of "Sun, 7 Aug 2016 12:42:06 +0200")
Message-ID: <xmqqmvknf986.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E18AAB2-5D8F-11E6-8F79-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> git-notes was mentioned in this thread back in 2015, but I think it's
> discarded because of the argument that's part of the cover letter was
> not meant to be kept permanently.

I do not think the reason why we didn't think the notes mechanism
was a good match was mainly because the cover letter material was
about a branch as a whole, which does not have a good counter-part
in Git at the conceptual level.  "A branch is just a moving pointer
that points at one commit that happens to be at the tip" is not a
perfect match to "I am holding these N patches to achieve X and I am
constantly adding, rewinding and rebuilding".  The notes mechanism
gives an easy way to describe the former (i.e. annotate one commit,
and let various commands to move that notes as you rewind and
rebuild) but not the latter (i.e. "branch.description" configuration
is the best match, but that is just a check-box feature and does not
make any serious attempt to be part of a version-control system).

> But I think we can still use it as a
> local/temporary place for cover letter instead of the empty commit at
> the topic's tip. It is a mark of the beginning of commit, it does not
> require rewriting history when you update the cover letter, and
> git-merge can be taught to pick it up when you're ready to set it in
> stone.

That depends on what you exactly mean by "the beginning of".  Do you
mean the first commit that is on the topic?  Then that still requires
you to move it around when the topic is rebuilt.  If you mean the
commit on the mainline the topic forks from, then of course that
would not work, as you can fork multiple topics at the same commit.


