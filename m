Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F5EC1F404
	for <e@80x24.org>; Tue, 13 Mar 2018 00:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751606AbeCMAB7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 20:01:59 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:32783 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbeCMAB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 20:01:58 -0400
Received: by mail-wr0-f196.google.com with SMTP id r8so2483186wrg.0
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 17:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6HNJ9Uv6fieoVYaOwmslGzjMMg14WQj0imBQRP04yzY=;
        b=rftWCg+evwMUQXyXA+J7Y4S8vvzDbB1uDypwX+v++0oE+E3vfUFiY1cUutDgvRygpt
         P6wcaO7p4zPLZZ1yg+f3ntKw3jEeTNaYFF0LF4KFHCmLDA3CBoLS24ckckc1sSBzZALk
         3Hp86g55PMjOruwiAHgQkZ2Oavr9iw1jLdv/pMw2AT+TMOUTv4VuBm+MXrC42pbnaZfQ
         VJC7IFYPf8BVxBgz8A++u+WpxJ7K9u6WLuhER0YDxDvvXJXS9K0KU7LUByHb79mMR5LM
         JaRT42TFkEDZyeIGtK7oRcz0uCkvJfFkd7WMKzgJMaG0KBeok41lVw6SYODolQwMHXX0
         5n+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6HNJ9Uv6fieoVYaOwmslGzjMMg14WQj0imBQRP04yzY=;
        b=dgUdYbFr/6vmTppb6tjPm4wwHoSbqyjMAOfjkqY3oliswOunpc3/G0EQyQpY7ATqWm
         ZRq2SrU2EW0HIbal6RfNo3HGb5OWXKpDkfcAML1S7HbxsNyroya8sxWAgC/RKYA41NQZ
         X7aCv2TzZQHOqljGf1fqasPhUZu+R5gkPhagFJAYoWrJZQQ8ZvU0xOPHE7lIPzsZAzMm
         TMwgx+YhhCF9F9XeyG7FDNCHThvMjx5Zpc3uThSLSMYJ74M7uxg1orzjN6utI12MSYKC
         lpMsMtXsLNa7MFF1eNvSXbO0rMTBsuOcmHxhWLpdBUVtzDoqNWc6u4FBnRxlq2/L3B4g
         iyJQ==
X-Gm-Message-State: AElRT7H7AtW3UvkM70L939SbaqDmdirGCQQl+YEqWpNT9k9puZ/PkpfN
        N83dWQze3KMMbUaP1azO0vE=
X-Google-Smtp-Source: AG47ELvDIv0fSKfR8zrPWswfvddT2m5Upp0SFChkemn26Cps0LTCbFApO49AUQOBG7vrWHgTRJSmhA==
X-Received: by 10.28.140.144 with SMTP id o138mr6619919wmd.138.1520899316691;
        Mon, 12 Mar 2018 17:01:56 -0700 (PDT)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id d8sm12679312wrf.8.2018.03.12.17.01.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Mar 2018 17:01:56 -0700 (PDT)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
To:     Sergey Organov <sorganov@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     phillip.wood@dunelm.org.uk, Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com>
 <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org>
 <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net>
 <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
 <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
 <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net>
 <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com>
 <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <c5a5c2cc-6a11-440f-5b9b-964ae1ca07dd@talktalk.net>
 <483674f8-4097-a374-c8f3-cf56cbb92042@talktalk.net>
 <29bc6661-1d78-8f89-194e-1dcc9d88c34e@gmail.com>
 <nycvar.QRO.7.76.6.1803111256410.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <f4e6237a-84dc-1aa8-150d-041806e2416e@gmail.com>
 <nycvar.QRO.7.76.6.1803121122390.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87h8plh2qd.fsf@javad.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <39327070-f13a-f7e5-6c8c-cd204530f051@gmail.com>
Date:   Tue, 13 Mar 2018 01:01:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87h8plh2qd.fsf@javad.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/03/2018 13:56, Sergey Organov wrote:
> 
> > > I agree with both of you that `pick <merge-commit>` is inflexible 
> > > (not to say just plain wrong), but I never thought about it like that.
> > >
> > > If we are to extract further mentioned explicit old:new merge 
> > > parameter mapping to a separate discussion point, what we`re 
> > > eventually left with is just replacing this:
> > >
> > > 	merge -R -C <original--merge-commit> <merge-head>
> > >
> > > ... with this:
> > >
> > > 	pick <original--merge-commit> <merge-head>
> >
> > I see where you are coming from.
> >
> > I also see where users will be coming from. Reading a todo list in the
> > editor is as much documentation as it is a "program to execute". And I am
> > afraid that reading a command without even mentioning the term "merge"
> > once is pretty misleading in this setting.
> >
> > And even from the theoretical point of view: cherry-picking non-merge
> > commits is *so much different* from "rebasing merge commits" as discussed
> > here, so much so that using the same command would be even more
> > misleading.
> 
> This last statement is plain wrong when applied to the method in the
> [RFC] you are replying to. Using the method in [RFC], "cherry-pick
> non-merge" is nothing more or less than reduced version of generic
> "cherry-pick merge", exactly as it should be.
> 
> Or, in other words, "cherry-pick merge" is generalization of
> "cherry-pick non-merge" to multiple parents.

I think Sergey does have a point here, his approach showing it.

Phillip`s simplification might be further from it, though, but we`re 
talking implementation again - important mental model should just be 
"rebasing a commit" (merge or non-merge), how we`re doing it is 
irrelevant for the user, the point (goal) is the same.
