Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4ABA1F404
	for <e@80x24.org>; Mon, 12 Mar 2018 12:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751252AbeCLM4O (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 08:56:14 -0400
Received: from mail.javad.com ([54.86.164.124]:40523 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751104AbeCLM4N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 08:56:13 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id C311E3E966;
        Mon, 12 Mar 2018 12:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520859373;
        bh=8Y2S89mABPedPEvaO2HxCTYtT9yY/Bt6vfVui28ddoQ=; l=1528;
        h=Received:From:To:Subject;
        b=W1nRqUWg+t5OUwdah1DUvS8hC7KeLa5vHx/m432dCuPf/IHq6oowJzs4CUjd0v4TH
         X4HMo2SZJHM21KVKHd9SgfaM4jzyNqxWbMEBIyZ1axcrca/v9RLmNz4z+AdqZ06CFe
         LJfWbsFLyRcPH8U+xwH+vk7QhLAk0I1Ui8hF9DEM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520859373;
        bh=8Y2S89mABPedPEvaO2HxCTYtT9yY/Bt6vfVui28ddoQ=; l=1528;
        h=Received:From:To:Subject;
        b=W1nRqUWg+t5OUwdah1DUvS8hC7KeLa5vHx/m432dCuPf/IHq6oowJzs4CUjd0v4TH
         X4HMo2SZJHM21KVKHd9SgfaM4jzyNqxWbMEBIyZ1axcrca/v9RLmNz4z+AdqZ06CFe
         LJfWbsFLyRcPH8U+xwH+vk7QhLAk0I1Ui8hF9DEM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520859373;
        bh=8Y2S89mABPedPEvaO2HxCTYtT9yY/Bt6vfVui28ddoQ=; l=1528;
        h=Received:From:To:Subject;
        b=W1nRqUWg+t5OUwdah1DUvS8hC7KeLa5vHx/m432dCuPf/IHq6oowJzs4CUjd0v4TH
         X4HMo2SZJHM21KVKHd9SgfaM4jzyNqxWbMEBIyZ1axcrca/v9RLmNz4z+AdqZ06CFe
         LJfWbsFLyRcPH8U+xwH+vk7QhLAk0I1Ui8hF9DEM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520859373;
        bh=8Y2S89mABPedPEvaO2HxCTYtT9yY/Bt6vfVui28ddoQ=; l=1528;
        h=Received:From:To:Subject;
        b=W1nRqUWg+t5OUwdah1DUvS8hC7KeLa5vHx/m432dCuPf/IHq6oowJzs4CUjd0v4TH
         X4HMo2SZJHM21KVKHd9SgfaM4jzyNqxWbMEBIyZ1axcrca/v9RLmNz4z+AdqZ06CFe
         LJfWbsFLyRcPH8U+xwH+vk7QhLAk0I1Ui8hF9DEM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520859373;
        bh=8Y2S89mABPedPEvaO2HxCTYtT9yY/Bt6vfVui28ddoQ=; l=1528;
        h=Received:From:To:Subject;
        b=W1nRqUWg+t5OUwdah1DUvS8hC7KeLa5vHx/m432dCuPf/IHq6oowJzs4CUjd0v4TH
         X4HMo2SZJHM21KVKHd9SgfaM4jzyNqxWbMEBIyZ1axcrca/v9RLmNz4z+AdqZ06CFe
         LJfWbsFLyRcPH8U+xwH+vk7QhLAk0I1Ui8hF9DEM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520859373;
        bh=8Y2S89mABPedPEvaO2HxCTYtT9yY/Bt6vfVui28ddoQ=; l=1528;
        h=Received:From:To:Subject;
        b=W1nRqUWg+t5OUwdah1DUvS8hC7KeLa5vHx/m432dCuPf/IHq6oowJzs4CUjd0v4TH
         X4HMo2SZJHM21KVKHd9SgfaM4jzyNqxWbMEBIyZ1axcrca/v9RLmNz4z+AdqZ06CFe
         LJfWbsFLyRcPH8U+xwH+vk7QhLAk0I1Ui8hF9DEM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520859373;
        bh=8Y2S89mABPedPEvaO2HxCTYtT9yY/Bt6vfVui28ddoQ=; l=1528;
        h=Received:From:To:Subject;
        b=W1nRqUWg+t5OUwdah1DUvS8hC7KeLa5vHx/m432dCuPf/IHq6oowJzs4CUjd0v4TH
         X4HMo2SZJHM21KVKHd9SgfaM4jzyNqxWbMEBIyZ1axcrca/v9RLmNz4z+AdqZ06CFe
         LJfWbsFLyRcPH8U+xwH+vk7QhLAk0I1Ui8hF9DEM=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1evMzq-0001Kl-Nq; Mon, 12 Mar 2018 15:56:10 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        phillip.wood@dunelm.org.uk, Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution(RoadClear)
References: <87y3jtqdyg.fsf@javad.com> <87606hoflx.fsf@javad.com>
        <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com>
        <87a7vss6ax.fsf@javad.com>
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
Date:   Mon, 12 Mar 2018 15:56:10 +0300
In-Reply-To: <nycvar.QRO.7.76.6.1803121122390.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Mon, 12 Mar 2018 11:37:41 +0100
        (STD)")
Message-ID: <87h8plh2qd.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Buga,
>
> On Sun, 11 Mar 2018, Igor Djordjevic wrote:
>
>> I agree with both of you that `pick <merge-commit>` is inflexible 
>> (not to say just plain wrong), but I never thought about it like that.
>> 
>> If we are to extract further mentioned explicit old:new merge 
>> parameter mapping to a separate discussion point, what we`re 
>> eventually left with is just replacing this:
>> 
>> 	merge -R -C <original--merge-commit> <merge-head>
>> 
>> ... with this:
>> 
>> 	pick <original--merge-commit> <merge-head>
>
> I see where you are coming from.
>
> I also see where users will be coming from. Reading a todo list in the
> editor is as much documentation as it is a "program to execute". And I am
> afraid that reading a command without even mentioning the term "merge"
> once is pretty misleading in this setting.
>
> And even from the theoretical point of view: cherry-picking non-merge
> commits is *so much different* from "rebasing merge commits" as discussed
> here, so much so that using the same command would be even more
> misleading.

This last statement is plain wrong when applied to the method in the
[RFC] you are replying to. Using the method in [RFC], "cherry-pick
non-merge" is nothing more or less than reduced version of generic
"cherry-pick merge", exactly as it should be.

Or, in other words, "cherry-pick merge" is generalization of
"cherry-pick non-merge" to multiple parents.

-- Sergey
