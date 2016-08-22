Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F4681F859
	for <e@80x24.org>; Mon, 22 Aug 2016 18:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755839AbcHVSGM (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 14:06:12 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51097 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755412AbcHVSGK (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Aug 2016 14:06:10 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A941D20763;
        Mon, 22 Aug 2016 14:06:08 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Mon, 22 Aug 2016 14:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=ZZoHSl84smKWr32
        RwBMYoFaWumM=; b=S0Ay666hZCGtkBzkoUrbFlWz2+NYOtclV6dULNHl4cOTPhO
        Jo78nksjzqob/pU+D4fvM1s/+frbHQejuEnry3eNsg0Qmu0fTej0M1GO3M/jvOfi
        Aq4aNMvtSvRN6LrvX3ULMNQxY69aRV/cAF5l7gvkRNrSWfyNBBeed5/xmQOg=
X-Sasl-enc: mxMuVFOjZrFSZ/nsiyoF/9ODz9hDiGwNmtNCdA0Pm4wq 1471889168
Received: from ebox.rath.org (ebox.rath.org [45.79.69.51])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5BAFECC021;
        Mon, 22 Aug 2016 14:06:08 -0400 (EDT)
Received: from thinkpad.rath.org (thinkpad [192.168.12.2])
        by ebox.rath.org (Postfix) with ESMTPS id 98BC2396C84;
        Mon, 22 Aug 2016 18:06:07 +0000 (UTC)
Received: by thinkpad.rath.org (Postfix, from userid 1000)
        id 49A8FBFFD8; Mon, 22 Aug 2016 11:06:07 -0700 (PDT)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: Most recent revision that contains a string
References: <87d1l3ce40.fsf@thinkpad.rath.org> <20160821024647.GA19536@starla>
Mail-Copies-To: never
Mail-Followup-To: Eric Wong <e@80x24.org>, git@vger.kernel.org
Date:   Mon, 22 Aug 2016 11:06:07 -0700
In-Reply-To: <20160821024647.GA19536@starla> (Eric Wong's message of "Sun, 21
        Aug 2016 02:46:47 +0000")
Message-ID: <871t1ghe5s.fsf@thinkpad.rath.org>
User-Agent: Gnus/5.130014 (Ma Gnus v0.14) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Aug 21 2016, Eric Wong <e@80x24.org> wrote:
> Nikolaus Rath <Nikolaus@rath.org> wrote:
>> What's the easiest way to find the most recent revision (of any file in
>> the repository, including those that have been deleted in the current
>> HEAD) that contains a given string?
>
> I normally do something like:
>
> 	git log -r --raw -p -SSTRING
> 	git log -r --raw -p -GREGEXP
>
> You can also add --diff-filter=3DD to filter only on deletes.

Great, thanks!

> Btw, please don't set these headers on kernel.org lists:
>
> 	Mail-Copies-To: never
> 	Mail-Followup-To: git@vger.kernel.org
>
> Like any mail server, vger fails from time-to-time and
> reply-to-all prevents it from being a single point of failure.

Huh? If the list-server fails only I will receive the message so it's
still lost for everyone else. But I am more than happy to take this
little risk if it saves me from the nuisance of getting duplicate
responses.

Best,
-Nikolaus

--=20
GPG encrypted emails preferred. Key id: 0xD113FCAC3C4E599F
Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
