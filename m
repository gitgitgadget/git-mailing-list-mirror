Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A66691F404
	for <e@80x24.org>; Mon,  5 Mar 2018 18:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752719AbeCES3r (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 13:29:47 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:53204 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751874AbeCES3q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 13:29:46 -0500
Received: by mail-wm0-f45.google.com with SMTP id t3so17844394wmc.2
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 10:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jeiqbaRmb7xxnH76NPUH6QSFVEhJXBhWmWWPnZPnHco=;
        b=iOcfiZQbiHvCXPu7nhDcNHGeBTlAcHi8fpLW3CzC/uvRxciVntQX+kZCaI54qGCkY9
         5zaxqIaii2+pKi9Aknjp5NvmtF9CGR9rdV0YlqnZOAauda0Lj+CM9nAqAum028XCtYGB
         MlTDye6ot6zewVXYQ8T0utD2herQch3M2AF0EIb6wRjTMuaqHnCEDa0k8hx2qwBlUBPb
         N9c50RE47/FxCPibzfReEWb0YVuKVbCTM8zdxm0fja19lVACjvs8/ik8ere/ljESAaSy
         Q3Eq4+JUdu3CfUBhFE9iruOoQQc3MxV4Od/7uztFSkucTY6B/Ll4f5Y7qXVPZK4kFeyE
         dvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jeiqbaRmb7xxnH76NPUH6QSFVEhJXBhWmWWPnZPnHco=;
        b=cOFYIBfSl3Lv8htKwfwRzWitFNkD0GE20WogPsvPmBFW4rQ/rhbTCK0qy6mscD43ud
         RmloiLeU/I4ysWSMw38C6p2xK6en6AOEVdaRDEGQ3cBGafF+F8qk+AtfR8NdAhaUoMfh
         KDTgAsegHOS+k3xdN9J+q6L1PsLKNvQcC9Fzy3UTYXFelpK3gx+zU8UX5Td8U0LbbaGC
         vTE84r4/7YvaaQmn+Yh+YmteFZOSyvv8SB8j5o6LOCQEP8V2n11oRU2anQvoyPP5Rq8r
         NnSvmw9+nqALxQhzkixSHLiF3HY9DfMgqURVlH/a6og8xbs9FCYHNcsIZNj5IYIpc4Qg
         APvg==
X-Gm-Message-State: AElRT7HtwpQaAL9nuDqRim3k6s3qYsBEwIonTw90d0FW2cs5/ejKL0tQ
        ZD3YJhOi9rnxvsN2agQhwH1bwRqE
X-Google-Smtp-Source: AG47ELtBydT59y6icdinSvuty2KUsk7S1n8c7Ikymx8Lo6vndHLeIz74QhmxA1A+kWJZcoPECqCv4A==
X-Received: by 10.28.234.197 with SMTP id g66mr8818876wmi.10.1520274585218;
        Mon, 05 Mar 2018 10:29:45 -0800 (PST)
Received: from [10.6.133.146] (135.red-80-28-119.staticip.rima-tde.net. [80.28.119.135])
        by smtp.gmail.com with ESMTPSA id c56sm23691686wrc.82.2018.03.05.10.29.44
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Mar 2018 10:29:44 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Contributor Summit planning
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20180303103957.GA24498@sigill.intra.peff.net>
Date:   Mon, 5 Mar 2018 19:29:43 +0100
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <CD80986F-E79B-4588-AB0F-AD5C6385836D@gmail.com>
References: <20180303103010.GA21068@sigill.intra.peff.net> <20180303103957.GA24498@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 03 Mar 2018, at 11:39, Jeff King <peff@peff.net> wrote:
> 
> On Sat, Mar 03, 2018 at 05:30:10AM -0500, Jeff King wrote:
> 
>> As in past years, I plan to run it like an unconference. Attendees are
>> expected to bring topics for group discussion. Short presentations are
>> also welcome. We'll put the topics on a whiteboard in the morning, and
>> pick whichever ones people are interested in.
>> 
>> Feel free to reply to this thread if you want to make plans or discuss
>> any proposed topics before the summit. Input or questions from
>> non-attendees is welcome here.
> 
> I'll plan to offer two topics:
> 
> - a round-up of the current state and past year's activities of Git as
>   a member project of Software Freedom Conservancy
> 
> - some updates on the state of the git-scm.com since my report last
>   year
> 
> As with last year, I'll try to send a written report to the list for
> those who aren't at the summit in person.

Thanks for starting this. I would like to propose the following topics:

- hooks: Discuss a proposal for multiple local Git hooks of the same type.

- error reporting: Git is distributed and therefore lots of errors are only
  reported locally. That makes it hard for administrators in larger 
  companies to see trouble. Would it make sense to add a config option that 
  would push recent errors along with "git push" to the server?

- fuzzing: Would it make sense to register Git to Google's OSS fuzzing
  program https://github.com/google/oss-fuzz ?


- Lars
