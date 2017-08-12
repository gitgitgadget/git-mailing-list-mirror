Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6AB01F667
	for <e@80x24.org>; Sat, 12 Aug 2017 09:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750814AbdHLJX3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Aug 2017 05:23:29 -0400
Received: from e1i188.smtp2go.com ([103.36.108.188]:59247 "EHLO
        e1i188.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbdHLJX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Aug 2017 05:23:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=smtphost.com; s=m1fbw0.a1-4.dyn; h=Feedback-ID:X-Smtpcorp-Track:Date:
        Subject:To:From:Reply-To:Message-ID:Sender:List-Unsubscribe;
        bh=/Gulncs3NHJoLmzK5uWCtQMPad3zlscCcAz77Bnt/1o=; b=q1TuPPnwGq+Gkxksd3nXOS5lyZ
        lB0GQw52p++yoc4IRses2NQqOWc413WH7r3PPuu0MNQWux0MQpxf7rCFN7yOsFBMDPIySDSIWxPaz
        6tqYLeIcRP18wVN/d7MEmpNdhEeDfy1Uo9nHWSdVRwHvRYj9G+duUewDAtZfJZTwPN+6JdVRhDNBb
        QrJzJXmzXcMLQM/IrVSGt2mMICnLTX/MFQx3HLQKk6ZZZ/3shy09su7Lz7gwelJ/i8Iyq+qaQ3RJN
        HrDPN15hlvy9eX4PaysJjwHwpuoOc8W5g9+63rys6GtL+W9FXx+Dv5hy7RoMtXBEMqd6JrPHNlz+/
        qk8KP/kQ==;
Message-ID: <F3E6E31F66C645D8B86BCB8B6E639BC3@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "ankostis" <ankostis@gmail.com>,
        "Git Mailing List" <git@vger.kernel.org>
References: <CA+dhYEXDsgnmKTf9OW+_QTPkcVkfm99ffWOYdum7uUTnvaaCeA@mail.gmail.com>
Subject: Re: Would it make sense to add `--depth=0` feature?
Date:   Sat, 12 Aug 2017 10:23:23 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Smtpcorp-Track: 1dgSdfr_ZjMhGU.MIkJcdLTj
Feedback-ID: 66524m:66524aMf6O2Y:66524sFW9noHuNp:SMTPCORP
X-Report-Abuse: Please forward a copy of this message, including all
 headers, to <abuse-contact@smtp2go.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "ankostis" <ankostis@gmail.com>
> Would it be feasible/sensical to support clone/fetch with --depth=0?
> The point is to download the tags/commit objects but not the actual
> trees and blobs,
> creating a "ledger" acting as a promise for the remote'e repo content?
>
> Is there some estimation of the effort required to do such thing?
>
> Best,
>  Kostis

I think that the desire is reasonable, but that it doesn't match the shallow 
clone idea. I think you are asking for a 'Narrow' clone where there is some 
form of exclusion of the blobs and trees that attach to the commit objects 
(at the various depths of commit graph walking).

There is some work on-going at the moment for various types of sparse 
download (look for "lazy objects" and "partial clone" on the list archive 
https://public-inbox.org/git/?q=) to see if you can help with ensuring that 
the methods will be useful to you.
(I'm interested too!)
--
Philip 

