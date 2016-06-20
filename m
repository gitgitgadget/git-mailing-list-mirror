Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 131891FF40
	for <e@80x24.org>; Mon, 20 Jun 2016 16:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366AbcFTQqm (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 12:46:42 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34472 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003AbcFTQqk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 12:46:40 -0400
Received: by mail-qk0-f177.google.com with SMTP id t127so47929986qkf.1
        for <git@vger.kernel.org>; Mon, 20 Jun 2016 09:46:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AKnAtq/43cBdQxyO4dd12OmYqyH5eY/YDl5LyqQTToQ=;
        b=AnlgYNSR3GXnmk/SDjps5bZWm1PHi/cU3VV9FLZD7EIdetgsHGTTzuyz3Pv6Bsw9ug
         HMUwE6D+yUe3t5PJadK5NAgro5fEhnsR3bfuDBGAHgAk+TYBE/7cFHkk4TQ1UCaUxLwl
         0jd/q/hvankugBahhDOn6nh/HrOMf767N3lPh66UNwrxhK4qIEr0oZKXhrdsINL9UKSL
         Ub+CmIVs1Sq5/qgPdKWLi2RxCthvxXIS4hHLuxHwrihR2HjWXH4qbS3nEwFb/sSWfsb2
         ldiOVRvZEvAAIwZ+PigyWB6/SP+ub1Wy8SfYaa9dE5XeJ2BuotJMpdt3PEPVvtDa7MTW
         D2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AKnAtq/43cBdQxyO4dd12OmYqyH5eY/YDl5LyqQTToQ=;
        b=Jm6ey61K8TgNymQ+U9hA1ZII9GMvzXKSfIylpFsAbX5vhEugFvOn53EybGDUrYu1Y6
         Qo+YqhzBR4dNyCVWAbAv8GTte02qh2XDMVkCPT/y1x20XwKM61NW7ScTrYvSSmb+tl2P
         160KrabX/b/QiZxqBp9aIG05JyGRIsg8Rv0c8AKotgv4qD33Riaw2TieBBbm7TU9teK+
         ZdfeygWv8plRbTW30wJF+oq7B6usThkDf1VmkCnPxaJ8i+OH6HFTf2hA9WZ4WqoVxNUS
         k/NV2XlJvitTYmp5vLI0gMVLx12HSPkcfHZri0h5jHvedZWZY3JQWtG9Zm0ePjdiPozq
         lN4g==
X-Gm-Message-State: ALyK8tKlfqeVMPufGQlTnOajm3XhDOQ/Mocw7StgejQUp7jg8P9hJ9pVoXNJDND2RwOq8+AQJJgdswvrkOqrsbOE
X-Received: by 10.55.10.147 with SMTP id 141mr23433064qkk.91.1466441163391;
 Mon, 20 Jun 2016 09:46:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.42.226 with HTTP; Mon, 20 Jun 2016 09:46:02 -0700 (PDT)
In-Reply-To: <xmqqh9covlkb.fsf@gitster.mtv.corp.google.com>
References: <xmqqh9covlkb.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Mon, 20 Jun 2016 09:46:02 -0700
Message-ID: <CAGZ79kaHRz2GZN4FmQBA1wz4FhBWDwVifWX_bN09TAHAxF-wQA@mail.gmail.com>
Subject: Re: Short-term plans for the post 2.9 cycle
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jun 19, 2016 at 3:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Here are the list of topics that are in the "private edition" I use
> for every day work, grouped by where they sit in the the near-term
> plan of merging them up to 'next' and then to 'master'.
>
> These will be merged to 'master' soonish.
>

Thanks for such an overview!
