Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8629D201B0
	for <e@80x24.org>; Tue, 21 Feb 2017 19:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753063AbdBUTFX (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 14:05:23 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:32819 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751659AbdBUTEM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 14:04:12 -0500
Received: by mail-pg0-f68.google.com with SMTP id 5so19564680pgj.0
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 11:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cU5BwUeEP+wZ9mFXWYIPzb/X8knP03B5GGtHXT6fuYo=;
        b=UCNMPClfj8gh5vVXZCtmkBUVdrVgoc4kqfPLM4tFL6CaWDzm3rf/iuDkVRaWp8oOP/
         sBjm+688N6clK5sq3LSN9RJqs757CQ1K3ZPUzeRhyIhQ3c99Q1+GuMk31cGORDqlbrzH
         ibbfbolg8iWQY1OMHnGlWMWtyVzIBVjMMTF8OACB7kUFOdFsHTY310jGghu3OZa7aP0H
         JzDZM8AabNceRtB0/WKDYdcGNVYuYjLibvL8kQ/lkvDBB3We4irTKMBdvF5/Lmopl6Ps
         Rtf7NDSJai4+SgPpWhKEaBIj7IrCVVHkysJs11/YqNLd5fRRNEAu1tQPqNz+PsiYbii8
         XHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cU5BwUeEP+wZ9mFXWYIPzb/X8knP03B5GGtHXT6fuYo=;
        b=rJ1GmGNgZlssuiP9iumM2R+HoW5YXM7j7uzGQXb3MpGyi90zODa8QoKfddRPyvaq1c
         AocSVu4HK9s/EfLYcIPfQrCK+GTEcyaAj1tPiUjlWO78mKhqA4U15ew4Th8D50w445+e
         QXrNfd1nwYFDyq7ScMW9t2b/9l2qpxJyd3FoIvU7d8CAOqPNqNSuywoXEVwyqk1qth7w
         Alvy7Z8AaxZKRv3fzvbgslfPqPfHy1iAJEa10V2fvcThh7zhUL8Z4bz/nCWLCgNVQw8U
         IrcqaBRcLHabUi9HlTXlwbzsA5aP3VV+SqaQWp4he9vwQQuVCbHwfNdy0eupgwHDc6pf
         ffOQ==
X-Gm-Message-State: AMke39l92023di6mNcp3vK89nbbKEJTNXV5HuCpuOpCzpgxeEa0RWePslqhG5GLqBkdldQ==
X-Received: by 10.99.43.74 with SMTP id r71mr17000122pgr.83.1487703851537;
        Tue, 21 Feb 2017 11:04:11 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d997:8b5d:f579:2a90])
        by smtp.gmail.com with ESMTPSA id r78sm42427739pfl.63.2017.02.21.11.04.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 21 Feb 2017 11:04:10 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dov Grobgeld <dov.grobgeld@gmail.com>
Cc:     Nikita Malikov <nikitam@devart.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        git@vger.kernel.org
Subject: Re: Partnership with Git
References: <02FFA5DBB1C64A8DA1BF45F11EBF9930@datasoft.local>
        <20170221152216.be2b8401f65650bf766cdd8d@domain007.com>
        <D0D8D50D4A2E47568029FE8BC52C3DC4@datasoft.local>
        <CA++fsGEvYPeP1UYniHF7OnowTH8-UeH3Kwe2KqaYMRouWVzEbg@mail.gmail.com>
Date:   Tue, 21 Feb 2017 11:04:09 -0800
In-Reply-To: <CA++fsGEvYPeP1UYniHF7OnowTH8-UeH3Kwe2KqaYMRouWVzEbg@mail.gmail.com>
        (Dov Grobgeld's message of "Tue, 21 Feb 2017 17:04:21 +0200")
Message-ID: <xmqqy3wzfjrq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dov Grobgeld <dov.grobgeld@gmail.com> writes:

> As git is free software, you are free to use it in any way you see fit, as
> long as you adhere to its licensing terms, and to the copyright
> restrictions on using the term "git". Thus there is no need to ask
> permission and there does not on the git side exist any entity interested
> in "cross marketing activities".

s/copyright/trademark/.  

As one of Software Freedom Conservancy projects, I suspect that the
Git PLC git@sfconservancy.org may be the closest to such "entity"
that represents open source Git community's interest to the outside
world with help from lawyers.

Not that I think Git PLC is interested in such a cross marketting
arrangement, but if Devart wants to advertise on their webpage
saying "we support Git by making contributions to SFC" or something
like that, they are the people to talk to.
