Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E9452018B
	for <e@80x24.org>; Wed, 20 Jul 2016 08:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbcGTItH (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 04:49:07 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34938 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbcGTItE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 04:49:04 -0400
Received: by mail-wm0-f47.google.com with SMTP id f65so166329769wmi.0
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 01:49:02 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=MX/puwzla4XaabesJw4oC1lDEdt5TSoEHJCzTq6oVVI=;
        b=YJJSSHkPPaZV0F2CkELT0/YokWDqxJFV06jwUg0UntBsm3J2q9wvcjgPw5kUxPYw76
         AgSHxeECyUCXwyAccFoSmir7F4AmwjFTzGo4g4qFxjEx6isAmtvV0YgBoUulKZ279yiz
         WUp/xTQRLLpFzkPYFkDXXwyWVqnu+lCMvLlVQsBSowZI/EHlFINlz/aLNdQRqUH91Wi2
         cTg49VnodE3GBssH3SpFuQccBqWjYWddL8QJuQoWnv2NCUdMKIj0WCqyzLqkaJe7iZVS
         6sUDPmGz9gtx3g0RSLy57kzlleftQ+qmKHQw31F6iTrh8agISN5r80NqMMXGuMBQJ5N8
         Ke4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:newsgroups:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=MX/puwzla4XaabesJw4oC1lDEdt5TSoEHJCzTq6oVVI=;
        b=Xy0Y9KJu/Ax03FBFi4+/283dYTNC78hw538Fd3ykSXV1gEIPVuCGqP4ctRE9kQX5Ts
         qniTlBGVF+9fZnEliLDPMzl+dGSl0X46a7lA4KGV39kBzHVqmfQ7ATXgU0PEkypmPOJH
         1seH8gQbgVpeG+XBBBWZEM87Dh+3kEWdGQDtSC+wuPmFh0judn+vzxxas4BJCgidLKzj
         FnL1ce3uiMNYDFhn3114Q4DveBmkketOKhWNxB/r81i+iiM7px+fzdI5Dd3NenyDAiTL
         Z4lq7JBzs4ePqKPYv7WAWPEG9wfcVZ9o7vgGKSgBNGVBtxqkX0lDPEzGMuXlTdOItWPJ
         a9sA==
X-Gm-Message-State: ALyK8tJHpo96Dc15ouNL1CskHJstnmYQfgADG9MAf9s+iWpUTn7T9wj3dtgH800CgZcT0w==
X-Received: by 10.194.124.228 with SMTP id ml4mr95509wjb.153.1469004541580;
        Wed, 20 Jul 2016 01:49:01 -0700 (PDT)
Received: from [192.168.1.26] (adan30.neoplus.adsl.tpnet.pl. [83.11.249.30])
        by smtp.googlemail.com with ESMTPSA id d5sm91350wjf.39.2016.07.20.01.49.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jul 2016 01:49:00 -0700 (PDT)
Subject: Re: 500 Internal Server Error
To:	Shreyas Mulay <shreyasmulay23@gmail.com>, git@vger.kernel.org
References: <loom.20160720T061853-541@post.gmane.org>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <578F3AF7.4030702@gmail.com>
Date:	Wed, 20 Jul 2016 10:48:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <loom.20160720T061853-541@post.gmane.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-20 o 06:22, Shreyas Mulay pisze:
> Hi team, 
> 
> Great work on the documentation provided for GIT on https://git-scm.com 
> 
> But found an error on the same, to just for testing, I switched to Hindi 
> Language (Clicked on Hindi link on left panel) as for reading the 
> pages/book in hindi language, I got 500 Internal server Error. 
> 
> I hope you rectify this issue.

The git@vger.kernel.org mailing list is for a development of Git itself;
the bugs on Git Homepage (https://git-scm.com) should be sent to
https://github.com/git/git-scm.com/issues -- as you can find on the
bottom of the page... though it is not obvious.

-- 
Jakub Narębski
 

