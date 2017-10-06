Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B852E20372
	for <e@80x24.org>; Fri,  6 Oct 2017 23:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752339AbdJFXoq (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 19:44:46 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:56937 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751485AbdJFXop (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 19:44:45 -0400
Received: by mail-pf0-f182.google.com with SMTP id g65so10239204pfe.13
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 16:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gHZ+yxSEqnPHNqc4fYwicg1nyneZ+BCpFAt2Gnjrv0c=;
        b=XFtMo43IhbKB3U41KvW5QpF+bdrdbXUq30A8wLaYVdBTGx3+r3WiwEU/ZpIagUqQuN
         b9wEf+ZYc6jGxZ+uaHWDrEEVKsaHoFTc9H4DSfp5uwuHBmgcc6tnoayVidMf1Pjdnk0e
         a7xqFhUmauxUU5881iYRdTIIs9YdpcQ7oL89w6cS1ix/v8Ius1Ueoje/Ck5L9BSqRn4F
         X/hhgYxJ0xhRB3gAlyfFDDtVshm6JFlikQDxTKnQKuHga7lmKsSBhJ4s6GOsMYNzcoG7
         A6oJKsL3rSemVYKtEzLO43K7zBxMkHoiFpRO8jya0hzOWNztXUQzjHb+mWNqZX94ylq/
         mWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gHZ+yxSEqnPHNqc4fYwicg1nyneZ+BCpFAt2Gnjrv0c=;
        b=hdI+nuJ4MSaW1IYmh5u872BlhLFYRqKhAq/QJChBNDp6jUJxvVBFwDEcUwzNZgQYiz
         zAbTHJ4sjIMvZY9sHgpw3I9zNdo2IestWYAOkPSdBwj8b7VIe5TQkNGPUEIVuzMziIoJ
         IT5362Jbcnobc3OVozYWK9Q3qZt3SazAj6Oabl/QH2HwrauzNW/T2RgDvB8yKcdCA9cY
         S4TsYDS+GUKje3eQQWVbpT2wJ2owadn1BqodA7DyE1JrYmSeyx2lcLAeHCjzynHtC+iw
         buZnocUD+/iaflDQt9vUhBsSbTLpb18PXhCYdX0E0pTEUoT2Kj6mI++DCdilDrTS8fW4
         nsng==
X-Gm-Message-State: AMCzsaW9vPdRKH0tV2/23wpTDu0scrGWpUlgks3pj4UcEoFlN5fwBqgd
        ZgezbHlXKOlCP6Oe1dOJS34=
X-Google-Smtp-Source: AOwi7QAo7dUS2l8Gs3WoL0rPpxXBRRGvCSHDMNI/9ADQ42OF/WDjpl8wsP0A68rbvNMjCYMU13ZJvQ==
X-Received: by 10.98.211.23 with SMTP id q23mr3618509pfg.28.1507333484926;
        Fri, 06 Oct 2017 16:44:44 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:fc65:340a:9269:aa72])
        by smtp.gmail.com with ESMTPSA id o13sm4708049pfh.91.2017.10.06.16.44.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 06 Oct 2017 16:44:44 -0700 (PDT)
Date:   Fri, 6 Oct 2017 16:44:42 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org
Subject: Re: [Question] Documenting platform implications on CVE to git
Message-ID: <20171006234442.GB19555@aiede.mtv.corp.google.com>
References: <000801d33ea7$04a7c240$0df746c0$@nexbridge.com>
 <20171006225049.GA19555@aiede.mtv.corp.google.com>
 <005b01d33efb$a5668870$f0339950$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005b01d33efb$a5668870$f0339950$@nexbridge.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Randall S. Becker wrote:

> The first one, mostly. When looking at CVE-2017-14867, there are places like
> https://nvd.nist.gov/vuln/detail/CVE-2017-14867 where the issue is
> discussed. It provides hyperlinks to various platform discussions.
> Unfortunately for me, I am not an HPE employee - and even if I was, there is
> no specific site where I can publicly discuss the vulnerability. I'm looking
> to the group here for advice on how to get the word out that it does not
> appear to apply to the HPE NonStop Git port. The question of where to best
> do that for any CVE pertaining to git as applicable to the NonStop Port is
> question #1.

How do people find out about the HPE NonStop Git port?  Where is it
distributed?  Does that distribution point allow you to publish
release notes or other documentation?

Do you have a web page?  That's another place you can publish
information.  http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-14867
links to lots of resources that are not from the Git project.

The oss-security list <http://www.openwall.com/lists/oss-security/>
allows anyone to participate.  It is a place that people often
collaborate to figure out the impact of a published vulnerability, how
to mitigate it, etc.  There are other similar mailing lists elsewhere,
too.

> Question #2 - probably more relevant to the specific issue and this group -
> is whether the vulnerability is contained to Git's use of Perl SCM and since
> NonStop's Perl does not support SCM, the vulnerability may not be relevant,
> but I'm not really enough of a Perl guru to make that determination.

What is Perl SCM?  I don't know what you're talking about.

Thanks,
Jonathan
