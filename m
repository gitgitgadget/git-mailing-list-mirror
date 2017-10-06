Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FBD41FA21
	for <e@80x24.org>; Fri,  6 Oct 2017 04:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751654AbdJFEIt (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 00:08:49 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36727 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750813AbdJFEIq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 00:08:46 -0400
Received: by mail-qk0-f195.google.com with SMTP id z14so11217198qkg.3
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 21:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B8q8egaBy/QiWbUGElk+A6PwDxq1ai44dVfcG/b+9xM=;
        b=ZzRYCWdNbvgCVg/wxCZlEQnSK5ale4EPxah8PqrzH5DVKZe34wyn0AnU3XLdrIEpw+
         QJ/DGH3uHbG5NYSTjfOzg+ezR5Qm5BfvXSoUR6J7nYDIlT7ptD8iC0S80R0VMOjqJeSq
         DWysCp3Cyu4qS6+KeCFa4RMwNu+6i/FIGnCL5Iyt8/4IIeRhlswgo3ykd7aehW4NKCaY
         rO+3Z31/8i61n/b2AA4gflgo7/rNMYEOMFykG4fbF5k8cmBUopGFCQDdZ+2OkDaxzd1z
         Iac87P4oZ0zkKF8+gpSg298LYp2C4qHGA3+5/xkucXwa4JJYjOuRqYnZMdeR2QQJRT3C
         2zoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=B8q8egaBy/QiWbUGElk+A6PwDxq1ai44dVfcG/b+9xM=;
        b=gqRvgtb+ja34Idikab4oGBNmlPHDRiNOZYXbJWuoZlLB2NoqXqTt+yTRXG05WmNzex
         LuMqe5ACFSjeQkcfXu85DXRWoE9AQV83JDmHEaA2L1qqNbtMyP4YgWZ/9bC9CQUXvVKk
         b/3FD36pErdm5pn98DjY8Z9E2KbaTJWLeNqKzta60Ar0e1+VQNXOIGX4VCABEKIBKVph
         gVnWfJ09OZAstVN5XCORrTMUlcC/twSX47bnSornBxYm+Bh20ZxOMIb+T+K8JrmN/mIK
         4Yjo3C/RQZFloKoLDeuviOzUpy3QGwZlOXYA7ccQKctaoS8lq3fT2vEGsG7xb2BrqWIi
         CfPA==
X-Gm-Message-State: AMCzsaUeDpXhGj3jd0Wh1CAR5otkNNYMzDSCsjpZgkGXxR5tvvRpEIQO
        7tVgpX9z6OYZMnmBzMD+aIc=
X-Google-Smtp-Source: AOwi7QDpb/SbsaEMlLqVmHY/QXTGkTmKXxKO6v9mcoTh0we1ZOrUJGJTaObU+6i+gLskgLbOUlWLUA==
X-Received: by 10.55.3.133 with SMTP id 127mr35217212qkd.42.1507262925215;
        Thu, 05 Oct 2017 21:08:45 -0700 (PDT)
Received: from zaya.teonanacatl.net (pool-71-113-173-254.hrbgpa.fios.verizon.net. [71.113.173.254])
        by smtp.gmail.com with ESMTPSA id z26sm421151qtz.52.2017.10.05.21.08.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 05 Oct 2017 21:08:43 -0700 (PDT)
Date:   Fri, 6 Oct 2017 00:08:41 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2] api-argv-array.txt: Remove broken link to string-list
 API
Message-ID: <20171006040841.GD3382@zaya.teonanacatl.net>
References: <xmqq4lrdyp8v.fsf@gitster.mtv.corp.google.com>
 <20171006031456.9632-1-tmz@pobox.com>
 <20171006034538.GA142701@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20171006034538.GA142701@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:
> Thanks for catching it.  Do you use a broken link detection tool to 
> detect this kind of issue automatically?

Yeah, in the Fedora git builds we pass all the generated html files 
through the linkchecker tool (http://wummel.github.io/linkchecker/).  

We started using that a few months ago to help us catch broken links 
in case we somehow failed to include some documentation in our 
packaging.  (After catching this minor issue I wondered if it might be 
useful to add something similar to the travis builds, but I haven't 
done any more than wonder about it. ;)

Here's the (somehwat verbose) output from the failed link check:

$ find /builddir/build/BUILDROOT/git-2.15.0-0.0.rc0.fc25.x86_64/usr/share/doc/git -name '*.html' | xargs linkchecker
[...]
Start checking at 2017-10-05 12:37:01-004
10 threads active,   325 links queued,  194 links in  47 URLs checked, runtime 1 seconds
10 threads active,   643 links queued, 1242 links in 197 URLs checked, runtime 6 seconds

URL        `api-string-list.html'
Name       `string-list API'
Parent URL file:///builddir/build/BUILDROOT/git-2.15.0-0.0.rc0.fc25.x86_64/usr/share/doc/git/technical/api-argv-array.html, line 745, col 31
Real URL   file:///builddir/build/BUILDROOT/git-2.15.0-0.0.rc0.fc25.x86_64/usr/share/doc/git/technical/api-string-list.html
Check time 0.002 seconds
Result     Error: URLError: <urlopen error [Errno 2] No such file or directory: '/builddir/build/BUILDROOT/git-2.15.0-0.0.rc0.fc25.x86_64/usr/share/doc/git/technical/api-string-list.html'>

Statistics:
Downloaded: 7.17MB.
Content types: 0 image, 2764 text, 0 video, 0 audio, 0 application, 29 mail and 49 other.
URL lengths: min=17, max=125, avg=96.

That's it. 2842 links in 232 URLs checked. 0 warnings found. 1 error found.
Stopped checking at 2017-10-05 12:37:09-004 (8 seconds)

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
I always wanted to be a procrastinator, never got around to it.

