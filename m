Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93F1F1F404
	for <e@80x24.org>; Fri,  7 Sep 2018 17:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeIGVur (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 17:50:47 -0400
Received: from mail-yw1-f44.google.com ([209.85.161.44]:41206 "EHLO
        mail-yw1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbeIGVuq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 17:50:46 -0400
Received: by mail-yw1-f44.google.com with SMTP id q129-v6so5635573ywg.8
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 10:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x7vhx5c5tm292H5XrHLEUA7o/CbN801+PNgJJQ0CEh4=;
        b=X7lfjKlAn6Zphg43xQmlWF2vpNnTFrIhsG0W0BhEQhPdHY6ardyCDoZaOdHVUz/X3E
         8ugofJy8Z/aHT2QAECT/N8s24+QMDrCDnbm1etRO5rWp82PUTexetddnlpwE+Xg+BTw8
         98Hmio6thmT+1FFpH8Sqalo/rzPQiDbRMTfvZTFWLqzvBXIhuD2vqb/NDGob+Sx/Uy4f
         OMzWqU1uFke1s6e8Yb9fann4tC/B8ATHy29+0Ue8u5lQPNbJfqrfhtESfmG1oY6z235m
         7KC3irjplf2xQpd/pmDqwBVRL5C/llBROmh0K4rjSMPWcnd7Ge7Pr3oVZsZg1oa2/7YG
         ECNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x7vhx5c5tm292H5XrHLEUA7o/CbN801+PNgJJQ0CEh4=;
        b=fJKUSHsBl+AIpVFICcPcq2i3/F1t69i7SXX/oh3dCcrlqwbwLAXAu+QjupAJYi7WVS
         cOw+kR8SS/pzxmHF7LZLs3UBN+/I7XijifEXDSXSmhXsaVyTuA668WSlAyghMeJIQ6ik
         uzHYN69YvTira/V9ECdp3xUDhEgtZ9Buyea7ShDc2xSq3jZkflI8bxTmFWyF+8OyG46J
         8lzGPFOiYws+viiFSNDK9Aa5ynMS+LWHdBpsyqRcoL8QMw40jd4hYOB0xTx2jx8ibZ5z
         vEWosmxNMn15Zl7HYuMzotqgz3JHgMPdA7q8/HR4Y5TM5tbI9x0WePutS4aGzDDlivBq
         +1vA==
X-Gm-Message-State: APzg51CEa4u+9xK9cRFyP/MPbzpmnOKT2u7rZp35o9ekUQ/jaw4Z4A5/
        wX/PI3JiYdYidkfJiMpPM1kGHqLhA23StDNT65hrvg==
X-Google-Smtp-Source: ANB0Vda069QFqweGOk+r8jM7B0qTH+ixmFHAKc3W8YlbRwCZL5bnKTxOcHxgnQ/ZvYAOrGFbQyRVeMCb2j4nRCElp/Q=
X-Received: by 2002:a81:a115:: with SMTP id y21-v6mr4598442ywg.178.1536340134297;
 Fri, 07 Sep 2018 10:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <2659750.rG6xLiZASK@twilight>
In-Reply-To: <2659750.rG6xLiZASK@twilight>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 7 Sep 2018 10:08:43 -0700
Message-ID: <CAGZ79kaVQ0T=acpviOoD+8XVxYsefNkO7c5d+d0Wc0iCbr2Evw@mail.gmail.com>
Subject: Re: Old submodules broken in 2.19rc1 and 2.19rc2
To:     allan.jensen@qt.io
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 7, 2018 at 2:53 AM Allan Sandfeld Jensen <allan.jensen@qt.io> wrote:
>
> Submodules checked out with older versions of git not longer works in the
> latest 2.19 releases. A "git submodule update --recursive" command wil fail
> for each submodule with a line saying "fatal: could not open
> '<submodule>/.git' for writing> Is a directory.

Can you run the update again with

    GIT_TRACE=1 git submodule update ....

and post the output?

I have the suspicion that e98317508c0 (submodule:
ensure core.worktree is set after update, 2018-06-18)
might be the offender.

Could you try reverting that commit and check as well?

    git clone https://github.com/git/git && cd git
    git revert e98317508c0
    make install # installs to you home dir at ~/bin

and then try again, as well?
(though bisection may be more fruitful if this doesn't pan out)
