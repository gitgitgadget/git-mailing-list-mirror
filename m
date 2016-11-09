Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7228220229
	for <e@80x24.org>; Wed,  9 Nov 2016 08:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbcKIIZz (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 03:25:55 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37462 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbcKIIZy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 03:25:54 -0500
Received: by mail-wm0-f41.google.com with SMTP id t79so285326626wmt.0
        for <git@vger.kernel.org>; Wed, 09 Nov 2016 00:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pS1FuPdfX9yN3hWU9IW2SDBSBjJgYlE6mSPwwBWcCJU=;
        b=EkLGQSnGvZEc5IeSBkG7Ngmldm9hjh+SwvD6vdCnEPdAS538XE3kN2Yd0mRwdxulzk
         BIzAZpzfMS9asDKf1kfgCZCfWJvdVpBUMkNWM+2QEMAu4eb8HcKWqX2z2VBv0OgFnxhZ
         6ROf0R8h4XxD7Yg64OjVC3W/PEv6Ogw2hBIgDtrH+37kK/Rt8NFpIvplECMyATkeM1qH
         +iuQ9ut20i8kr+yDwo5Ku52li7EvYlr0s0voPQSY7IsFQBsU6vRpMqnPCicAd1AnAa1P
         Dd+wR3HsETHfbAglNgB2yaA1h74L6gohO2oT3++XJt8BDMQj5o8wr81ngrj9SBpO413F
         FQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pS1FuPdfX9yN3hWU9IW2SDBSBjJgYlE6mSPwwBWcCJU=;
        b=Ixew1Xpf6UcZ985ML3Wt7V2QhRbmKc5mTArhXuq+ou33//zNb0jxn4HSavfgVTbR9P
         nruc+QjWlexexgZRdXx3LEZDLe2vrS2+TeyQW3vI5RVvOyWMRQy7cTgF3XU/syrqOHlN
         K5BhgeHDV9zOG7Pe6zV1nYLTVvr+dVEOQqfcdbi6xeZ4uiwiLWDdb+RXt2naykGjGXSQ
         uupjaVk2j1QljmSpe1pU+7OVQKuwo1foA1EdP30f6sMn1PbDFD/7rqT38GdyhexHah0P
         ObPCkIeI9i9KPb1OJXGHiVvtSBQ1DPYzo6jlNt2kcelC6TuM7DObL/Qf1Nt5MdM31wbo
         0jOA==
X-Gm-Message-State: ABUngvdtq0sLcq3tQb7vKBawJC5SdARPcj2hhgAImgR7Xl4DdjnfHsV8M8gHxzUAkSyC4Q==
X-Received: by 10.194.86.34 with SMTP id m2mr13688189wjz.90.1478679952703;
        Wed, 09 Nov 2016 00:25:52 -0800 (PST)
Received: from seahawk (proxy-gw-l.booking.com. [5.57.20.8])
        by smtp.gmail.com with ESMTPSA id r7sm28186626wjp.43.2016.11.09.00.25.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Nov 2016 00:25:51 -0800 (PST)
Message-ID: <1478679951.12904.1.camel@kaarsemaker.net>
Subject: Re: Forbid access to /gitweb but authorize the sub projets
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Alexandre Duplaix <alexandre.duplaix-ext@sagemcom.com>,
        git@vger.kernel.org
Date:   Wed, 09 Nov 2016 09:25:51 +0100
In-Reply-To: <58207CAB.3060105@sagemcom.com>
References: <58207CAB.3060105@sagemcom.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.1-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2016-11-07 at 14:07 +0100, Alexandre Duplaix wrote:
> Hello,
> 
> I have several projects under https://myserver/gitweb and I would like 
> to forbid the access to the root, so that the users can't list the 
> differents projects.
> 
> However, I need to let the access to the sub projects (ex: 
> https://myserver/gitweb/?p=project1;a=summary
> 
> How can I do please ?

My favourite way of doing this is abusing the fact that gitweb.conf is
perl code that's loaded with do $filename.

This makes it easy to override such things. Try this in gitweb.conf for example:

sub no_index {
    die_error(403, "No access to the repository list");
}
$actions{project_list} = \&no_index;
$actions{project_index} = \&no_index;
$actions{opml} = \&no_index;

-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net
