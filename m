Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BB5720282
	for <e@80x24.org>; Tue, 20 Jun 2017 17:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751038AbdFTRFs (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 13:05:48 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35680 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbdFTRFr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 13:05:47 -0400
Received: by mail-pf0-f172.google.com with SMTP id c73so11957360pfk.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 10:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vPkD5mQS0fHCUZa+nIGD/JMFK8Z++GVr3hZbsCKpfbE=;
        b=CrPJHNTIypkWMDdPT3Dn8v5eaopERXPML6VwsEUxqCZLQ4VdB6lSQ97OSRf7Tnlw6/
         p2GeielYjF3BjLsjQubRH90gKMRBSPDPJr0M2JwNM/WSm/FXoygDrVLJsy43nDUMZmJg
         iYlL38l+jTGf/pGdmULC2/pM52zKdgcvVu9E2/+F6v8mgYDRJedD3qDJtvPE2f7kkJG5
         ym2aUZx/CEyUlDXqY2MRXshJSMlSOZlLQLbaRUruasEd6Oa7hu1ymiogvmN+1IdA/olD
         f5t/dytw6RTZWzZ+iRLCocZjwtLfeC0+YDkQwKR1obPaIbH5gVzSSDBENKQjJC7lIPIR
         sXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vPkD5mQS0fHCUZa+nIGD/JMFK8Z++GVr3hZbsCKpfbE=;
        b=Qg2nArjk0x6ayDHxcRUmHemFQQty42eN3JffhLxyk0f0OA+iDFtYe0ySM0M+xMhzcC
         JpLxqBFd4G1/RwAp/Nw5sBST0loE9xJ4HhWgyEKbPeSThETdQiNMfQFjHjTSDy1ClzM0
         r6+QamvQtij4wJK4LpBXbgoHG7Ssojl3jdRmY45WBif9g2+TYzAm5xaqy3CXQGcZ4TIt
         tUa15vRj/Gq7NabBdU8kdGQzRj2lwTCQP8lHw/8AHUppmgya/JurJgRhBm/2WJ0wuked
         hsvz/F7mL/EfeReKBJuV54xC8RkMIfkp8yjQyTS3mBnbXCBFA83ksPOkovqzWvtOodf7
         HW6g==
X-Gm-Message-State: AKS2vOzuJ/P2mPhLF909R7ix3VtEs1Vo64bvBNoJp33mR9z1tF29OTIZ
        VdtdPM2Yj/T9oW+gBidonoROr3/GTrAW
X-Received: by 10.99.141.76 with SMTP id z73mr12634261pgd.40.1497978346293;
 Tue, 20 Jun 2017 10:05:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Tue, 20 Jun 2017 10:05:45 -0700 (PDT)
In-Reply-To: <CAGZ79kbJx4p2y6Vjp3dVBP2pd=MYa_j3Mxfv=zUygHY-bHj0wQ@mail.gmail.com>
References: <CAGZ79kbMhQpxUa5TXK=WCzzKUCZ5vx3oC+fFTTozpgQihsUjTA@mail.gmail.com>
 <20170620031214.7616-1-kaarticsivaraam91196@gmail.com> <CAGZ79kbJx4p2y6Vjp3dVBP2pd=MYa_j3Mxfv=zUygHY-bHj0wQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 20 Jun 2017 10:05:45 -0700
Message-ID: <CAGZ79kbJB8dFUYu_70TAYbFWxLQiACEWMrE8M71GSEpnXqqzQQ@mail.gmail.com>
Subject: Re: [PATCH/RFC] Cleanup Documentation
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2017 at 9:57 AM, Stefan Beller <sbeller@google.com> wrote:
>
> With or without this nit addressed, this patch looks good to me,
>

Well actually not quite. The subject (and commit message) is very vague,
maybe:

    Documentation/git-submodule: cleanup "add" section

    The "add" section for 'git-submodule' is redundant in its description and
    the short synopsis line. Remove the redundant mentioning of the
    'repository' argument being mandatory.

    The text is hard to read because of back-references, so remove those.

    Replace the word "humanish" by "canonical" as that conveys better what
    we do to guess the path.

    While at it, quote all occurrences of '.gitmodules' as that is an important
    file in the submodule context, also link to it on its first mention.
    (This paragraph is not exactly what happens in the commit, but I wrote it
    as a way how I would write commit messages. It shows the reader how
    you addressed the given problem, with the quantifiers "all" "the
first" showing
    what you think is important, and that you deliberately omitted others)
