Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6084C20248
	for <e@80x24.org>; Tue,  9 Apr 2019 19:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfDITSf (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 15:18:35 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:36206 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfDITSe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 15:18:34 -0400
Received: by mail-wm1-f42.google.com with SMTP id h18so4642729wml.1
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 12:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OqqvvD1IWaDXbfo7rRfT9aSg10mvgP4NZj7fWwNCEhU=;
        b=qzQEtWapqcrjOv+8XkkaGRG5AR4EiYoOy/SqkPILf+N6j/h0LM9d018qWJ1VahB7dF
         6aEZwqA6pTQQFftdunrvu4L0/RvjNu9TH1CMfw9vY3pDvODb2g9iwNrXXO55wtwxxGOc
         ix5SWSuZ5C6t28+Jx+Scxa8rcdFSEMn4f8AXgYD25jz3/sn2oa8WJOkCOaugKkWRxT1j
         zf8EOE5Ba8NaYAR2q8FwiznEky/Osr6gXOT90Lz4INqo+hC1VLhnG+/40VDFDbuLPB4/
         9fmBZjJuaPN/IxhTmgBqBg65PYp692geBkCkbKhmYfeAqiDlsZZbIFFy6fF1rjx9qF1O
         /j5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OqqvvD1IWaDXbfo7rRfT9aSg10mvgP4NZj7fWwNCEhU=;
        b=KktzKup3TMTSBzZPlVb/5Kc5/QPRs/VGN1brAYOugRnu6/Of71U0eYv40+wC/sduWu
         yxz22bCOklELV0MV/TX5LBUQsDF4DsJjDPxLXitrOUtVQ6uLhQWybUIqgp86V/dSSsJ+
         q5+pBLFbDwrwIgSrmMPZx1ND9XBf8xRQ9v/nsH5WArtQl2MrX/Ebe46F7Q0MnZCtT1vi
         XaMgg/LjKQf+sVOd8nOlrJqu8P2Bv08Vr9ue4RunABLvZLlkiT2SYWgVkk27blld8Hsq
         6vc/3BbY0EM99Ts8WJvimY5MK8SejH4barEy9kj3FO5zwQfPjNQsxKK4YFZBjCzn6I6N
         zPGg==
X-Gm-Message-State: APjAAAWbOLhJIcprUKfnO5zh2/YrxNJIAHK3RwFhKooaLYNFzW7liTn8
        RFK1l3kT4AKtv1pBIvD3RjQ=
X-Google-Smtp-Source: APXvYqyi8gW3qoveD6yW4h6OBsyO3qHeTkftaXmcMPFNRjJk+1TIPEo09T37NIqV454qo/7vk6qpRQ==
X-Received: by 2002:a1c:1d49:: with SMTP id d70mr23085173wmd.36.1554837513016;
        Tue, 09 Apr 2019 12:18:33 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id n6sm24478407wmn.48.2019.04.09.12.18.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 12:18:32 -0700 (PDT)
Date:   Tue, 9 Apr 2019 20:18:31 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2019, #02; Wed, 10)
Message-ID: <20190409191831.GC32487@hank.intra.tgummerer.com>
References: <xmqqr2ab2gs6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr2ab2gs6.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/10, Junio C Hamano wrote:

> * tg/stash-in-c-show-default-to-p-fix (2019-03-21) 1 commit
>   (merged to 'next' on 2019-04-10 at 9489a31a36)
>  + stash: setup default diff output format if necessary
>  (this branch uses ps/stash-in-c; is tangled with js/stash-in-c-pathspec-fix and tb/stash-in-c-unused-param-fix.)
> 
>  A regression fix.
> 
>  Will merge to 'master'.

ps/stash-in-c is still marked as "Will cook in 'next'", so I assume
since this is fixing a regression in that topic, "Will merge to
'master'" is a mistake here?
