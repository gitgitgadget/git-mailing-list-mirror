Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8D051FD99
	for <e@80x24.org>; Tue,  9 Aug 2016 07:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbcHIHXD (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 03:23:03 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:42638 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750810AbcHIHXC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Aug 2016 03:23:02 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id C2C3020711;
	Tue,  9 Aug 2016 03:12:56 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 09 Aug 2016 03:12:56 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=7tf1p4uT52GOxOTqpi+Et4aQYgM=; b=faObwx
	nuuRDw23qY1k3GDms+wd2rFWIcCcPTdiqaSwxyveBoFpKWA/ihFhbbijWq4INQCE
	jQByy+QwZZWFrWfGBY+KMtk/aOhRgxk8/sj5vy+4nwcsphlIpGV36ZCBFAp+k65I
	GsgOuSn2CQ4EQb5l4pqNNKxqEj5gl97BZpV0A=
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=7tf1p4uT52GOxOT
	qpi+Et4aQYgM=; b=GW2Lz4TQ1syc5w7cDDTzgT90MzAVJ9yiga5aE+GLKlvSdzS
	BvRz2bTVuXi3YLmVeYsxdrDDcm+3U8p6LxbkVcdC0zwAiWUkq0W6QZvM2FL94OXD
	YDXFyuFXSUQuBi/fP+dufWWlb5HKgNBtmaMcFE+aIcwWEWfQ6qFNj9ly6r40=
X-Sasl-enc: X/M2QLJaZQbvAFV69nD9Rv5i+9J4oin/ZyaYfRCEK7W1 1470726776
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id B3750F296E;
	Tue,  9 Aug 2016 03:12:55 -0400 (EDT)
Subject: Re: storing cover letter of a patch series?
To:	Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
 <xmqqh9n241el.fsf@gitster.mtv.corp.google.com>
 <18979417.pyyHNUINeQ@mfick1-lnx>
 <xmqqzj0u2k5m.fsf@gitster.mtv.corp.google.com>
 <20160804234920.GA27250@redhat.com>
 <xmqqy44bxm0h.fsf@gitster.mtv.corp.google.com>
 <20160807080857-mutt-send-email-mst@kernel.org>
 <CACsJy8DhDMkmq-WCVHSMYVTTfEXNFUUzz5Cq9hQj_tGRUTj3ZA@mail.gmail.com>
 <xmqqmvknf986.fsf@gitster.mtv.corp.google.com>
Cc:	"Michael S. Tsirkin" <mst@redhat.com>,
	Martin Fick <mfick@codeaurora.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Git List <git@vger.kernel.org>, repo-discuss@googlegroups.com,
	Git Mailing List <git@vger.kernel.org>
From:	Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <70b74f2e-3870-4bef-1664-1c2dd05eda96@drmicha.warpmail.net>
Date:	Tue, 9 Aug 2016 09:12:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqmvknf986.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano venit, vidit, dixit 08.08.2016 19:42:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
>> git-notes was mentioned in this thread back in 2015, but I think it's
>> discarded because of the argument that's part of the cover letter was
>> not meant to be kept permanently.
> 
> I do not think the reason why we didn't think the notes mechanism
> was a good match was mainly because the cover letter material was
> about a branch as a whole, which does not have a good counter-part
> in Git at the conceptual level.  "A branch is just a moving pointer
> that points at one commit that happens to be at the tip" is not a
> perfect match to "I am holding these N patches to achieve X and I am
> constantly adding, rewinding and rebuilding".  The notes mechanism
> gives an easy way to describe the former (i.e. annotate one commit,
> and let various commands to move that notes as you rewind and
> rebuild) but not the latter (i.e. "branch.description" configuration
> is the best match, but that is just a check-box feature and does not
> make any serious attempt to be part of a version-control system).
> 
>> But I think we can still use it as a
>> local/temporary place for cover letter instead of the empty commit at
>> the topic's tip. It is a mark of the beginning of commit, it does not
>> require rewriting history when you update the cover letter, and
>> git-merge can be taught to pick it up when you're ready to set it in
>> stone.
> 
> That depends on what you exactly mean by "the beginning of".  Do you
> mean the first commit that is on the topic?  Then that still requires
> you to move it around when the topic is rebuilt.  If you mean the
> commit on the mainline the topic forks from, then of course that
> would not work, as you can fork multiple topics at the same commit.

Well, my idea back then was: attach notes to refs rather than commits,
in this case to the branch ref. That would solve both the "branch moves"
as well as the "cover letter refers to the whole branch/topic" issues.

In fact, I had an implementation that I had been rebasing and using for
quite some time, but it never became popular, and branch.description
landed in-tree. [short version: notes attached to (virtual) refname
objects (virtual blobs - not stored, but "existing" for (fsck, notes
prune and the like)]

The notes based approach suffered from the old notes deficiency: we
don't have good simple tooling for sharing notes; really, we don't have
good tooling for dealing with any remote refs besides branches (read:
ref namespace reorg project is stalled), unless you set up specific
refspecs.


OTOH, branch.description is inherently local, too, and can't even be
transported after setting up refspecs or such.

Also, notes trees have a history, so you would gain a log on your cover
letter edits; again, our tooling around that notes feature is
sub-optimal, that is: the feature is there, the ui could improve.

Michael

