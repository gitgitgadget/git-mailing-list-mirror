Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F76F1F597
	for <e@80x24.org>; Wed, 25 Jul 2018 09:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbeGYKaX (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 06:30:23 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:50854 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbeGYKaW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 06:30:22 -0400
Received: by mail-it0-f52.google.com with SMTP id w16-v6so7726121ita.0
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 02:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beanbaginc-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=mWRr6SSPpB5s8PjR4jW4fDGnZ5V2UozsWX5fBY8zkHA=;
        b=xu7DxDN9Xdvf+8cZTV2pAT5/OMBrQ3FN8rzhO5+Di6et/qFdlb6LlB81XX/qLjdfXu
         5D6bxKh4cLQUD7VpgbwTTZ23V4fje0HqIB6uxl5gpyKne87ICdbWbochBQEURzwfpp6s
         SGR74bd5lzYG5R41dxWw7H1tIE5uGGo7FfI187LNjVqCr+SZtpoYgevDhzPb64z+paGA
         JYLUPB5uqzDgB4ae0nWQ7UveR8aViOGUIrKOF/gpcd/IV64aKrzlYtSWwk6KBhEUlIIG
         GjDAik+ZNw9gL0o0Urg7tGjP7rhaCNYISrvCaz5vuZlR4hH7zQfcvosHWOc7zLo/HLtk
         1qOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=mWRr6SSPpB5s8PjR4jW4fDGnZ5V2UozsWX5fBY8zkHA=;
        b=OTyG+r/kPi8UKR3ZUk0+iAWUrmkkdpaWt9FEQCNOuwgWn8VdA0EbFdyJeavsMjuGlY
         4QylgQdXVh5f0Ph81TMhrPtaC9/fAwV8za4J0OpqnLQ9aciMu725fOhPYr4MXIAbdAY1
         eoqhK7XuWu5b6Z66aZzAqO1HeUXY058XY2saZc96xq0fUvz8AzXpXBR8GCpGif5aiZ8G
         WWpXM+jT32OlpzCTFEamMKT8KkEW+QG/IOe4Az1q/aqb8vDlhPvvlHkcNE8D5uZrMGHL
         6fUU8W07G3aTKUedB0V2DuU6YMs++ph8f9YmI0v3L6dzJB1gaX/2vSqa9tJlQxxNM7VH
         Xieg==
X-Gm-Message-State: AOUpUlGi9kZ+Zrgu4mwUdx6TJSW3cW2TjEjF+EsQ8Dxjyu0RX748LZKu
        cCphxCpZGRbEUhdlNXY7MFoGcLL8rYj9D3tW3KXQscNMNYA=
X-Google-Smtp-Source: AAOMgpe8ea0+ziDC+2i3yPTqZmrZVP3XQPBJz/rbQhXu6RBRoR7tr0hLjwzirke4lFG+8GmPcjRkacBxNOrTWzGkICg=
X-Received: by 2002:a24:8e41:: with SMTP id h62-v6mr5887677ite.68.1532510374097;
 Wed, 25 Jul 2018 02:19:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:94e7:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 02:19:33
 -0700 (PDT)
X-Originating-IP: [142.165.34.81]
From:   Barret Rennie <barret@beanbaginc.com>
Date:   Wed, 25 Jul 2018 03:19:33 -0600
Message-ID: <CAL8WYQAskO=5CTpOrGtiLG1xyOn2OpZVAnBmN7sORrRaFbn4OQ@mail.gmail.com>
Subject: [RFC] notes.<REF>.rewriteMode configuration option
To:     git@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000768ddc0571cf6049"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000768ddc0571cf6049
Content-Type: text/plain; charset="UTF-8"

 Hi all,

The project I work on currently heavily uses git. We would like to add some
tools based around detecting how branches change over time for code review,
so
that users can compare commits as they change. We'd like to do this via
adding
metadata in git notes, so that we can detect when commits are ammended or
squashed. While digging around in the `git notes` help, I noticed there is
support for `notes.<ref>.mergeStrategy` but not `notes.<ref>.rewriteMode`
configuration options. I was wondering if you would be interested in a patch
that adds support for a `notes.<ref>.rewriteMode` configuration option that
would take precedence for doing note rewrites for the given ref (like how
`notes.<ref>.mergeStrategy` takes precedence for merges).

Regards,
Barret Rennie

--000000000000768ddc0571cf6049
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">
Hi all,<br>
<br>
The project I work on currently heavily uses git. We would like to add some<br>
tools based around detecting how branches change over time for code review, so<br>
that users can compare commits as they change. We&#39;d like to do this via adding<br>
metadata in git notes, so that we can detect when commits are ammended or<br>
squashed. While digging around in the `git notes` help, I noticed there is<br>
support for `notes.&lt;ref&gt;.mergeStrategy` but not `notes.&lt;ref&gt;.rewriteMode`<br>
configuration options. I was wondering if you would be interested in a patch<br>
that adds support for a `notes.&lt;ref&gt;.rewriteMode` configuration option that<br>
would take precedence for doing note rewrites for the given ref (like how<br>
`notes.&lt;ref&gt;.mergeStrategy` takes precedence for merges).<br>
<br>
Regards,<br>
Barret Rennie

<br></div>

--000000000000768ddc0571cf6049--
