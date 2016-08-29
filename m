Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D45471F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 07:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756621AbcH2HP5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 03:15:57 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:33964 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751201AbcH2HP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 03:15:56 -0400
Received: by mail-it0-f41.google.com with SMTP id e63so14780112ith.1
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 00:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xPhhMh5ud/UgSbac3fUiGhQ63WN8YXKJU6ZPEi5BFA8=;
        b=MzmLSLT97sofT9YkwWbYYr2angR70XtMfy/kRAP0QzlN/9v29aZlm2J0sjPB+nOjJG
         N47f4cLBRNN8rKbZu0BaCadvpnAkzbaUN9oB9bPaPTRRJZ41ote+Zostyp5E18E2PTzJ
         OgqbAyue2OAcvC3GPQBwQXjkSUoeEOszdOqupPDhKzNswsITg1BXM086Y2GNjTV7ALN+
         ZWyPHcHg+WHmYfwvw9lir6uzZYJ4gTKVnhxE0pLuEvLASEDwadkgX368hU4gv1nX+hLt
         DIkqCjWzDuTx7UBX9CWm7u3DND0nKj/TKLOMJwgN4OLnoD8UxSFVP9e6ELcdszniFdPP
         lxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xPhhMh5ud/UgSbac3fUiGhQ63WN8YXKJU6ZPEi5BFA8=;
        b=QB3L67MjJg1mAOx2uAGbokHO8RttBaEjZqMpe/Cf31JrsdJwXDAI9WxyU/ZvrJzTaS
         MsOD0zrUtyZcJa2rpr9M/QyvWCHaPG4Kl+MFaZOSn6gzun1lBR8k6OANW1y3Va9E/FB0
         SL84qRW20ORME6KR4tN7E8lpaNl2AtTs2D1Olb5Nr9bysOexybuuN+vqH5FAGeuN5lgG
         9I6GuBCBy6TN/ADKgrXCBFgBIiSeTJRDgz1ZQiocnR7DKbFy0+wqzfWdPfVCrSfGnyFD
         psL6e6M1cM/Hb9w0R9AYwBgVHAMAs9fqyXF8ZM3AOQGqMUEu4b1wkze5yJwDQaWDC67V
         IENg==
X-Gm-Message-State: AE9vXwMTN6b2MdEySGJ3Gbcu6nzTyIQqp9ae1BezH0zU6dV1gGx5lpG6qgaGC6wxP/2G9qiYNeOaB+RwBC3v1Q==
X-Received: by 10.36.118.193 with SMTP id z184mr13562770itb.9.1472454956006;
 Mon, 29 Aug 2016 00:15:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.168.71 with HTTP; Mon, 29 Aug 2016 00:15:35 -0700 (PDT)
In-Reply-To: <20160829050547.sv4rslwp2ocehvgx@sigill.intra.peff.net>
References: <CAKUcBEDwbZ7aLsa2w4dqNCRg3QQMo_2hm7-O-6o0Fg58ANYv=A@mail.gmail.com>
 <20160829050547.sv4rslwp2ocehvgx@sigill.intra.peff.net>
From:   "Jean-Marc B. van Schendel" <jeanmarc.vanschendel@gmail.com>
Date:   Mon, 29 Aug 2016 09:15:35 +0200
Message-ID: <CAKUcBEAmaALBQT9YdgCRcCBeALKJ1QTHtcVSDRWvMLQwrGFSHg@mail.gmail.com>
Subject: Re: Suspected Bug in git install procedure [ git-daemon-run (version
 1:2.9.3-1) ]
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the reply...
Indeed there was a problem with the runit package (2.1.2-5), which
_should_ have created /etc/system/ as a link to (in my case)
/etc/runit/runsvdir/current ...
Upgrading to runit 2.1.2-6 clears this off.

Regards

--jmbvs
Jean-Marc B. van Schendel
email: jeanmarc.vanschendel@gmail.com
voice: +32.(0)474.70.3885
msn: jmbvs@hotmail.com


On Mon, Aug 29, 2016 at 7:05 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Aug 29, 2016 at 06:29:04AM +0200, Jean-Marc B. van Schendel wrote:
>
>> Symptoms:
>> On a fresh new install of Debian "Stretch" (8.5 alpha7, dated 2016-06-30),
>> Trying to install a subset of Git packages (roughly, all those listed
>> in git-all, except CVS-related packages)
>> Install of package git-daemon-run (version 1:2.9.3-1) fails, dpkg
>> reporting error
>
> The git-daemon-run package is entirely a Debian creation, and has more
> to do with "runit" than it does with "git daemon" itself. In particular,
> your problem:
>
>> Assumed cause:
>> The directory /etc/service does not exist, and the install procedure
>> does not create it, subsequently fails to create a symlink (git-daemon
>> --> /etc/sv/git-daemon)
>
> looks like it's about the system runit setup. I didn't dig, but it's
> probably related to:
>
>   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=834087
>
> -Peff
