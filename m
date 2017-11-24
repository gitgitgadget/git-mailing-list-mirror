Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 235EF202F2
	for <e@80x24.org>; Fri, 24 Nov 2017 00:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753404AbdKXAM4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 19:12:56 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38104 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753398AbdKXAM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Nov 2017 19:12:56 -0500
Received: by mail-wm0-f52.google.com with SMTP id 128so19427374wmo.3
        for <git@vger.kernel.org>; Thu, 23 Nov 2017 16:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=jboNLSr6/Pya1QM9tTt07M0eeVNFzXZXg6J/kA2MGmY=;
        b=VczlHP+PRfIlJxasJxqaS9YB9/UuWHo4ofXWyf9Tlk/qH9hREvt6q3BSPO313k0yK9
         HkNZReldC2VfiI5YMDU+KkyVF+xn8ICi6ur1d4oNxgmd3k+23vBJGKl0aJfXugGuPhuG
         4/KBqXA1BLnB52qdwXV2sx+gvZEfepPqAvuYnRAYh6qiCHF0sFPU+YR+6XnoTVJbwGDw
         6LqukahICB+hlkK04dqa7zI0Rp9JKsKplDORkrLzECy0qLnIL9b569O21Lab6eD4sPFa
         DLTc+YvgmvzXBLDoE/ZU9DP4i6pVcciFHv+kq8I+EyPO95yjI4A0CzwYcNdObxDk8vOf
         aQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jboNLSr6/Pya1QM9tTt07M0eeVNFzXZXg6J/kA2MGmY=;
        b=RGiIg87RqlJ1wlsrcl6I27ymZJtI2xNkuQzDjSdyXeLWUtYV05eI4GeF4wWXZFML04
         pwBSvFhrHFCOapn8wKzWOWhd8Zqn+birGfoEleEu4KvGnqmlXPZ95GeKhP0iW+R1tk1Y
         CeNCw+0lu8j0ebn2liWFZfi3LnwVZTa7kKElWS+DAo1tk8Eso1amkkQSs+qURGj9kGK7
         X5r0PARbTa4k5rhIYRGjQ6R+MmXyNOMKnJGtCP358mIY/5PbwicEo8V+W0KWcDiPiIiF
         HLBxgaSW15BRz1zYthWNv6t/33ogp9xwqKMsFQlUXftQaZyxQsxQmXIHvDyfcVgWOa0f
         o7jw==
X-Gm-Message-State: AJaThX5HYvuo/7azX3BfKZGJzgwxdRZELGIXvNSsN5fHXzVyzwQt+xYE
        HjBqtwyiE6eB+rRkttLjmE94DZa4
X-Google-Smtp-Source: AGs4zMaPbB5HLwWjXNxipPPXMkfpIFYt6Hg8pREYfLx67Z2DsY2XjMlmA3ORMx5bUj1S3hdVvOblZw==
X-Received: by 10.28.14.195 with SMTP id 186mr8177017wmo.56.1511482374803;
        Thu, 23 Nov 2017 16:12:54 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id r14sm47646130wrb.43.2017.11.23.16.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Nov 2017 16:12:54 -0800 (PST)
Subject: Re: Problem installing Git (followup)
To:     Phil Martel <pomartel@comcast.net>, git@vger.kernel.org
References: <077942bb-5952-6f4a-8054-b17d3883b901@comcast.net>
 <f30c4350-500a-44e8-27ee-7d5ae49903c4@gmail.com>
 <5d95405e-7c95-88b2-2481-bb7990c5b8b5@comcast.net>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <55436c77-89f7-8f18-18a3-ca75a5ff96cb@gmail.com>
Date:   Fri, 24 Nov 2017 01:12:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <5d95405e-7c95-88b2-2481-bb7990c5b8b5@comcast.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phil,

On 24/11/2017 00:44, Phil Martel wrote:
> On 11/23/2017 4:30 PM, Igor Djordjevic wrote:
>> On 23/11/2017 19:51, Phil Martel wrote:
>>> I'm trying to install Git-2.15.0-64-bit.exe onto my Windows 10 
>>> machine.  When I run this installer program no matter what 
>>> options I try or whether I run as administrator it ends up with 
>>> an error box saying "The drive or UNC share you selected does 
>>> not exist or is not accessible. Please select another".  I do 
>>> not see any way of selecting a drive.  Any suggestions?
>> 
>> Do you already have "Git for Windows" installed? If so, does it work
>> if you try uninstalling it first?
> 
> That solved my problem.  I apparently had enough cruft left over 
> from a hard disk issue for Windows to think I still had a copy of 
> Git installed.  when I got rid of it, the new version installed
> with no problems.
> 
> Thanks again,

No problem, it was more of a lucky shot, but glad it helped :)

Regards, Buga

p.s. When discussing here, it`s more customary to quote inline, instead of top-posting[1].

[1] https://en.wikipedia.org/wiki/Posting_style
