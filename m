Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8489202F2
	for <e@80x24.org>; Thu, 23 Nov 2017 23:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753368AbdKWXfw (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 18:35:52 -0500
Received: from resqmta-ch2-11v.sys.comcast.net ([69.252.207.43]:51520 "EHLO
        resqmta-ch2-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752615AbdKWXfv (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2017 18:35:51 -0500
Received: from resomta-ch2-20v.sys.comcast.net ([69.252.207.116])
        by resqmta-ch2-11v.sys.comcast.net with ESMTP
        id I11qewYyzvLn4I127emNbm; Thu, 23 Nov 2017 23:35:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20161114; t=1511480151;
        bh=J9C4KA0fCq0izS6s0VeyBuQj4tjWuD9p8ua5eNCajjk=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=o8s+SqL4RkbaM95nn16csq8YssMXyOLTOi0Lp3KqGlJ0QQehj3lov1g5QNFNbtgAI
         8hhvuS23vPm5kI7TDd4vF+lFyg0M2sRqXB8cyg7hMEq7lAZqMtE/V+/wbK6OlX7j2P
         NWBwiZt6/K5em4HVGLz+FM3fzXgyPF06aQbrkHcDI1z9WLIreNtHKlOr3HxJwBtTGW
         T4E5HiOZvHyo3JcFg1oZw8skL7BlDQ2lOVE40qr6ERGyIitsscMxP2aNlQFncRzk3Z
         gElXIZu3Tun2cOqSCzxuxfJ9D9d7nu6co1zbNqUmIpjMiV7JeQHu5F7rQnbOphn0yE
         ukCV0mZ7Tx+uA==
Received: from [192.168.1.100] ([73.149.212.147])
        by resomta-ch2-20v.sys.comcast.net with SMTP
        id I126eeYo7k7fvI126e6WPw; Thu, 23 Nov 2017 23:35:50 +0000
Subject: Re: Problem installing Git
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>, git@vger.kernel.org
Cc:     git-for-windows@googlegroups.com
References: <077942bb-5952-6f4a-8054-b17d3883b901@comcast.net>
 <f30c4350-500a-44e8-27ee-7d5ae49903c4@gmail.com>
From:   Phil Martel <pomartel@comcast.net>
Message-ID: <b4fa4027-8019-7a35-40e0-77172047eab6@comcast.net>
Date:   Thu, 23 Nov 2017 18:35:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <f30c4350-500a-44e8-27ee-7d5ae49903c4@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CMAE-Envelope: MS4wfGenRD1cmb3/V019c6a7v2XKQu4sNUsFgKumvrIR0T/BXmnPFuULnxUSsXfkCNYbOup6pzIPj3NB4xFNzxy61f7mGEslGHbEzOXtnE7E4Gjv0Y0KKNqp
 mDf5SGwFrFUWuX6oZetNXqLOldb5UUhyzyt0EtpEO7tuQr9WBHMbskJlOEtH5hyxX4aqRF/i04dR8+Hz1oW5SMV8mp1Y3Jc32t4CroqwQNDO2lKNve9oI5mJ
 +jIbLEqo8kFZ1Ejkkbu6EtjHdXY2AcQUi2zVbDeU4OM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you.  I'll look into it.

Best wishes,

--Phil Martel


On 11/23/2017 4:30 PM, Igor Djordjevic wrote:
> [ +Cc:  Git for Windows mailing list ]
>
> Hi Phil,
>
> On 23/11/2017 19:51, Phil Martel wrote:
>> I'm trying to install Git-2.15.0-64-bit.exe onto my Windows 10
>> machine.  When I run this installer program no matter what options I
>> try or whether I run as administrator it ends up with an error box
>> saying "The drive or UNC share you selected does not exist or is not
>> accessible. Please select another".  I do not see any way of
>> selecting a drive.  Any suggestions?
>  From what I could Google around, this seems to be (Inno Setup?)
> installation related issue...?
>
> Do you already have "Git for Windows" installed? If so, does it work
> if you try uninstalling it first?
>
> Regards, Buga
>
> p.s. Note the existence of "Git for Windows"[1] specific mailing list
> as well, where this issue might belong better.
>
> [1] git-for-windows@googlegroups.com

