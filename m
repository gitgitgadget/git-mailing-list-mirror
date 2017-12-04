Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53D6720954
	for <e@80x24.org>; Mon,  4 Dec 2017 21:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753015AbdLDVyo (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 16:54:44 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33776 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752998AbdLDVyn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 16:54:43 -0500
Received: by mail-wm0-f51.google.com with SMTP id g130so16459723wme.0
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 13:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HZw5vY/OdtNCzE2zt09BR09DEDup1tpN45RITn9/VAI=;
        b=LViAW8OqAPn1dEFqCaa8sWm1OanOyjhmIRkBO2npRP4//QqX4g5XkaJFWgUXF7JSvO
         SLLHfhirO+OLnd79kaR7cQHME7VfQj/tGvIHduxyUtebWYguXrUgt3m05G4O7zcq9EkB
         ibxmBdWEGcwR9nuuVYxikQ/w5RYdp1VyoUCEn1CK/RQnh3DkRm4uvFqqm2pBP/+yppt7
         /w8woZHGs41utzrYn4h08wMpX0ncaX6oB6IYVunuSNfiT88gyLTxBoDRlZg5aMmZ5bhK
         qVtcz1mU1Xn1qSXlCrpCnqjJD8fA9KjSBLyS1PmzklgBI0zrkl02Fia5cWBWst+/TQl5
         0Wqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HZw5vY/OdtNCzE2zt09BR09DEDup1tpN45RITn9/VAI=;
        b=R2aLk9v/l0pikv6JeY/s7EgwSd+kAOReBnJvxK0ZZCXRwuTKe2+I+ZL1tOBoUEKLKO
         7O4uTNXf31pl/G5nKrT9ReVDdch2J8HYEzL/voFsre1YfrNs1Yu8uhxDyT6rn0BJB1A/
         vrjokE3vphsTD73N9ykZ8atuNdiMC9RkaLaE3URf4aG6Bf7OcMkXBSkpldy39VA/dzRI
         SeIGBPo2ABONIA785RyApA66Jzfy0KttaBrvkLrJAREJJX8Y1JplqXIqxAAwDuyDEYlo
         V1yCeAt0WiEaEXBBG4kQvtImjOrq0J2lhNS0znJ2TJibyImqjj67TMD2BUtrau/OZYrS
         1r3w==
X-Gm-Message-State: AKGB3mLQaqkxSerR/OqS+lZpfsH5y5mgSRl9CRGo3pIRw9sOsqjRJSJV
        nKOnPNAvSufh/mMVGevtixU=
X-Google-Smtp-Source: AGs4zMarPbitZI32P3b9u5lEDIz8hs5ag+qPli/EhHPrrDOLLLJQK33iELB84domfA3c9vLntHCrOw==
X-Received: by 10.28.125.11 with SMTP id y11mr4163956wmc.115.1512424482168;
        Mon, 04 Dec 2017 13:54:42 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB6B70.dip0.t-ipconnect.de. [93.219.107.112])
        by smtp.gmail.com with ESMTPSA id 186sm9512538wmm.47.2017.12.04.13.54.40
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 13:54:41 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 2/2] launch_editor(): indicate that Git waits for user input
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171204214221.GB21552@sigill.intra.peff.net>
Date:   Mon, 4 Dec 2017 22:54:40 +0100
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        lars.schneider@autodesk.com, git@vger.kernel.org,
        gitster@pobox.com, sbeller@google.com, sunshine@sunshineco.com,
        sandals@crustytoothpaste.net
Content-Transfer-Encoding: 7bit
Message-Id: <787AD800-7169-4B83-A1AD-171A15D103B9@gmail.com>
References: <20171129143752.60553-1-lars.schneider@autodesk.com> <20171129143752.60553-3-lars.schneider@autodesk.com> <20171130205137.GC3313@sigill.intra.peff.net> <BB878570-F214-4BAA-AB58-4A9C0F8F80AB@gmail.com> <20171201182924.GB27688@sigill.intra.peff.net> <aacb7604-edc3-a920-da43-701b57045956@gmail.com> <D330CEDD-7F6B-49DB-A30E-EE0BDB80E28A@gmail.com> <20171204172623.GD13332@sigill.intra.peff.net> <07CF6EAE-815E-4846-887D-560F2459E69D@gmail.com> <20171204214221.GB21552@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 04 Dec 2017, at 22:42, Jeff King <peff@peff.net> wrote:
> 
> On Mon, Dec 04, 2017 at 10:31:15PM +0100, Lars Schneider wrote:
> 
>>>> I would like to add "for your input" or "for you" to convey 
>>>> that Git is not waiting for the machine but for the user.
>>>> 
>>>>   "hint: Launched editor. Waiting for your input..."
>>>> 
>>>> Would that work for you?
>>> 
>>> I guess "input" was the part that I found funny/confusing. The only
>>> thing we know is that we're waiting on the editor process to finish, and
>>> everything else is making assumptions about what's happening in the
>>> editor.
>> 
>> I see. How about:
>> 
>> "hint: Launched editor. Waiting for your action..."
>> (my preference)
>> 
>> or
>> 
>> "hint: Launched editor. Waiting for you..."
> 
> Better, IMHO, though I still think literally saying:
> 
>  hint: Waiting for your editor to exit...
> 
> is the most accurate, which I think makes it clear that you must _exit_
> your editor, not just save and close the file.

I think "exit" would be confusing because most graphical editors (Sublime,
Textmate, Notepad++, ...) can open multiple files and do not need to exit. 
The requirement is indeed save and close the file.

How about:

    hint: Waiting for your editor to close the file...

I generally like that as this is technical correct from all angles.
My only nit would be that "the file" is a bit imprecise... but
that's probably no problem.

- Lars
