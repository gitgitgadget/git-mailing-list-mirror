Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8578C200E0
	for <e@80x24.org>; Thu, 29 Dec 2016 10:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbcL2KLk (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Dec 2016 05:11:40 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34911 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752402AbcL2KLj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2016 05:11:39 -0500
Received: by mail-wm0-f66.google.com with SMTP id l2so40308455wml.2
        for <git@vger.kernel.org>; Thu, 29 Dec 2016 02:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MFC7ZrTHVjwb63g4iKPsNbd6SOoQy4xSM3XRyK+OSFQ=;
        b=IOe60ulyUUm2kB4GgwNHE5EoFcquWgmidlwpmH1hrtv8XGQA4pZfouX4nA7wnzMnis
         cRPb7MXFqmsOsT4WrlqS7SLDt3LcTXBg6vw1fnha8vtIELnDfvEFrKS6CxwMschmev1J
         YdcKarScdYwYCyDkBNeJflCLQaScQdSrDF2S21HWanxV6Y/BRNI9wOyCVWZvbpLdm0EW
         kNiDTlecP0kbUTZejm1+xQx+KmUhVi8HUqTVmgyYewUC0XG+jw1avCXOvxqWcJ0g8FV+
         J5ZQX2TG44xowvAYKwoQ3Jd8uNKftZ7KKv4HCjhQnFkMsN1aSNhosQEls0DBo1N2xeZh
         ppCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MFC7ZrTHVjwb63g4iKPsNbd6SOoQy4xSM3XRyK+OSFQ=;
        b=IK+Ckskp10rIaq9nsOf73p2FoJqnor64eaS95TUJipn5mv9J1j947AMmE6JFPEzZ3h
         Z6OfAjItG8L1LHgm06gZdJI/klU/SUzJWGL1UePFQ7Jwq6MSVc21Myox3fh9Gs1L5qAY
         2x4Lm9zXJ6/awCIcmj1a9HzH/6R+t9GC3u0hzMaThrxcqHGwYqbuwtRe7rWGbovThNAX
         2thTmLm3pWBBpMpBgVOGEfmR40M7/RiRSABFK/LpwDuNrFx7yOnqwb82n/WvlnSsOLmG
         uTiToSGVvEKbYnzd59cn4fKi1BNU+PrxtmNoOJzRWnHCEy+p+ee8dDHtdNwsOHZA/lKq
         6BkQ==
X-Gm-Message-State: AIkVDXLOM2BHRAlNYcfDncKPA13EZeKZwT5P/EULEstZ8DZpefvJbWJTtaL2kZncLya8TQ==
X-Received: by 10.28.226.139 with SMTP id z133mr41205942wmg.139.1483006238970;
        Thu, 29 Dec 2016 02:10:38 -0800 (PST)
Received: from [192.168.0.185] (HSI-KBW-085-216-063-243.hsi.kabelbw.de. [85.216.63.243])
        by smtp.gmail.com with ESMTPSA id t194sm45309286wmd.1.2016.12.29.02.10.38
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Dec 2016 02:10:38 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Dec 2016, #08; Tue, 27)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqy3z155o1.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 29 Dec 2016 11:10:37 +0100
Cc:     git <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9E13F972-F374-4126-A599-A8A7618D4AF3@gmail.com>
References: <xmqqy3z155o1.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>, bmwill@google.com
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 28 Dec 2016, at 00:11, Junio C Hamano <gitster@pobox.com> wrote:
>=20
>=20
> * bw/realpath-wo-chdir (2016-12-22) 5 commits
>  (merged to 'next' on 2016-12-22 at fea8fa870f)
> + real_path: canonicalize directory separators in root parts
> + real_path: have callers use real_pathdup and strbuf_realpath
> + real_path: create real_pathdup
> + real_path: convert real_path_internal to strbuf_realpath
> + real_path: resolve symlinks by hand
> (this branch is used by bw/grep-recurse-submodules.)
>=20
> The implementation of "real_path()" was to go there with chdir(2)
> and call getcwd(3), but this obviously wouldn't be usable in a
> threaded environment.  Rewrite it to manually resolve relative
> paths including symbolic links in path components.

"real_path: resolve symlinks by hand" (05b458c) introduces
"MAXSYMLINKS" which is already defined on macOS in

/usr/include/sys/param.h:197:9:

 * .., MAXSYMLINKS defines the
 * maximum number of symbolic links that may be expanded in a path name.
 * It should be set high enough to allow all legitimate uses, but halt
 * infinite loops reasonably quickly.
 */


Log with JS: https://travis-ci.org/git/git/jobs/187092215
Log without JS: =
https://s3.amazonaws.com/archive.travis-ci.org/jobs/187092215/log.txt

- Lars

