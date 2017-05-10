Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7780F1FF34
	for <e@80x24.org>; Wed, 10 May 2017 10:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbdEJKSY (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 06:18:24 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34429 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751301AbdEJKSY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 06:18:24 -0400
Received: by mail-io0-f195.google.com with SMTP id 12so1646869iol.1
        for <git@vger.kernel.org>; Wed, 10 May 2017 03:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TZET8usq1zWdXsa4y8mkL3YnynHrsqhhBdio5p4Kxb8=;
        b=su4iq+orW43ZxvPb8CB5Ca2Yml0iBJvZqGsiPFP3bGU8nzB1vFJPfB7vIk3KvjHJpk
         fsb1LCDLa981ECajXIl/3onVqctoBeSU3U3y6FZIZsHAtWEgMeBGCn7R5jOnYCRM/gyw
         zvP4SBbwW7exBM3RKcJv4oj+uhcR5nB6D/6lQlCRZOnPcH40h91AyuOULf4FBj8yDgS7
         I7RZORvu1REhqVZyhiMJgqV/bfexZxSOLwn//B+yrI9/e5oY4zBnazW7HcmohRFDl5zi
         AWRFNCdWBK0k1uwOIAhMN8OOVrx3t43Q8STDbHy9Oj1vSHpMAaWnlzWEi3x6XqUkzWBy
         /Aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TZET8usq1zWdXsa4y8mkL3YnynHrsqhhBdio5p4Kxb8=;
        b=EnUuOfaKTqu95kfi0ZddYhCFLiJa7mrKa8iaBlglxjnu8fqv0N+0bSZu4E4ivwKtFk
         Ih+a48w/hJO7Avq92MAPrC2tAIcBRwiwMdgPktPGthItmd3CNuczVZvFMzgYLd62OJq1
         axDEsI91ENjjcttq3N8OknEyzoT5fcf9xwvA94McvpnNiVEteYHqErDGHMRHnczdyjR8
         IEXS9aNAUmFZ3H6U9P3xobn+8n4C1T5Q+Gzf4KqTVqgcHvq2Me8xDayomkUw4zGdQIfP
         KTxwpiT/ExCrsEqV/TYLKoi0KVngkwDsoIZXNhJ5rE67i+8zUl809eBbdKPeodStbE+T
         Abhg==
X-Gm-Message-State: AODbwcDwuWlwOzaIXit7S3QozIQI2FBLE/EoSF4sc4veIu+Shu6IwRYP
        st0jtwBmKWA9XCrrxuQI48svsuoKHg==
X-Received: by 10.107.201.131 with SMTP id z125mr2380627iof.160.1494411503136;
 Wed, 10 May 2017 03:18:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Wed, 10 May 2017 03:18:02 -0700 (PDT)
In-Reply-To: <CAKohpok0=0__AcNZAfziTMYVDhGka3o0hzEN6HHZc=YUr7hWYQ@mail.gmail.com>
References: <CAKohpok0=0__AcNZAfziTMYVDhGka3o0hzEN6HHZc=YUr7hWYQ@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 10 May 2017 12:18:02 +0200
Message-ID: <CACBZZX4pz26SCZBbivDneRX6hRPxpuPHXpOQKnn1zJL6xWj_Eg@mail.gmail.com>
Subject: Re: [Query] Override sendemail.tocmd
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 10, 2017 at 9:23 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi,
>
> I have a use case and wanted help from you guys..
>
> I have set the sendemail.tocmd option in my kernel's .git/config
> file and that works very well. But sometimes I want to avoid that
> (for example sending the patch to someone without the list and
> maintainers).
>
> The suppress-cc=all option works quite well to avoid almost
> everything (including running --cc-cmd), but it doesn't suppress
> --to-cmd.
>
> Are there any specific reasons why it is being done that way?
>
> Currently I need to go edit my .git/config file and remove tocmd
> before sending any such patches and it sucks :)

Does something like this work:

    git -c sendemail.tocmd=/bin/false send-email ...

?
