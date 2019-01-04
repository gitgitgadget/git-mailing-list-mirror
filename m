Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD5171F803
	for <e@80x24.org>; Fri,  4 Jan 2019 06:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfADGZh (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 01:25:37 -0500
Received: from mail-it1-f176.google.com ([209.85.166.176]:38411 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfADGZh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 01:25:37 -0500
Received: by mail-it1-f176.google.com with SMTP id h65so388249ith.3
        for <git@vger.kernel.org>; Thu, 03 Jan 2019 22:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5vf+HU88d7OdNS/WMIT+LeaKHBpfOF9dGG4iqb1jM7Y=;
        b=UYjUQt0gRaJiVYJeM0nMDjOu8gV4XqTwzWjlJjtNiVoVHUgZmdb9++6IEJieVwmSNN
         bmKUKNhwgaL266sv2uG5ErW9serqtNaAeofXwfpqE4cI9gbzJUjwNyT8ZeBPbQMLxaLq
         FxyMxsD8jknmsD0O1Kxr7x0uyT4odGg1gmVdhEwlYxF15IkuFRbOoVgfif56QJ83WGnX
         zY/cnZz1eta189JX7AYsh/sB+FjKutKQnrERfpNGTOACtq2P3KH0zJx96ZBuaPArpwGp
         hRO4EpdQH91RN4iIRVMAvvnlFhRnmYbfvExs3mB/RFEjYm1mBDigfkW3wrTxRP9Tt1bi
         FICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5vf+HU88d7OdNS/WMIT+LeaKHBpfOF9dGG4iqb1jM7Y=;
        b=GoglnhRNibHeWQ/J0jIikxXeLpMZYExavByHxxRXTtIgGlumWh2MN0oRuxzpHIAeY2
         Gu3rNgmxrpnuirpDAcJAEp0Zzxe8vKpkR9EqwcuiisGgOCXIKHh4oa8+SxqsIGQY4dml
         h5AnncCz2wEgVvQWl+LW+Dc6Qi9GM51OyuGS/YBE9UHbBftg/BVMeI0PZNF4bUFAuJkA
         H5wQj5Xo5Yu4F2VinHoCh5i0g2sxjeTGqnCW+rw1y0coKifUkLdieMuB6736lbG1EuqI
         eUabCGY5FNiZ3KdGqroVfCJHp3jDviBA28C7DhL+9qVitxRP6SJ+yjZuWmHyBuF25TYb
         Gz3w==
X-Gm-Message-State: AJcUukcq47mjdbm28kc2HxorZg/dOmKzsad/yTbq6nMGRUZ52D++gmbc
        TelVRVrBvrG1vNV+Vwfmp3I6B4dhj00q8P4/2M6zUA6Dj3o=
X-Google-Smtp-Source: ALg8bN6mC9I/0Zbdd2yPWd/atkEeb7qaauxKjWKN7FAaPE62vOElXYn2FoHrck2bLKSpXjppJHcmw2cRH5Vwrb9Qs00=
X-Received: by 2002:a24:7596:: with SMTP id y144mr235374itc.68.1546583136038;
 Thu, 03 Jan 2019 22:25:36 -0800 (PST)
MIME-Version: 1.0
References: <1e4ac3d5-f6f5-bcce-2f09-0519934289b9@milecki.pl> <19f3c27ed059f5556131b3e0d2faafce@milecki.pl>
In-Reply-To: <19f3c27ed059f5556131b3e0d2faafce@milecki.pl>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 3 Jan 2019 22:25:22 -0800
Message-ID: <CAPUEspgC92S-oRbjzU79UDPR1BrrvLKPeNwTOrq1iYw-nadxKQ@mail.gmail.com>
Subject: Re: git-send-email warnings & process dying of signal 11
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

one important point to consider when tracking this bug is that perl is
not crashing, but is told to abort by some instrumentation (most
likely gcc's fortify) and as shown by :

*** buffer overflow detected ***: /usr/bin/perl terminated

Carlo
