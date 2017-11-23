Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76B3A202F2
	for <e@80x24.org>; Thu, 23 Nov 2017 23:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753343AbdKWXoS (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 18:44:18 -0500
Received: from resqmta-ch2-08v.sys.comcast.net ([69.252.207.40]:38140 "EHLO
        resqmta-ch2-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752951AbdKWXoR (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2017 18:44:17 -0500
Received: from resomta-ch2-09v.sys.comcast.net ([69.252.207.105])
        by resqmta-ch2-08v.sys.comcast.net with ESMTP
        id I19eeuVX51zMnI1AGekts9; Thu, 23 Nov 2017 23:44:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20161114; t=1511480656;
        bh=VoF5HLMaz1yY51uhMuoNJjXIMxsolNV7YCaAJlv/yDg=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=NfXyrkJEehMN/i+woHkazDQkADFc2yjPgbycRtNfoN69szgCur/zpXoeplxAfRrNJ
         tTGm7ZlFRn/gfaH9Qd5SQDrULih2JVopfhDdGQtkah35WxEKX3Afx8b3DTVBffmeQa
         Qeb0+g8eGjH5thiapEXSldLvzh0UzK1R7PAkmlhWEG+Y/H45t2JWQgMAw/hTb0yy70
         ThV6dv6XUHpZU2SN2WYk7hbRj2Lf0nyK2adM6k4hQ4b8EOcA1Ppduwqr+JKIykfLB1
         WycRNwYuJRcrqfwM8sgn9yG3a7SbU+5pidiEzn1n3y20iR5bzy0lOgCvnV0+ILY/wz
         u3kLmiSAFNEYQ==
Received: from [192.168.1.100] ([73.149.212.147])
        by resomta-ch2-09v.sys.comcast.net with SMTP
        id I1AGeLlwP2mvhI1AGeq2Dw; Thu, 23 Nov 2017 23:44:16 +0000
Subject: Re: Problem installing Git (followup)
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>, git@vger.kernel.org
References: <077942bb-5952-6f4a-8054-b17d3883b901@comcast.net>
 <f30c4350-500a-44e8-27ee-7d5ae49903c4@gmail.com>
From:   Phil Martel <pomartel@comcast.net>
Message-ID: <5d95405e-7c95-88b2-2481-bb7990c5b8b5@comcast.net>
Date:   Thu, 23 Nov 2017 18:44:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <f30c4350-500a-44e8-27ee-7d5ae49903c4@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CMAE-Envelope: MS4wfLsSiipI84Wjj2h8WkbV+YlAK9+yttaRdLlW5kfGTyv32zMyNfiAEeGCJMcm/A9nAdeNGmys9XypKWg1v/DH8JOUER+hyW7QVw28j6On0DRV5AZEJBun
 YfkR8GEoGi5ntiBjEjylF1BMwUH9heCNGSqAxXKYge5yn0KdGfvfVTxAVIn62BIwFQAn79Oi0+A1nYCeRa2n5dHgqQ9ek1gzqaJJTG/cUEWLafxmf7IEmxU0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Buga,

That solved my problem.  I apparently had enough cruft left over from a 
hard disk issue for Windows to think I still had a copy of Git 
installed.  when I got rid of it, the new version installed with no 
problems.

Thanks again,

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

