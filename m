Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1AB8207EC
	for <e@80x24.org>; Sun,  9 Oct 2016 19:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752385AbcJITPj (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 15:15:39 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:32955 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752183AbcJITPi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 15:15:38 -0400
Received: by mail-lf0-f50.google.com with SMTP id x79so88028628lff.0
        for <git@vger.kernel.org>; Sun, 09 Oct 2016 12:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=woDMIVD6IqJljc1zHfU1/NKGtQ9D/ni8ClDN2D3m1Qk=;
        b=QrYZBr75/k7Lx7g8gGk8KmeMHBmYbUoYMWDwUS9eX0O/f71CJsF61st/8uPVp2yN9G
         Tw6I/Ke6sHktaD6ReFxL0Ushx+JgF+2qvVTmfYbbVNedvhWE+7LBUYhhobwwgwnixtKC
         amvlRfH2v8paoRura7v/1W9AMpCCigX39MMVFZrTCaYJ26My4IYqxHvZO1prPRk7q7eG
         7UGJr+x8uzr4ZBqVCfZLZ1ib8pUAanIYAqzviRq3UzzJrc3cswpplTG2N6WKA5zF0OVE
         BLBqTe6n2R0BzCi/zV+1tHxkIB4bifMOMesxJsUnEWFPBT6/vg/cUtbBFFCsZVh6ds5M
         qhqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=woDMIVD6IqJljc1zHfU1/NKGtQ9D/ni8ClDN2D3m1Qk=;
        b=bfrHiKQsQMIo48RyMWqJUPHm3Naem+VHwMc2OFf9tEymcOkyGo0j1XhahLe20mHSWI
         X0Ul09W4E4tljGV75oUtnhVJZMs0ivHa6PenN0cTdEZnSIhkEgoJzWfM9VTuo7FV7NhJ
         kJK5ZNcGJ9EVThC1IpRPx7vGnC+J9ZdCFEMHyTpLeGsyT0TWU7brVdbeNNEX9jIBTlu2
         dTq6q/rb8othATH1ALNJ1SQILBXaYAJxWRNaxK1UkLlmnEUdeoLl+JZUejR1yT79IxJT
         iga7fEeR2qFTpQdF1WZIu87GnsQ9m3vcGHCDOcLh7YUSLJB708hETKgjAzQpx6UeBGmU
         8G8A==
X-Gm-Message-State: AA6/9RkYwC9/6kvZyh71MKuWTSAKUquvkVfol3ua8GIvhPQG9Nxx3okeVsOut9OQuRf2RM69E8eHWXY7tug8FQ==
X-Received: by 10.194.83.166 with SMTP id r6mr25207445wjy.186.1476040536989;
 Sun, 09 Oct 2016 12:15:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.143.33 with HTTP; Sun, 9 Oct 2016 12:15:36 -0700 (PDT)
In-Reply-To: <1476035501.26041.1.camel@kaarsemaker.net>
References: <CAL4SumgJbrirymt5+iyNbpo++xXfzJZRiHDm8=0+eCArpCX=DA@mail.gmail.com>
 <1476035501.26041.1.camel@kaarsemaker.net>
From:   "venv21@gmail.com" <venv21@gmail.com>
Date:   Sun, 9 Oct 2016 21:15:36 +0200
Message-ID: <CAL4Sumj7r-RNXBi2Oh_=KAkcksM13sJjLzJEpszWXPXZ8hP6Kw@mail.gmail.com>
Subject: Re: Problem with submodules
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sure, http://pastebin.com/bUFBDj0Q
