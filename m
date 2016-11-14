Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C0F71F858
	for <e@80x24.org>; Mon, 14 Nov 2016 20:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938620AbcKNUXM (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 15:23:12 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55535 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932462AbcKNUXL (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 14 Nov 2016 15:23:11 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 79F3720861;
        Mon, 14 Nov 2016 15:23:10 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 14 Nov 2016 15:23:10 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=QMoR5GVWdmalQv7
        Sr0eptgRs/+c=; b=N0V+sIQqPRZPbAKYG9ubmu1k+4S5CA+J1PD7L88JwjaXYDe
        Qvh23TR8pyTsOR/+T3WDqneJouPOiFBHDRvCygUzDJP+m2r+rz2sJOEKDgw+ttrD
        iOjE/ESyzKMb0c/S/YvDdLKNCZGgoZCaWZzZtmnjsO5Oa6uv2MvOeNFsqUW4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        smtpout; bh=QMoR5GVWdmalQv7Sr0eptgRs/+c=; b=rClKtv4fgz5kEvbETEyg
        dOXyiy4CpFkwvz5D9P9cor29Pbi5RetmUKg/gMBoKGErVBMIuD4Nt62sVIknJ63J
        3OMAbulhUukW3D9fxBnvkWlh8kYF14Q9V6/t4lapw+Q4+Ol2Fq49XH4CnHlS7s1k
        Zwt4DA4z+Gb++9PsfMJuRQg=
X-ME-Sender: <xms:Lh0qWMbII84JpOBBOx_WfYzqDBBzbKrB28dyFYk9DfGQeg_r5cWvIA>
X-Sasl-enc: jBmkx05rSh2gkHQSRxYcb8IhoRMjWCG7sn8kqBNmvdDa 1479154990
Received: from linux.fritz.box (dslb-178-011-219-217.178.011.pools.vodafone-ip.de [178.11.219.217])
        by mail.messagingengine.com (Postfix) with ESMTPA id 503FF24434;
        Mon, 14 Nov 2016 15:23:09 -0500 (EST)
Subject: Re: [RFC/PATCH 0/2] git diff <(command1) <(command2)
To:     Junio C Hamano <gitster@pobox.com>
References: <20161111201958.2175-1-dennis@kaarsemaker.net>
 <xmqqinrt1zcx.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xrFYj7sepdz1xrEEaqmXQWfRkBz3CsWjYK6OZsZRMLbUA@mail.gmail.com>
 <alpine.DEB.2.20.1611121106110.3746@virtualbox>
 <0c39be16-76f8-0800-41a2-b7b1dccdd652@drmicha.warpmail.net>
 <xmqqoa1ix7nq.fsf@gitster.mtv.corp.google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jacob Keller <jacob.keller@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Git mailing list <git@vger.kernel.org>
From:   Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <a3db4c55-550c-f2e8-83b8-46c2be86f7da@drmicha.warpmail.net>
Date:   Mon, 14 Nov 2016 21:23:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqoa1ix7nq.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano venit, vidit, dixit 14.11.2016 19:01:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> *My* idea of --no-index was for it to behave as similar to the
>> --index-version as possible, regarding formatting etc., and to be a good
>> substitute for ordinary diff. The proposed patch achieves exactly that -
> 
> Does it?  It looks to me that it does a lot more.

Yes, I didn't mean to say that it achieves only that - it achieves that
one goal exactly, and more.

>> why should a *file* argument (which is not a pathspec in --no-index
>> mode) not be treated in the same way in which every other command treats
>> a file argument? The patch un-breaks the most natural expectation.
> 
> I think a filename given as a command line argument, e.g. <(cmd), is
> now treated more sensibly with [2/2].  Something that is not a
> directory to be descended into and is not a regular file needs to be
> made into a form that we can use as a blob, and reading it into an
> in-core buffer is a workable way to do so.  

Yes.

> However, when taken together with [1/2], doesn't the proposed patch
> "achieves" a lot more than "exactly that", namely, by not treating
> symbolic links discovered during traversals of directories given
> from the command line as such and dereferencing?

It's not clear to me what you are saying here - 1/2 makes git diff
follow symbolic links, yes, just like ordinary diff. If I 'diff' two
dirs that contain symbolic links with the same name pointing to
different files I get a diff between the contents, not between the
filenames.

I like the proposed change a lot, maybe that didn't come across clearly.
I think it makes things more "predictable" in the sense that it meets
typical expectations.

Michael

