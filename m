Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED3AC1FC45
	for <e@80x24.org>; Sun, 12 Feb 2017 21:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751315AbdBLVdS (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 16:33:18 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35403 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbdBLVdS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2017 16:33:18 -0500
Received: by mail-wm0-f67.google.com with SMTP id u63so16120615wmu.2
        for <git@vger.kernel.org>; Sun, 12 Feb 2017 13:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=uqpriT+bvA3Putap8bqxQo2jhr7jUVKuk2CK666SU/U=;
        b=bvaeqrf4gJUsDnJajrTaD9eLbk34p3zZsdy8e1ee4nJfhJJv70ge3Foh+f6bjSnXX5
         EanWt6dJ3jwGZCmElWJtlvFdJCm3bojgh4cTJ26O1LJgwrXgowbLNUbJwmRhQ+6mOxdA
         WY2WGvL3NkqaAa2owX+3CYRRIM3H1+hLjK7v9iaIQaogEBtTzLI1iUA75Ncl2siGDNRd
         Wc6/8iEPfwr5F0jpJhhFQBNc6cboHu0uJEF0aGOyYkdvoDkNIk4hPUGOQPLNt/UBLZVT
         Yt4AJe+TR/Wl3BTJQ4Y9UWbTUzmQIF6Ik3cBAtVQaiyZ3Ry3aIUj+t9M9neL5fhyN02D
         9ckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:newsgroups:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=uqpriT+bvA3Putap8bqxQo2jhr7jUVKuk2CK666SU/U=;
        b=HmyO8Df1wrnHUwMBboTdj7uaR05c1KoRKFvH6WuhQXXl4esA1qaXXlai1OzJncbGbA
         +3AtF2IAnPm95C0ZmDIF+J/Ldy+D3Pyb+btNusFZu5hIL8zjkYPYX+r3AmYjgPR2tUCV
         FmUUtFE+Q+ehC5Y27l5YiDBkD1aQNBbnR/WCrvDpZIAdtla4GRuRek0/hjwUz767xjCR
         SKy2Sy2WvIZy3JsFpCCQ0CbWo6OcNKn2dKWGCl3IK8N2OwsQ/gdCXsdg9xn3M810JHh7
         OczwIO3STWm2BkX7pv5WkRki109aUrKbLb5tHpjXfppWvmBXMVTnJZUAoyt2PKbwO9aE
         MbmA==
X-Gm-Message-State: AMke39nc6XcWKQFAys5cDV01JPv7GWzs6knGTQ+r4J332UVIKEmQl7GIc2L0KmlhRQfuCQ==
X-Received: by 10.28.197.77 with SMTP id v74mr17011318wmf.30.1486935196380;
        Sun, 12 Feb 2017 13:33:16 -0800 (PST)
Received: from [192.168.5.102] ([87.116.181.111])
        by smtp.gmail.com with ESMTPSA id 10sm2754812wmi.23.2017.02.12.13.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Feb 2017 13:33:15 -0800 (PST)
Subject: Re: [git-gui] Amending doesn't preserve timestamp
To:     Juraj <juraj.orsulic@fer.hr>, git@vger.kernel.org
References: <CAEPqvoxM9_Ku-1YgwNiqearUBaaYbAJcehuSwZYNNfJLQNH1_g@mail.gmail.com>
Newsgroups: gmane.comp.version-control.git
From:   Igor Djordjevic BugA <igor.d.djordjevic@gmail.com>
Message-ID: <e8f63afd-18c5-0605-32f3-72a9c5650f84@gmail.com>
Date:   Sun, 12 Feb 2017 22:33:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <CAEPqvoxM9_Ku-1YgwNiqearUBaaYbAJcehuSwZYNNfJLQNH1_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/02/2017 21:50, Juraj wrote:
> I've just noticed that amending a commit from git-gui uses the time of
> amending as the new timestamp of the commit, whereas git commit
> --amend preserves the original timestamp. Maybe the two should work
> the same, whatever it is decided to be the standard behavior.
> 
> Juraj
> 

Hi Juraj,

Just to report that it seems to work as expected on my end...? Amending
through both command line and git-gui preserves author date and updates
commiter date.

git version 2.11.1.windows.1
git-gui version 0.21.GITGUI
Tcl/Tk version 8.6.6

Regards, BugA
