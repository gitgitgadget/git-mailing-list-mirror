Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 214BD20401
	for <e@80x24.org>; Thu, 15 Jun 2017 17:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753557AbdFOR7P (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 13:59:15 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36337 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753543AbdFOR7N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 13:59:13 -0400
Received: by mail-pf0-f195.google.com with SMTP id y7so2521519pfd.3
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 10:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SbgEfAnZrPOCMy6oKgdR2tfRqJ1RYI1IAxAzZ55bfsE=;
        b=Ei1IlmS9gFbh41Vb9loZBl5zSopinh3T4Yg088sXlgKIjLWhAajEOq4E4WtMh7oeF0
         Myw6WqramSatZv+MltJvngDJo5XCbFJxxAz3zoMdAIyQ0/Dwox2kH3XmHSFSeKAwS+hZ
         OTzKO8yTLzNTaWxCZm1QOHeRDCxs19PgXNbUxFjTycM9L63QSUWMMyxTeLc++qyETmCw
         tmetUXkeTt+fHbUh48QW/l/fDEaW+0S/b9Hg1Owc0lErnOnAV08F7pZ0pUtLYt3gvwX5
         DWm+FN9hKy+3VH6ONgctPbjFw9V73O6Yas/iy/FGwgtrFzQW70VqljsXHwOOUKOSlDXO
         HQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SbgEfAnZrPOCMy6oKgdR2tfRqJ1RYI1IAxAzZ55bfsE=;
        b=SFF0cdfocrJh4c+3VtFw/8TX91e6Sl8CwNaB1jj2W07MkgrXNhB9s9sausqJ9n9pA3
         y1dDnXbcQVsDruJzLGnRfdjbVR7z3aRJdHHqI+bmf3PYEbzde0Tf9IiqCeHcrKHqiqi+
         wxiJNFA+s+nidFGXARnW+S0xV5l6UIsMgJsb1D/xjklGo0H5POjxNNr2eXai5ubWoAFZ
         7tdJSYldkB4ouBFP3IL1JmP08HIvYtogMe5Ml7viVUCRMgQoSHssgV/XkmzSThZNBtRZ
         G17DMCXXVcHlQGZdavhCQ/OGzmTpoWIYwNHLMQz0f2yVuzqgv/geBiol9fqeWicOFDVD
         WRrw==
X-Gm-Message-State: AKS2vOzoomnyay6Vd6gm0NX5JWxL5vu2vlHBQlg22PIJolOiYO6dEaZq
        Oz+zOv4yXOG/gQ==
X-Received: by 10.99.109.7 with SMTP id i7mr6581207pgc.143.1497549552521;
        Thu, 15 Jun 2017 10:59:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88c8:4433:c52b:12d7])
        by smtp.gmail.com with ESMTPSA id r83sm1559557pfk.57.2017.06.15.10.59.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 10:59:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v1] Configure Git contribution guidelines for github.com
References: <20170609142151.94811-1-larsxschneider@gmail.com>
        <31A456B20D984421AA958A39B2FCD29D@PhilipOakley>
        <xmqqlgoxp5ig.fsf@gitster.mtv.corp.google.com>
        <CACBZZX42JcqFAsWgi0bSuRv5CC8hiUF1Ahnx3nJL=LyHkk03Cg@mail.gmail.com>
        <xmqqk24d2oco.fsf@gitster.mtv.corp.google.com>
        <6e0de364-97a4-a2c1-eaea-8e9931cce6b5@gmail.com>
Date:   Thu, 15 Jun 2017 10:59:11 -0700
In-Reply-To: <6e0de364-97a4-a2c1-eaea-8e9931cce6b5@gmail.com> (Andreas
        Heiduk's message of "Thu, 15 Jun 2017 19:31:51 +0200")
Message-ID: <xmqq37b12kuo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Heiduk <asheiduk@gmail.com> writes:

> Am 15.06.2017 um 18:43 schrieb Junio C Hamano:
>> Another thing that may regress that you did not mention is that we
>> would lose a convenient way to _count_ proposed changes coming via
>> submitGit (i.e. you can simply go to the pull-request page), so that
>> the number can be compared with the number of proposed changes
>> directly made on the mailing list, which would be a good way to
>> gauge how submitGit service is helping our community.  But even for
>> that, you'd need to go to the list to find the denominator
>> (i.e. total number of changes proposed), and by the time you do
>> that, counting the numerator (i.e. those come via submitGit) by
>> finding the telltale sign submitGit leaves in its output among these
>> denominator messages should be trivial.
>
> This numbers can be aquired quite easily if submitGit adds a defined
> trailer to the converted commit message like this:
>
> 	Signed-off-by: Foo Bar <foo@bar>
> 	Submit-git-id: url-or-id-of-pr

I do not think you would want the noise _in_ the log message.  The
"telltale sign" I had in mind was these "signature" lines at the end
of the message:

    --
    https://github.com/git/git/pull/538

