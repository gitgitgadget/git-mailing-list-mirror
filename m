Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7C9C1F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 09:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388447AbfJDJov (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 05:44:51 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:37216 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388388AbfJDJov (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 05:44:51 -0400
Received: by mail-wr1-f42.google.com with SMTP id p14so5375782wro.4
        for <git@vger.kernel.org>; Fri, 04 Oct 2019 02:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eNV6YMAvcBg051r967is4Zxq1NyOK9ePuiZ14oTwjjw=;
        b=k9kqXbMIkkkVsj1wL8bP22Ufg8Srh7CO3YYABanNBX4J8f8nrxyc9Urnjxjliz7/xS
         ogeJ2k838jW+yS8tJgpfvPemxX5yzP6jJOcR5SbjSFMIDiTfqzQ3eXpBHI17uyJa0Snh
         GT1vcLTeF5mZXOF9HhMum4nt7U/BMgYV+NRWnl9RQHkC9kMk5yJ3nqykw9AU3sTxjvh7
         w8PeduRV5E+P1pQl6cZmTxfkwBzDEj2iCKJ5hECzBXr2YPOnnPPe4RcVPd2/9PfSzDSf
         WW5huFbLgmjJEO4BYEJUvwGcQYsdzVv578TO1Z+Slj1xBNUHPXH9MfoiqWvV0sWfPXme
         TFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eNV6YMAvcBg051r967is4Zxq1NyOK9ePuiZ14oTwjjw=;
        b=qK1HDa+0SkBA/45Vm/Lnlv2DdSCyEGgh18kqE9v3WAOP0ndFkAJes9OYm3bgWuANJt
         s9uJzGJlAZ3pPJlUOFurmHuWEoov1wx45IjBI0NoJMejLCEInhHA7bwyQg5x/fO6lYMp
         O5xvjF+d7Jha2QJeKHBBL0aOvjjleK69JnG6NT1hJYVd0Xyuw9eGuu2Q0Iy8v3aw7ehD
         D/Fkfw9Apear0DwJQFoD3O/4cT5j1fvbhcb/Difo2AZ37Xcf05FQjFMcTERCHTPZQzMr
         I62R9sY2W8e+ubwg6GEaUKfAUuUpK3jKHusDbO3OvacnHoEi/L0Ey7FGPeEB2QIOSl+J
         WBVQ==
X-Gm-Message-State: APjAAAXSQTstaYmDEh0GUPXHrqZUNw+meReV1mpJBEp+8uCmGv3dTMdF
        KaFWFQGXSThi9qpgSL5JJsOymQrZ
X-Google-Smtp-Source: APXvYqxOzJWXxCp9T/XLGB9+HBvjcIO+rQnjCMdGiYzVqERG3ZmraE5NrfzKR8aSE40HOJ7ZO3fSJw==
X-Received: by 2002:a5d:540c:: with SMTP id g12mr10775138wrv.207.1570182288875;
        Fri, 04 Oct 2019 02:44:48 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-28-119.as13285.net. [92.22.28.119])
        by smtp.gmail.com with ESMTPSA id r7sm5559489wrx.87.2019.10.04.02.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2019 02:44:48 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Oct 2019, #01; Thu, 3)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqsgoabes8.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <972f4674-ed00-7113-24eb-f59f1b751690@gmail.com>
Date:   Fri, 4 Oct 2019 10:44:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <xmqqsgoabes8.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 03/10/2019 06:04, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
> [...]
> 
> 
> * pw/rebase-i-show-HEAD-to-reword (2019-08-19) 3 commits
>   - sequencer: simplify root commit creation
>   - rebase -i: check for updated todo after squash and reword
>   - rebase -i: always update HEAD before rewording
>   (this branch is used by ra/rebase-i-more-options.)
> 
>   "git rebase -i" showed a wrong HEAD while "reword" open the editor.
> 
>   Will merge to 'next'.

That's great, thanks

> 
> * ra/rebase-i-more-options (2019-09-09) 6 commits
>   - rebase: add --reset-author-date
>   - rebase -i: support --ignore-date
>   - sequencer: rename amend_author to author_to_rename
>   - rebase -i: support --committer-date-is-author-date
>   - sequencer: allow callers of read_author_script() to ignore fields
>   - rebase -i: add --ignore-whitespace flag
>   (this branch uses pw/rebase-i-show-HEAD-to-reword.)
> 
>   "git rebase -i" learned a few options that are known by "git
>   rebase" proper.
> 
>   Is this ready for 'next'.

Nearly, but not quite I think cf [1]. Also I'm still not convinced that 
having different behaviors for --ignore-whitespace depending on the 
backend is going to be helpful but maybe they are close enough not to 
matter too much in practice [2].

[1] 
https://public-inbox.org/git/20190806173638.17510-1-rohit.ashiwal265@gmail.com/T/#m965ce1f09d1d1b8010c04db0eabd4b19ce99fe82

[2] 
https://public-inbox.org/git/20190806173638.17510-1-rohit.ashiwal265@gmail.com/T/#m94e059c18b7bbcc721d12b190bd4aaecc5e8d591
