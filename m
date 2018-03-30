Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E826B1F404
	for <e@80x24.org>; Fri, 30 Mar 2018 21:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeC3Via (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 17:38:30 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:33368 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbeC3Vi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 17:38:29 -0400
Received: by mail-wr0-f171.google.com with SMTP id z73so8941367wrb.0
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 14:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=F0kI9bW/Mge5b3Jl2T8LOI6zidl6HiQ+qZuif5sY1fQ=;
        b=HwEDqSvVcmFRVGUIrsUBkqARPXh6DM3DsL3bsRZeP+pzfdWjIgnszidQ2KyzHXUh8j
         OrMNgo/S4sWo9DIZtKv4xBGxSa52b+T09nDmZ+zcnB4ux62pzLvUO/cjH4ZqgQk70JV1
         G+Czl/GzUD04dkQjNb9aCSk62BqCkTLaboGjokWh1Vpjcyml/ay7Llwrz6AonlH/u8qE
         eczV31Xwk2HB4U6afUPT+kYzDhI4blxO/vEi5cj5nSSzdwAejHaLqDgknxxyFrN+1ZJT
         6rSsMUccKNM4nrqNSBDM6h6yXjCOjoh2muDnIbYRx7m7K5J7z8xTzojqlA3Pkq29QffW
         3Ftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=F0kI9bW/Mge5b3Jl2T8LOI6zidl6HiQ+qZuif5sY1fQ=;
        b=DSKxS8i4r+NAUcxmzattjwiFPkyf5Fh7zQ3DLOQ/OorrD9+7+9zE0quDw0KLMJTwiM
         cuPVqy9Oe52BheBA9+xaqlPqymMqOePgeVoIbC6nbaTuVTSsERc9usQ/Ih/CUh/JNMxl
         DhYVMiHHuXiVirYEbtvSMlBuEZoc+SsD7yvVJEjWtEl7EL+XedgSpl/Lhsu/B2YWey+L
         iLWFcrluPBy0qsZhWPM5qAxXx8qMLGK/ENPyXMXIpX+YlV+f0PX6E7LIBSQHTJsjP2O/
         QmWipeRo8oChPAhMe+ZC51kQ/YcU/78W1hrFf8QdMMKeJe+ijbs3wRQiAGSxmZz8BtPD
         dwSw==
X-Gm-Message-State: AElRT7EZyly6W+yDfAlC8xRhsAFZMaD27Qj9Z/Sg1pbDYBEJrS6lxnmV
        +XmXFH+ZeG58m0lCx63tUDZw2cHj
X-Google-Smtp-Source: AIpwx4/9M3hVCmHSNvsfvlEDrCLgsMu/YQwFiDxM3xfuiMedifNpHRauxWN0YzFr7hvCvpfCZuXKCA==
X-Received: by 10.223.173.3 with SMTP id p3mr348507wrc.202.1522445907913;
        Fri, 30 Mar 2018 14:38:27 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x22sm197354wmc.27.2018.03.30.14.38.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Mar 2018 14:38:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2018, #06; Fri, 30)
References: <xmqqvadd1epf.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 30 Mar 2018 14:38:26 -0700
In-Reply-To: <xmqqvadd1epf.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 30 Mar 2018 13:38:36 -0700")
Message-ID: <xmqqr2o11bxp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> --------------------------------------------------
> [Graduated to "master"]
>
> * jh/partial-clone (2018-03-25) 1 commit
>   (merged to 'next' on 2018-03-28 at 2a0a7aef8e)
>  + unpack-trees: release oid_array after use in check_updates()
>
>  Hotfix.

Not listed in the above, but this round also merges the hotfix
c7620bd0 ("upload-pack: disable object filtering when disabled by
config", 2018-03-28) from Jonathan Nieder that makes sure that
"uploadpack.allowfilter" does disable the feature even when the
client makes an unsolicited request to trigger the "filter" feature.

It is not (yet) clear how I screwed up this report; sorry about
that.



