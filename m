Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 668E720288
	for <e@80x24.org>; Fri, 21 Jul 2017 17:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753111AbdGURrA (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 13:47:00 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34125 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751504AbdGURq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 13:46:59 -0400
Received: by mail-wr0-f193.google.com with SMTP id o33so5268819wrb.1
        for <git@vger.kernel.org>; Fri, 21 Jul 2017 10:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b5NzcIqTEan36VAiIOfnqyKJF4ntvF1NfLtfS91IzG8=;
        b=eFLvDAtOnL/DciCdVFjTUbjFi+F9kXyLIZkuc2f27dnGRqsUycDYPxjJhZZ3NenLjD
         g2BB4xvAUtERqCcWV4Id/Nt4hti9LuS9Oe31uQionfXRRX9Hdt7J+ZyI5wsgYGXIw5Cn
         IsJp6Bg73+gMZ9+W4sCBpVtsqCyIqBnr9JHbJXWAUkGV4xzJgs48O4MxKQd6AUkV+LWG
         hjNM6raXZ6u7acuqMLtWCfyBNkNNHu/fLy7IcM5hr121f69PIjxUdGyBoexYggsIcRlH
         LIuQbIAPrEX36pn9galWpyarmZ2JB77f7WuQRjTZwgRQEULroq86HVL/tGNwXc1kKth/
         ISVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b5NzcIqTEan36VAiIOfnqyKJF4ntvF1NfLtfS91IzG8=;
        b=cWdkY+trtJrJGrcHOMGqMTYTbpDMHpdAmUaokwJymgK1kF69hZl+ynI6SfOQGjxecZ
         0lCIccv4EJeEI0yEI7CxP5Q2Ek4gPisnF8b5xEEJZ9Ok4wqmsCXgrzxTPCZ/q4WNbkGy
         nbRUTaKrrREj9ts1tmbsp6aF+MML4wFwN+sybhbxPcqYG8mtmOFnvMSZbFNtJuV+T09/
         9S9FgwrgDRc0DbageORMXVkdPBSG0zMVCt3otzPqgqdL7MjTghsg+jbtjbGmpsjpP6YZ
         4Pll2gGJ7SfgW3gcP6jA8/iQ7q72NO9eYZ+v6mOlSFnBiwKV7bp46XIk999yrwroxqZK
         JjTA==
X-Gm-Message-State: AIVw1104lrnvOq8T/czG6wY7NZzkuyp2HTltA+1rZXYufvvMZeuuQaW8
        MgWFLtts6oLzPyd8NFzYkQ==
X-Received: by 10.223.147.99 with SMTP id 90mr10603354wro.70.1500659217797;
        Fri, 21 Jul 2017 10:46:57 -0700 (PDT)
Received: from [192.168.5.102] (cable-24-135-63-71.dynamic.sbb.rs. [24.135.63.71])
        by smtp.gmail.com with ESMTPSA id m72sm1777792wmg.16.2017.07.21.10.46.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jul 2017 10:46:56 -0700 (PDT)
Subject: Re: Binary files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Volodymyr Sendetskyi <volodymyrse@devcom.com>, git@vger.kernel.org
References: <CAFc9kS8L-JJoJqKi7bB90qwKVW8gB=EFk9D8c=4YShqnamwa2w@mail.gmail.com>
 <CAFc9kS_xYVyPsW7qogDxLugxBb1p2vEFAoP=W9Rdnfqs6XtWKQ@mail.gmail.com>
 <d4b1b92d-6ab1-7e6f-4afd-6194a5ba8e40@gmail.com>
 <xmqqo9sekfjm.fsf@gitster.mtv.corp.google.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <0d2dcfc0-81e0-ff16-3d21-7148978f8100@gmail.com>
Date:   Fri, 21 Jul 2017 19:46:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqo9sekfjm.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/07/2017 22:40, Junio C Hamano wrote:
> Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:
>> On 20/07/2017 09:41, Volodymyr Sendetskyi wrote:
>>> It is known, that git handles badly storing binary files in its
>>> repositories at all.
>>> This is especially about large files: even without any changes to
>>> these files, their copies are snapshotted on each commit. So even
>>> repositories with a small amount of code can grove very fast in size
>>> if they contain some great binary files. Alongside this, the SVN is
>>> much better about that, because it make changes to the server version
>>> of file only if some changes were done.
>>
>> You already got some proposals on what you could try for making large 
>> binary files handling easier, but I just wanted to comment on this 
>> part of your message, as it doesn`t seem to be correct.
> 
> All correct.  Thanks.

No problem, thanks for confirmation, being relatively new around it`s 
appreciated, at least knowing that I got it correct myself :)
