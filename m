Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE3C81F516
	for <e@80x24.org>; Mon,  2 Jul 2018 23:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753281AbeGBXMh (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 19:12:37 -0400
Received: from dmz-mailsec-scanner-3.mit.edu ([18.9.25.14]:54122 "EHLO
        dmz-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752985AbeGBXMg (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 2 Jul 2018 19:12:36 -0400
X-AuditID: 1209190e-669ff70000005728-4e-5b3ab1633bc2
Received: from mailhub-auth-2.mit.edu ( [18.7.62.36])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by dmz-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 82.FB.22312.361BA3B5; Mon,  2 Jul 2018 19:12:36 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH-1.MIT.EDU [18.9.28.11])
        by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id w62NCZV2000493
        for <git@vger.kernel.org>; Mon, 2 Jul 2018 19:12:35 -0400
Received: from darkmatter.mit.edu (DARKMATTER.MIT.EDU [18.18.248.31])
        (authenticated bits=0)
        (User authenticated as smtp/darkmatter.mit.edu@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id w62NCXCY023667
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <git@vger.kernel.org>; Mon, 2 Jul 2018 19:12:34 -0400
Received: by darkmatter.mit.edu (Postfix, from userid 115)
        id 296B3354B4B; Mon,  2 Jul 2018 19:12:33 -0400 (EDT)
Received: from [192.168.1.34] (209-6-198-183.s4021.c3-0.smr-cbr2.sbo-smr.ma.cable.rcncustomer.com [209.6.198.183])
        by darkmatter.mit.edu (Postfix) with ESMTPSA id BFC21354B4B;
        Mon,  2 Jul 2018 19:12:32 -0400 (EDT)
Subject: Re: [PATCH] Makefile: tweak sed invocation
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.us>
Cc:     Git List <git@vger.kernel.org>, Dan Jacques <dnj@google.com>
References: <1529954005-18189-1-git-send-email-asedeno@mit.edu>
 <CAPig+cQxAxFUFE8j2O7iaZoAby9ioNd6Wf1OVAr5qU7kTrQOyQ@mail.gmail.com>
 <xmqqefgtl7kq.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Alejandro_R=2e_Sede=c3=b1o?= <asedeno@mit.edu>
Message-ID: <491ff83e-97a6-c3f4-2d85-9c930908f6b1@mit.edu>
Date:   Mon, 2 Jul 2018 19:12:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqefgtl7kq.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsUixG6nopuy0SraYN0LZouuK91MDowenzfJ
        BTBGcdmkpOZklqUW6dslcGVMOHmBqeAwS8XdNw3sDYwnmLsYOTkkBEwkvt28ztTFyMUhJLCY
        SWLhzW4WCOcUo8SZ+/1QmddMEndmLARq4QByiiTm/WCHiN9klOg+1sIEMkpYwFhi/f8DYGNF
        BPwkfl6ezghiMws4SKyecxaqYSujxPtJv8Aa2ATsJOYtuQVm8wpYSbQf7mUDsVkEVCQOvHzB
        DmKLCkRJfN3RxQxRIyhxcuYTFhCbU8BSYtO0RmaIBWYS8zY/hLLFJW49mc8EYctLbH87h3kC
        o/AsJO2zkLTMQtIyC0nLAkaWVYyyKblVurmJmTnFqcm6xcmJeXmpRbrGermZJXqpKaWbGEFh
        zynJt4NxUoP3IUYBDkYlHt4LilbRQqyJZcWVuYcYJTmYlER5JRqAQnxJ+SmVGYnFGfFFpTmp
        xYcYJTiYlUR4t6kC5XhTEiurUovyYVLSHCxK4rzZixijhQTSE0tSs1NTC1KLYLIyHBxKErwL
        NgA1ChalpqdWpGXmlCCkmTg4QYbzAA2XAKnhLS5IzC3OTIfIn2LU5fjzfuokZiGWvPy8VClx
        XhGQIgGQoozSPLg54HQl9EP+FaM40FvCvHogVTzAVAc36RXQEiagJT3bLEGWlCQipKQaGI8F
        +4apz5vKMX3m+zd1zIKtrt/fnpyfp5/g4hs+yVZ9xxm37OvX7+pHCz1uylmwcXpb4KnF+/hD
        GZ3tdJ4vZ1gZHBguJvV3YxybZd39BR4bQ6K0dM03JT0RrZ/MIqw0sbVXu3FX/o5Pnz+d/WOv
        pHBiq+w5BS/JOV/tW5MtD/AK+b172/uPRYmlOCPRUIu5qDgRAFg2jAIyAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-06-26 14:35, Junio C Hamano wrote:
> Having said that, I'm a bit surprised that our build infrastructure
> and shell scripts still work on tools on SunOS.  I used to have
> access to SunOS/Solaris boxes and tried to be careful not to break
> them unnecessarily, but these days I don't, so I expected to hear
> quite a huge bit-rotting.

I end up building new releases on SunOS all the time; when things break 
there is usually when you hear from me. I'm hoping this patch makes it 
into 2.18.1 so I don't have to apply it during my build process.

-Alejandro
