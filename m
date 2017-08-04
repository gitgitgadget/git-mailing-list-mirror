Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67B6F2047F
	for <e@80x24.org>; Fri,  4 Aug 2017 21:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752068AbdHDVFZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Aug 2017 17:05:25 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34753 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751271AbdHDVFY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2017 17:05:24 -0400
Received: by mail-pg0-f44.google.com with SMTP id u185so12269225pgb.1
        for <git@vger.kernel.org>; Fri, 04 Aug 2017 14:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=VNow7EPClNFd+DPN7sGpzy5GRBJhPp5pCqB4glq8oSY=;
        b=q+uJAntj9mGcYSKKazdrr7wbB91LCMRveCzqdwCaEoZ1HMX5tWfHpxCihzb7DQyBSW
         kvPlMonC1kXvbawRXlry2+B845LyqrXB4mCRD6+IkatGHxXZlrl634MXjAV2Tc7A+IYN
         SG2L5TrLXR1GNe6XmCoHBdBw44R/fGoAvaUV842RCHV8HaEbt6/P9UbY9BZt5x1UERl5
         8VwxO1vlTpgvADEhXeyoNLmdlErp8XuTq2Z2eDZSlxbELO2OK1mWZ/p1gOWe9d6H8sJh
         xmpbpe/x6Hb6ZsWoG/5oxWoi8UKIH9m/pDQNAfNEYKizyaftb4icLmjfD+OJNqYme3Zx
         GtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=VNow7EPClNFd+DPN7sGpzy5GRBJhPp5pCqB4glq8oSY=;
        b=FoKkRxgnfKZxTBsMmvW/G39UIz/mzPsm+m/xGBnoOPtu6pT5QQAyaDUTu7JHMgywCT
         kGc20/Ic1HMrJxBp1S9u5Blva+K7fAG+VQfD+/RmXJdSeWCqiVsz2n1Fyl+Z2Do3CYWK
         90sC6PLvKMwLjPT1I3lVGSVJcPNH2Z/ldxxdl7A9GAS7P57fYqbM9OTuka0HRX0Do5TV
         +qHwiGR/u0SUJbTrUKKUcW2NlJi0ajgneoYqVk/fu2gj2aJg1/SNZn917joLf9n/OB3d
         I6DkKp9HJV87NPT61zFwT2oQcPP77LeAGUsaV0ciXq4ltb8dNqZmwyzEffnwUnsLmkl5
         vrbg==
X-Gm-Message-State: AIVw110hsPG9IoXjmtK6JSo5BODehphWHdcCrkwB50dl73txIqyezoZc
        0ONH96wEgGoWqeugBWFwcoS+gVyjKQ==
X-Received: by 10.84.217.93 with SMTP id e29mr4316809plj.472.1501880723700;
 Fri, 04 Aug 2017 14:05:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.160.172 with HTTP; Fri, 4 Aug 2017 14:05:23 -0700 (PDT)
In-Reply-To: <CAAM6cWfYfpX+8iK+SH=ukPutB18UAafXOZ3fuKQBiQ-4arp-8Q@mail.gmail.com>
References: <CAAM6cWfYfpX+8iK+SH=ukPutB18UAafXOZ3fuKQBiQ-4arp-8Q@mail.gmail.com>
From:   =?UTF-8?Q?Bj=C3=B8rn_Erik_Pedersen?= 
        <bjorn.erik.pedersen@gmail.com>
Date:   Fri, 4 Aug 2017 23:05:23 +0200
Message-ID: <CAAM6cWenBUL6rNva+KmwnPhUwzGZeFs53=N8yOkyyTXOmXC2jw@mail.gmail.com>
Subject: Fwd: bug: contrib/subtree: Commit message title should be in
 imperative mood
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I.e. "Squash 'somedir' changes" and not "Squashed ..."

See

https://github.com/git/git/blob/master/contrib/subtree/git-subtree.sh#L463
