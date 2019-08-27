Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF0AF1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 10:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfH0K7Q (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 06:59:16 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:41222 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfH0K7P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 06:59:15 -0400
Received: by mail-io1-f45.google.com with SMTP id j5so45222673ioj.8
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 03:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tegQCOxpnL4ICa7NoqAz0iLrgdL4889cyyZ2AdGI5PE=;
        b=adioWtZLhTAuKaLXI4W4aPb8GVteodeGT+TXkfk/zQNHIJl7VJhR3pfnanm4La6Xkk
         k+2QtFK0eC+Gt1mTZpKgwqxhMMz/AvOxLD2DB5nbIRUommCv2mMPQIvIRVjBRFOGv4GZ
         z9ulLDD8cC8PdpuxHOquPGvLNwLpC3FXp9NOTl08v+uSobIC0ZGnskVLVbcVnBzyo2cu
         cuymari+qaJLCZWFdmKINFCMuLy8Xeoi90Glvdef9FMHMxeFYo8nhvcGUoLbiwBaM9Ea
         /luyuDWIvL8wP9fVXhispz51E1QCc01P12Yn4ow6RFpuGw4O0yBs3LfdJZNNHNphGVw2
         x+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tegQCOxpnL4ICa7NoqAz0iLrgdL4889cyyZ2AdGI5PE=;
        b=goNUgKraklXMKpFL8MUzcMRnY8QYGIzSWpjravQv+u8WktkXE9ZVtuH+f2pFOQ99QS
         jZi6XwaUvHzuJoWBAugNsV9uN+lh+NdZTr8ewgAW06Kgs8/dcMgFr5BDa5Ukpuzgacoq
         2vHnQfLhT/HoICG0ZctmvS2hvWDaVjbxlPmlsNo1JePmBt4ENYWncQdUV4dLGTNIU3lh
         UkzfVq5mmRpXwJ+bAjSr+SqUM4JT9XTlSSpOkf1WRLamfdCfXRdyXU6I/WzeL/tRh3I2
         1n7EJ1eqpt8h5DWppIBrpVK6szS/L6b9sYuZQCGOABx85RNwhHO7v62gsoeZzphMAims
         rpkA==
X-Gm-Message-State: APjAAAUzTioajQMpkjsEHPJbiYb6mpyN303haYb/2XS4DXs2iFM0kD5n
        OzsRKYsFuFWqTJbhXct4JPteWDFfoh4wNr+1QK3qzw==
X-Google-Smtp-Source: APXvYqy60z3krXM1OLPKRlJJg9NMc45wYZJH+NhUYYni4uiUimIn5HjwQtKgz4T/p+SG2jFMtv+gprjSRcxqAf83B7A=
X-Received: by 2002:a6b:c98c:: with SMTP id z134mr29723722iof.276.1566903554887;
 Tue, 27 Aug 2019 03:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAObSod2jhDjq=Fw2JtNMsK53HxXSf3n6K5XacHQBH00L49mNpQ@mail.gmail.com>
 <20190827103653.GB8571@szeder.dev>
In-Reply-To: <20190827103653.GB8571@szeder.dev>
From:   Konstantin <kostix87@gmail.com>
Date:   Tue, 27 Aug 2019 13:59:03 +0300
Message-ID: <CAObSod1tMmLVNciNL_C4i_Xb7VQPwWc0uJtzLc0tntZF3KH2zg@mail.gmail.com>
Subject: Re: How to split file with its history?
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

thank you. your answer is pretty complete.

On Tue, Aug 27, 2019 at 1:36 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Tue, Aug 27, 2019 at 01:10:02PM +0300, Konstantin wrote:
> > currently we have one code file with deep history.
> > As code file grown it is necessary to split it.
> > but this action will drop history for the new extracted file.
> > how can i split one big code file to small files and save its history
> > for the "blame" action?
>
> 'git blame -C' can detect lines moved between files.
>
> https://git-scm.com/docs/git-blame#Documentation/git-blame.txt--Cltnumgt
>


--=20
Best regards, Konstantin Kosukhin
