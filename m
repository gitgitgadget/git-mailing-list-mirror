Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7240E202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 18:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754116AbdCHSqx (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 13:46:53 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33765 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753941AbdCHSqv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 13:46:51 -0500
Received: by mail-pg0-f46.google.com with SMTP id 25so16267676pgy.0
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 10:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5PpzEfnD+bS0v3SzbVbOeabT8B4bm2uLPOv9y0kSgI0=;
        b=if/u3h9NgdMTDlG36lnYdFkzjaKaYKftqEZmI175xT96ocdgDL75TN7HgPXRGxhHE6
         JxYIo5QplJHige45tZPSYfCd798i9jwQ2Tqwx6wlj+EGtKd7KeHV4jxBfswsWD+h+YwD
         pURzTlmJWByeMMQGV7zjLKFhjn+0aDJeAsmCkFFFRbS1P9JoihtUc/AbVwdfaSCsuw0k
         203FBcRdbvbLygNUqLOaGyYl06JpsLeMLFxeN0Kq0hYE2PLnUoAv0qoN8G9kfvwVZjXj
         TfelvC4DVPDf9fP2p7SezpyPKZiyTlRmj6G84uhzwr1yS2WEaepAidA85HHg02GeDczi
         Qsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5PpzEfnD+bS0v3SzbVbOeabT8B4bm2uLPOv9y0kSgI0=;
        b=QCQ5h/e4uUf79AL9YakMk1oyojnTwpAEM9xXkifSAyEPBHfB84sV9ya88BBpqSF1w4
         Rc5X4aaqTsYNInWwI36hTMZs469tEJftcpJnSFhDsUzw3tzCYBlNI9cumHFIo+cVEdcp
         zUp60+ZRbp4of6GAVmQeMnXcQpwQFk8f+l9CiKI+k29hQFLzpxDDXQ1ZJASxKJ94hAZ1
         8eoVH7hVwS67fBA+QdzOgaSDuzCdR1LgdUPCBWPWbIF+MEeAXzKivd7sZMcaDPhroinY
         JbII/623uQN0xL8xQfSmCyCN3hY44K/YtDd8Pf+bXxHDS6jj0jD74G4l/EcLTBgAMB7b
         E+1g==
X-Gm-Message-State: AMke39l46uhSwEEIC/4vUeRRM3m+7tq9ZxbDOVsCBFYCIbeRknAUnboe9phXM6gvI6wpr/j6
X-Received: by 10.99.147.68 with SMTP id w4mr8895570pgm.32.1488998768789;
        Wed, 08 Mar 2017 10:46:08 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:cdd8:47c3:cffc:85d3])
        by smtp.gmail.com with ESMTPSA id p66sm7601922pfb.88.2017.03.08.10.46.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Mar 2017 10:46:07 -0800 (PST)
Date:   Wed, 8 Mar 2017 10:46:06 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     valtron <valtron2000@gmail.com>, git@vger.kernel.org
Subject: Re: Crash on MSYS2 with GIT_WORK_TREE
Message-ID: <20170308184606.GB130604@google.com>
References: <CAFKRc7y_kpCGNORENUZ2qw_4qBwjjyaaDFxAEQa52fTryj+w7A@mail.gmail.com>
 <alpine.DEB.2.20.1703072345530.3767@virtualbox>
 <alpine.DEB.2.20.1703080104580.3767@virtualbox>
 <20170308020918.GA1650@google.com>
 <alpine.DEB.2.20.1703081254480.3767@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1703081254480.3767@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/08, Johannes Schindelin wrote:
> I did take a quick glance, but did you have a look at the time of day I
> sent this patch? You do not want to trust my judgement after that.

Haha Yeah I did notice, and I trust your newer patch more than the one
you sent at 2am :)

> 
> Another thing: may I ask you to delete the quoted parts of the mail that
> you are actually not responding to? Junio also often simply keeps the rest
> of the mail quoted, and I always have to scroll all the way to the end
> just to verify that nothing more has been said, which can be slightly
> annoying when you are tired. I do plan to read your mails in the future,
> so culling the quoted-yet-unanswered part would save me trouble.

Of course, I usually try to clear the parts of the mail I'm not
responding to...though there are times where I forget or am a bit lazy.
I'll definitely work on remembering to do that for the future!

-- 
Brandon Williams
