Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28ECF1F404
	for <e@80x24.org>; Sun, 11 Mar 2018 17:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932214AbeCKRqw (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 13:46:52 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53579 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932173AbeCKRqv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Mar 2018 13:46:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id e194so12205875wmd.3
        for <git@vger.kernel.org>; Sun, 11 Mar 2018 10:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a6ozxS7tivX7RR4SxI+qFAd4/P43lxSSp+Eq3b1ELvk=;
        b=rwBiwvWR5KXXdWtElgPcpQnLMeD5Hk1HQ0pVLCK2XxF/E6KexYGcVbh5Zle0cnS9Dh
         jwToVxhYXiJjFBAeZYSvS+zpammc9GBkOlysP1HQSJst9CgFYVFO/dHq5msaVCTNLoU+
         lr7HmFQBg5U4nkJbOEFQbxT8tg3seV0FQx/9yweEhvW9soeo/ptWFvCfUuimQZBR2NBf
         71BbeSTPdsFZIVziwIcv5enKQrSjR2EDB2ieHKQXlQ34MQn4W8+prUCV+Cdn0qjRFQgR
         zdsBLXOo1UJH+MYiFwmNgo0HNx8L+J5LqQHSNJYpyNhnr3TiQkq4EOkB8cBu/x7pQXZB
         q3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a6ozxS7tivX7RR4SxI+qFAd4/P43lxSSp+Eq3b1ELvk=;
        b=ftSgSPKEhNbhCONN1gZsT3wqMwSejjaMubtG8OR6OzdRIvHn8FMztbXyBjAkkKOqav
         gPTgQC6pDx5LCmJ/ZVWtbGBjxG1DkPz9IUhvm/HHGjo/sA2P6DJPdL1tIHgdsrGvx7Bi
         SnsvUKgNgLHqOAGpMYHF6nMi1BRrtRyeyXB41y3dMMUxG+GjdKucia7oHAsEcibIFOpz
         I8WRuMT+FxGb3TjGHyEV4Qt4kA4PFKXw5+d+CSIyS19WQYf3GPVyEs/MeqZLRlH8VErX
         khiV9uSoBTtRl6GZu5VPLLC1WWVCh24d4TYlXABLxb+MeBvXCTX+sTTJRmbLBCpBFjqQ
         Ui6g==
X-Gm-Message-State: AElRT7HRonjkamoITAYjsIiKRO2LMCxuHEonZe42U4pKH51AhvxrwvFj
        I8RJ2AWT1XnbuMljH4hv0UQ=
X-Google-Smtp-Source: AG47ELsL0Dgk2ZU2rxMDxSE80zNQ525RHA7KKBQBJ6gTzyckvD/Nt7Cu3ZUgsq+kmZZJWgzIy7WtLA==
X-Received: by 10.28.159.209 with SMTP id i200mr569797wme.87.1520790410550;
        Sun, 11 Mar 2018 10:46:50 -0700 (PDT)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id 69sm3830622wmp.36.2018.03.11.10.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Mar 2018 10:46:49 -0700 (PDT)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jacob Keller <jacob.keller@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Sergey Organov <sorganov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com>
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
 <CA+P7+xoOVzxnmZN893ND4+55=OhtrE-gt7jRhtxoOUL=G_CrgA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1803111308320.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <89fe98ed-461e-bd48-a833-baa15252cdcd@gmail.com>
Date:   Sun, 11 Mar 2018 18:46:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1803111308320.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On 11/03/2018 13:11, Johannes Schindelin wrote:
> 
> > > I did wonder about using 'pick <original-merge>' for rebasing merges
> > > and keeping 'merge ...' for recreating them but I'm not sure if that
> > > is a good idea. It has the advantage that the user cannot specify the
> > > wrong parents for the merge to be rebased as 'git rebase' would work
> > > out if the parents have been rebased, but maybe it's a bit magical to
> > > use pick for merge commits. Also there isn't such a simple way for the
> > > user to go from 'rabase this merge' to 'recreate this merge' as they'd
> > > have to write the whole merge line themselves (though I guess
> > > something like emacs' git-rebase.el would be able to help with that)
> >
> > Since the ultimate commit hashes of newly rebased commits would be
> > unknown at the time of writing the todo file, I'm not sure how this
> > would work to specify the parents?
> 
> I agree with Phillip's follow-up that the `pick <original-merge>` syntax
> would pose a problem, but for different reasons: We already tried it, with
> --preserve-merges, and it is just a really stupid syntax that does not
> allow the user even to reorder commits. Or drop commits (except at the
> very end of the todo list).

Hehe, please excuse me, but in the light of that other explicit (or 
not) parent mapping discussion[1], I would take a chance to be really 
sneaky here and say that being non-explicit "is just a really stupid 
syntax that does not allow the user even to reorder rebased merge 
parents. Or drop parents (except at the very end of the parent list)." ;)

[1] https://public-inbox.org/git/b329bb98-f9d6-3d51-2513-465aad2fa37a@gmail.com/
