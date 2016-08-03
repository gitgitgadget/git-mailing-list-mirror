Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FC051F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 19:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbcHCTAA (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 15:00:00 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35482 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498AbcHCS76 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 14:59:58 -0400
Received: by mail-wm0-f42.google.com with SMTP id f65so459263247wmi.0
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 11:58:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=DTIEhF0tbWyf7sQqU6hpMXVNYdP7B1bgGxJ2klJWsgE=;
        b=JKqYD8wdbV++s/AxWd4T7vWYNynPY/r38mKTQj3vRixlNxw/Y5nlv3QBGp36QwmY0h
         bRNhrWFGI7JJrMOPsTkeZ6VRftuh4B7XTupwb6TwdMK4iGdANTjOCqZfQvxBSKfzvqAq
         dmpK/4kBhEmwiysuIgDRV9lDNjy1Qgg9sPq9HFHwVjuKzoZCQUg4/A4uxMcovFlUiKuF
         dqVcG8iwIysB5SdAOMnPS0E7gabbcUlFXehpUURSKEyzdf3yEvu4FqY7+Z193yKQzXGt
         0z6DYF+xt/rEV7haTAHWHEg5SgJahfw7VFT/SdUfZO47u3KJM7xD0mzlie1ygZfmztxf
         YmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=DTIEhF0tbWyf7sQqU6hpMXVNYdP7B1bgGxJ2klJWsgE=;
        b=ZKPJ/CET4blTacoflQn27gL+GipAHabW860QpIsX3D5LJlfqVpe/Ry4GP2tBe5QgK1
         bvLQf6dr05O1PlQgz9+EaC96SK5zj8Cl8zhxYL9XYoRCXb+PJx0yNjV43h4ge61oMkff
         50PxrFavB8LzHXPKjs2AqwPvEqB3EFvFtuKzhMayKsNDYYxUE5b1iXYs5BBS5ux+ZVCE
         BSfDgItcnUAB54ruZDbyv7xz7H7a3kSvooAEi/11h3cG+29ygN6TJ7A1TP0PEtTO3lkw
         Vl9BADa50xTSMtHFVJxeZT4PtIf+mS7jnFwoxPz/dtNkrHmCgIkToL3BcurW19KnKMzR
         aFnA==
X-Gm-Message-State: AEkoousWtascy+d5P4yp5yn9k9ZMBbOy+HsbOEPO8gehYeq7LOjbEmshkyByah4nQwPLQA==
X-Received: by 10.194.235.166 with SMTP id un6mr71039413wjc.169.1470249290961;
        Wed, 03 Aug 2016 11:34:50 -0700 (PDT)
Received: from [192.168.1.26] (daq191.neoplus.adsl.tpnet.pl. [83.23.16.191])
        by smtp.googlemail.com with ESMTPSA id n7sm8951337wjf.11.2016.08.03.11.34.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Aug 2016 11:34:50 -0700 (PDT)
Subject: Re: appending a pattern to the default "diff.cpp.xfuncname"
To:	Jeff King <peff@peff.net>, Laszlo Ersek <lersek@redhat.com>
References: <40ceebb8-b343-a5ca-e7ff-23cccc181528@redhat.com>
 <20160803180213.o7xpm4c4tw5rixmy@sigill.intra.peff.net>
Cc:	public git mailing list <git@vger.kernel.org>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <8c4e96b9-165f-5168-d220-6a1548ff83c7@gmail.com>
Date:	Wed, 3 Aug 2016 20:34:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160803180213.o7xpm4c4tw5rixmy@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 03.08.2016 o 20:02, Jeff King pisze:
> On Wed, Aug 03, 2016 at 12:16:14PM +0200, Laszlo Ersek wrote:
> 
>> I've used diff.<TYPE>.xfuncname with great success for file <TYPE>s that
>> I defined myself. However, now I would like to append an extra pattern
>> to the TYPE=cpp case (for which git has builtin patterns). Is there an
>> easy way to do this?
>>
>> I figured I could open-code the builtin patterns from "userdiff.c", and
>> then append my new pattern to those, but it looks kinda gross :)
> 
> Unfortunately, no, the config system has no notion of "append to this
> value". 

And I think adding such capability would not be easy.  Well, perhaps
we could support '+=' in addition to '='?

>         So you are stuck with extracting the builtin value (which
> annoyingly, you cannot even get without looking at the source code!),
> and repeating it in your config file.

I wonder if `git var -l` could provide all default values :-P

-- 
Jakub Narębski

