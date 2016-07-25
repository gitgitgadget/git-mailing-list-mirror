Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7763203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 20:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999AbcGYUQ2 (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 16:16:28 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34859 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265AbcGYUQS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2016 16:16:18 -0400
Received: by mail-wm0-f68.google.com with SMTP id i5so18293023wmg.2
        for <git@vger.kernel.org>; Mon, 25 Jul 2016 13:16:17 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rj439lCy68xYe8QKkNfQqTWhdpljKh7sLFQMmDlUDyU=;
        b=PTdygUbUTN+QEfIYRXo4SPZr7VmUBRaRljm/ORow8KAQvB/DoADOelz5bOuOdVoS10
         94+tUkDyxNF3Lvca19ULNVFssw3HkZ4RFPzeq1HI91Q+J0yjPWIpYxDtYsuck8q6i7Qk
         J6F6s910Mt8XFBgHMVyOXSt5T9goUbqWILPUfON0a9wsaB+0PidCEMJonL25OTQv7bxW
         KzyXMM4G3PjkSO6jlnsMbMmniU9QyjdkTxugpns6vrWyzSWsmkM98rYvcvxOq0rlntY1
         hqWVJYpNaFaMcFtvOTI6Ir+TnK9qd2voLFiQ1vy20FFkcvfUPBupIc9Wwx65zD0nv0e9
         3mJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rj439lCy68xYe8QKkNfQqTWhdpljKh7sLFQMmDlUDyU=;
        b=YUNDMhuQfRJNxSyjOYs+9Am5xZHJSfewY+1cPRvfqOeDdIf2jQZkqe67mUCQvYon1R
         fCQA8S4tg7yJjArmrWCLSQGkYLjeBNye7osg+6Xns3WJQZQr5BZqK6PlodL4SlYXr3d3
         JxWzzdAI/V+HI+bCtGTGehhL8nMvbun7/kXFIKDVpZdxcH1ziShMTTEpxYOMh+rkmxro
         0xuuGIcoK711FcsAddkwGRaGaBnIHehbsR1sx/Bppp/Z/0O6Jm74Ox8da48MuNOvt12f
         f7AMRWtqeVwnrm4mhgRIgV3q44juFiyQMOYzGSP3KP7ieWTZSHcT8nWVFQHQZ22wWxw8
         VRiA==
X-Gm-Message-State: AEkoouuaLU/90VnEQGibLqu9XEW6uI1uDhGxkJALbc6AwBVE48t/d3AOj7a5DM1PwNOGwg==
X-Received: by 10.195.9.226 with SMTP id dv2mr16710276wjd.180.1469477776999;
        Mon, 25 Jul 2016 13:16:16 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB7A6F.dip0.t-ipconnect.de. [93.219.122.111])
        by smtp.gmail.com with ESMTPSA id b186sm29106596wmg.23.2016.07.25.13.16.15
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Jul 2016 13:16:16 -0700 (PDT)
Content-Type: text/plain; charset=iso-8859-2
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v1 3/3] convert: add filter.<driver>.useProtocol option
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <5795337A.1040701@gmail.com>
Date:	Mon, 25 Jul 2016 22:16:14 +0200
Cc:	Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?iso-8859-2?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	mlbright@gmail.com, Junio C Hamano <gitster@pobox.com>,
	Eric Wong <e@80x24.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <34F8B256-A129-4238-AE1A-CD8C1DE8C7DA@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com> <20160722154900.19477-4-larsxschneider@gmail.com> <5792B622.5040306@gmail.com> <0FB8A921-3465-4081-A36D-D2F19A8ED63D@gmail.com> <579521A1.4070501@gmail.com> <5795337A.1040701@gmail.com>
To:	=?iso-8859-2?Q?Jakub_Nar=EAbski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


On 24 Jul 2016, at 23:30, Jakub Narêbski <jnareb@gmail.com> wrote:

> W dniu 2016-07-24 o 22:14, Jakub Narêbski pisze:
>> W dniu 2016-07-24 o 20:36, Lars Schneider pisze:
> 
>>> I agree that the name is not ideal. "UseProtocol" as it is would be a boolean. 
>>> I thought about "persistent" but this name wouldn't convey the scope of the 
>>> persistency ("persistent for one Git operation" vs. "persistent for many Git 
>>> operations"). What do you think about the protocol as int version idea
>>> described in $gmane/300155 ?
>> 
>> You mean the `protocol` as a config variable name (fully name being
>> `filter.<driver>.protocol`), being integer-valued, isn't it? Wouldn't
>> `protocolVersion` be a more explicit?
> 
> Just throwing out further ideas:
> 
> Perhaps make `persistent` string-valued variable, with the only value
> supported for now, namely "per-process" / "operation"?
> 
> Perhaps require for `pidfile` to be present for it to be daemon,
> that is persist for possibly many Git operations. Or allow "daemon"
> or "server" value for `persistent`, then?

I like the direction of this idea. What if we use a string-valued 
"filter.<driver>.protocol" with the following options:

"simple" / "invocation-per-file" / << empty >> --> current clean/smudge behavior
"invocation-per-process" --> new, proposed behavior

If necessary this could be enhanced in the future to support even a "daemon"
mode (with a pidfile config).

Thanks,
Lars

