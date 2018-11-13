Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA8FC1F981
	for <e@80x24.org>; Tue, 13 Nov 2018 22:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbeKNIY3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 03:24:29 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:43474 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeKNIY3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 03:24:29 -0500
Received: by mail-pf1-f177.google.com with SMTP id g7-v6so6780763pfo.10
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 14:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WO9dM9DfXcoJz4ephzGAe3OlZxn5Jdvh+9ur15kWPDA=;
        b=SKBQ027U+juNeAGnT50dTnkzmqn05fVYmNmvX/h1IAHvCa7Qs5G0eupJKWFfvHc9I3
         0gl+vbnGM553WUj0Bq7bPUptjWmKROykjCxgpzmsimfgessFTaDBDuUw5U50op6BSTMp
         rXuASCpiHba6zb2HJOaO5BUudhinKNy9iX1zKRGT/LORHDB8SEShab2gHbXzdwD0GvM7
         vDj8DCn1T+LqwlrA+/wkXkzGIM7RoJ7nBDNtvmPIEgdp4HvtWARevK2Y6lLMl1oGF6sz
         Yu70DQpllqvT3+RAoRWylhbTeCKWB/HN/DpfIpn+QtieBkqEkZx8+Q85Hxvy+yeDO2rk
         5yEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WO9dM9DfXcoJz4ephzGAe3OlZxn5Jdvh+9ur15kWPDA=;
        b=kCMebD9mUCTlecpHsf42Zx/El12Qyiz95/xvTfom65Y8gA/hVCmIMrOLJgK9mUiKfy
         fDbImHQhtRQ+5wgwgrB85dVC9BgATjp8JDao+ZUOH0rU9MjoWUKggq0oHSRHoAUpuDc/
         Srvxicu/4qUG1Zwmv64z1HAOVGWlKJj6YkjoNMQ2sGLetuHiq0mUObvEJixxf7QkK080
         625Rj1xW+l8zt0jFhNf5xWgX8IbKUZpW7jat4UdrJiZgkviY4tDPqQOP9JIBuXedZ1ng
         z+vEUKTjfndAXoqUdVtv9cFLAJwemQLiTVhVAzevNOMxgFtoALKKW6YhZPSJlFJWYdZS
         6mHg==
X-Gm-Message-State: AGRZ1gIRK/I/1pPI+/QFUe/QcwOts6wFZivYRRIyFbcWSQp1Ga2z6XtR
        vzscM2HDNUG5O7opg7uHvCWxlJKZ
X-Google-Smtp-Source: AJdET5dii3I3oLj8LPsAKWCANCoH2K5xbz9danF+tKrzUO7AtIqxi0vzxDGzrjWso80j83HSbqgZ+g==
X-Received: by 2002:a62:6c89:: with SMTP id h131-v6mr6980026pfc.12.1542147854096;
        Tue, 13 Nov 2018 14:24:14 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id b14-v6sm24942047pgn.49.2018.11.13.14.24.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 14:24:13 -0800 (PST)
Date:   Tue, 13 Nov 2018 14:24:11 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Paul J Sanchez <pjs@alum.mit.edu>
Cc:     git@vger.kernel.org
Subject: Re: git-scm.com GUI client links
Message-ID: <20181113222411.GE68106@google.com>
References: <784B3DBC-BE5B-4E7A-A94F-80E5E135195B@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <784B3DBC-BE5B-4E7A-A94F-80E5E135195B@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+cc: git@vger.kernel.org, git-security@googlegroups.com -> bcc
Hi!

Paul J Sanchez wrote:

> Over the weekend I saw a link to a Mac git client I had not seen
> before:  Aurees.  When I went to the linked site to download a copy,
> my antivirus software (Sophos) warned me that it contains malware.
> I immediately threw it away without installing, but figured that
> git-scm.com <http://git-scm.com/> should be aware of this.

See https://groups.google.com/d/msg/msysgit/br212yYOZ70/bp5t4QpZk10J
for a similar symptom in the past.

See that thread for some advice on how to track this down.  Sadly,
my experience with antivirus software is that it is just not very
reliable.

That said, it's possible that this Mac Git client is indeed infected.
Can you point me to the page where you found it?  The git-scm.com web
site is maintained at https://github.com/git/git-scm.com; that page
has instructions for contributing to it.

Thanks and hope that helps,
Jonathan
