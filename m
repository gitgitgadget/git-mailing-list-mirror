Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73FAD1F4BD
	for <e@80x24.org>; Mon,  7 Oct 2019 06:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfJGGWU (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 02:22:20 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40666 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfJGGWU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 02:22:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id d22so6363738pll.7
        for <git@vger.kernel.org>; Sun, 06 Oct 2019 23:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=GlBRtcGmCS+cYjDI5NslHKECaqVXaRm+qPTuhGmwocY=;
        b=qRswgDUwB4FixowDrJ1PCsbnUTPjWvMyZ9BM0cO37ZUlqcqjoWgiCgJQ1susC17W0B
         9P95h9rnsdcrJMdbubyWfPKGOIYLw0Ypy0e5QNA7cHwIqHXOIf4nLTv04KvksJ/ALH8D
         DtQ5/fnTPt+5GYOn+8p+zUvq+/Y8qSGwuvPSNcJtPi+EAda80nkaA5P2aR7sBIi2Mf5m
         La4rqM2+8Ha4x3dEZjIqZ/Nvz2h3GLd8MoISHYqBBreBDa6kuIPzVdvUW0X2g0QMypZj
         AAmbohGNDOM8Jgt9IPz559gMWFSb7uBSZ1TBKoPFLlufjFf9iN7pl6lB5PQv/jfSn6V9
         UXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=GlBRtcGmCS+cYjDI5NslHKECaqVXaRm+qPTuhGmwocY=;
        b=QGW73VMNwF+nOaCFlgSF4IH5P0vKx2bOx18GjGKD+QnWnCCFtHZ+Kib73h64XVjA05
         yJMbKNIZRxgXYe2GxRWXbEPzUZu3ahiV72gfgvatrnHwYeamcIgmBQc+RF2hiIOeIJeB
         H5otCEESOKEC865qzxJbjCUmRixE9f75a/derp5FNIDlfcMHdjB//Jw0x+RtWTUXl7k5
         qeDo5yL+QKCpWOAkkFybf8ehQ37ITw7k+ErrVGaJD+hd46e8wyLv1sQrMYvizdYuDOz+
         uA/3wqqZp7JKtgD5nIVGeH1/t369kTcH1KE1daMWMzsirH3Ak8CEiJwapZpZBMZnH0GH
         qOCg==
X-Gm-Message-State: APjAAAUkugSwgKgCUkRBzZ41XGeFDQPkobny33Self6z8lHcaIdY0bCo
        DJj2kbcM9UvAY4qAId/FIr8=
X-Google-Smtp-Source: APXvYqyVyYgHo8JFa4wS/4pMrXNZb8r6iFmcMrh1RgDIrdZ5iLmKj+S8XmZaPebQudxzwZJlEtemcA==
X-Received: by 2002:a17:902:d691:: with SMTP id v17mr26660020ply.318.1570429339128;
        Sun, 06 Oct 2019 23:22:19 -0700 (PDT)
Received: from ?IPv6:2409:4073:2018:8b24:a6db:30ff:fee2:b535? ([2409:4073:2018:8b24:a6db:30ff:fee2:b535])
        by smtp.gmail.com with ESMTPSA id p1sm17179697pfb.112.2019.10.06.23.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 23:22:18 -0700 (PDT)
Message-ID: <e71835129c0628ff3b9a0653febc3737128fa23c.camel@gmail.com>
Subject: Re: [PATCH] Feature: custom guitool commands can now have custom
 keyboard shortcuts
From:   Harish Karumuthil <harish2704@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>
Date:   Mon, 07 Oct 2019 11:52:14 +0530
In-Reply-To: <nycvar.QRO.7.76.6.1910061054470.46@tvgsbejvaqbjf.bet>
References: <01020153c22ab06b-e195b148-37cc-4f89-92f3-f4bed1915eb9-000000@eu-west-1.amazonses.com>
         <20160331164137.GA11150@gmail.com>
         <CACV9s2MFiikZWq=s8kYQ+qwidQ=oO-SHyKWAs4MUkNcgDhJzeg@mail.gmail.com>
         <CACV9s2MQCP04QASgt0xhi3cSNPSKjwXTufxmZQXAUNvnWD9DSw@mail.gmail.com>
         <20191003214422.d4nocrxadxt47smg@yadavpratyush.com>
         <nycvar.QRO.7.76.6.1910041046000.46@tvgsbejvaqbjf.bet>
         <20191004120107.kpskplwhflnsamwu@yadavpratyush.com>
         <149a83fd40b71896b134b16c2b499ff472c6234e.camel@gmail.com>
         <20191005210127.uinrgazj5ezyqftj@yadavpratyush.com>
         <nycvar.QRO.7.76.6.1910061054470.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes Schindelin, Regarding your messages,


> However, it might not even need to put in _such_ a lot of work: in my
> tests, `Control-,` worked just as well as `Control-comma`. To test this
> for yourself, use this snippet (that is slightly modified from the
> example at the bottom of https://www.tcl.tk/man/tcl/TkCmd/bind.htm so
> that it reacts _only_ to Control+comma instead of all keys):
> 
> -- snip --
> set keysym "Press any key"
> pack [label .l -textvariable keysym -padx 2m -pady 1m]
> #bind . <Key> {
> bind . <Control-,> {
>     set keysym "You pressed %K"
> }
> -- snap --

I tried this, but unfortunatly, it didn't worked for me. My tclsh version is
"8.6".  The script crashed with following error message

---
bad event type or keysym ","
    while executing
"bind . <Control-,> {
    set keysym "You pressed %K"
}"
    (file "./test.tcl" line 6)
---


The complete ( or modified ) script which I used is given below

---
package require Tk

set keysym "Press any key"
pack [label .l -textvariable keysym -padx 2m -pady 1m]
#bind . <Key> {
bind . <Control-,> {
    set keysym "You pressed %K"
}

---

From the error messages, I understand that, "<Control-,>" will not work
instead of "<Control-comma>" .

> 
> So I could imagine that something like this could serve as an initial
> draft for a function that you can turn into a "good enough" version:
> 
> -- snip --
> proc QKeySequence2keysym {keystroke} {
> 	regsub -all {(?i)Ctrl\+} $keystroke "Control-" keystroke
> 	regsub -all {(?i)Alt\+} $keystroke "Alt-" keystroke
> 	regsub -all {(?i)Shift\+} $keystroke "Shift-" keystroke
> 	return $keystroke
> }
> -- snap --
> 
> That way, you don't have to introduce settings separate from
> `git-cola`'s, and you can reuse the short-and-sweet variable name.

If my previous observation is correct, then we may have to translate a list
of key names ( in addition to atl,ctrl & shirt ) to get it working .


> Ciao,
> Johannes

