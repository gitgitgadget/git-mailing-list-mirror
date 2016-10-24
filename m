Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D5D21FBB0
	for <e@80x24.org>; Mon, 24 Oct 2016 18:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965434AbcJXSL0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 14:11:26 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33826 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938833AbcJXSGN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 14:06:13 -0400
Received: by mail-wm0-f68.google.com with SMTP id d199so10994409wmd.1
        for <git@vger.kernel.org>; Mon, 24 Oct 2016 11:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=piPTraQ7hFlL1IwxNaYOWoQRPgfjUvkN+O91TO8R6xQ=;
        b=KRqV6gWgowZ8zdutpNnfkzyGFO84Cnl1n7dytqcBgE6MW3cEx0ESR27YAuRHEsQ4Uq
         0vm+oNlBgB5hGFJtVMuOZixYiDRbPkD3V06d+gpzF4IAomVRYopGriRKYCM0LBeOr5wv
         9qLWKNH6AowktOG6u8gsjQETcvalAD478PNw1JjFFNpM8qeQSmWlYvedPYQIEktf479d
         vA6N6ungaY7I4gQ6/CduBh1uuU3mZb3NbFhyzAuK8uSYKzkHyM5n8oOWxrfkFsDF5XYF
         THULr6Ic8DzwIj+KXTBBiPzePU8pA3/z2x3+efjLbFHoootEVXZz/2TbL//7bW4DG4qw
         R9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=piPTraQ7hFlL1IwxNaYOWoQRPgfjUvkN+O91TO8R6xQ=;
        b=AxMskHooH0dHG3gK8ce2caeVGtX2GZgxI5v729G+fLqsf9cwcxhRvk+gbVdVVoyKZw
         7bjcYGe+b42tJ2AAP6fx5B1BNtJlhDHTAJIw9bYo+Ug34RFjpqlu5rI/fwGk32EvYPDf
         xRr3J282Kwhkg+qLySnfoH/4d3mjA1q399knyhbbPuxG+HgOMQRZlYMLDmAjR5cBfIGB
         1UEGM4Fa4ie5gJbfkv2kXhyqyBL+2Pit10gcB3zHPMxne++m6XVXIayACS+i879sSiUU
         r95kCs7lhynrZT5NJB/69AB0/+1vs4dXYgVI2DNHC7PEm0oDzj4Q191DGv7Os5SisdMJ
         3+2g==
X-Gm-Message-State: ABUngvfy59oGJwptsH3nBALjbOORvI2JLKC0TqXqGXeO0nYKvYhxThviqDV48zJ6CFSHLw==
X-Received: by 10.194.171.225 with SMTP id ax1mr16120262wjc.48.1477332372257;
        Mon, 24 Oct 2016 11:06:12 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id p9sm20626398wjs.11.2016.10.24.11.06.11
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Oct 2016 11:06:11 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 0/3] fix travis TAP/--verbose conflict
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20161021104107.vh3bjx6x6pd6izat@sigill.intra.peff.net>
Date:   Mon, 24 Oct 2016 20:06:10 +0200
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <96985FB6-67D9-4146-BDBA-E22699061885@gmail.com>
References: <D9C1E13F-88A2-483E-A549-1C2294EACFEB@gmail.com> <CAGZ79kZo3LdcRmrjQTAvgx=H6U2tdjASK3qv5A2K5J2HQ2NvSw@mail.gmail.com> <20161021082035.xad6wfny5i6wtshh@sigill.intra.peff.net> <20161021084348.dp4jfpfownodl7nz@sigill.intra.peff.net> <20161021104107.vh3bjx6x6pd6izat@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 21 Oct 2016, at 12:41, Jeff King <peff@peff.net> wrote:
> 
> On Fri, Oct 21, 2016 at 04:43:48AM -0400, Jeff King wrote:
> 
>> The obvious fix would be to send "--verbose" output to stderr, but I
>> suspect that would end up annoying for people who do:
>> 
>>  ./t5547-push-quarantine.sh -v | less
>> 
>> to read long output. Probably we need some option like "--log" which
>> logs in the same way that "--tee" does, but _without_ sending the data
>> to stdout. Naively, that just means replacing the "tee" invocation with
>> "cat", but I suspect it will be a lot more complicated than that,
>> because we still need to let the TAP output go to stdout.
> 
> Yeah, it was definitely a lot more complicated. This patch series fixes
> it.

Thanks a lot for this detailed and quick fix :-)

Cheers,
Lars

