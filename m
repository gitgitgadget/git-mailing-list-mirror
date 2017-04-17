Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF67B20A04
	for <e@80x24.org>; Mon, 17 Apr 2017 20:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756218AbdDQUei (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 16:34:38 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35352 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755770AbdDQUeh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 16:34:37 -0400
Received: by mail-wr0-f194.google.com with SMTP id l44so21919129wrc.2
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 13:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=8FII6eym63qdFsf94maBnhrShdLm6tNswGXcNf20HN8=;
        b=DqSadQgTJOY8zzVyvsaI2ZEHd4eTmGg1NuT1eBRfT/6uDXYOwBoFB/IlQxwiWCFV08
         Y7N0XTH9I2obMkHBVctZ2kDJ5aVqZRK/ReJuKSF36N5yNkMqOxNRSfFdVAiW3NmFuuMe
         3RnO2kwGZItH0+B60PxCMpy3S45orkdCa526MMsNPFoPQ5k5IBElvY5v9LiBBiBDS3jN
         6idLj026e/5zNYh2cblXjHRgdIevqsFe7WXNn3o/vHsaE4Dhzbsilkqcgl2NOt3PiPOV
         PYkkjURdMFQ/muaCxoZFbmcFOoekr4j40NjUileENGTkfydPS0xEn5YxNf8h1kye6Ckm
         gWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8FII6eym63qdFsf94maBnhrShdLm6tNswGXcNf20HN8=;
        b=cxqRL2coxpkXPEN9XpeaCzyAcUcA1mp/HsWir6T2Vgq3Pp41P3lkTV7iWOnliEdn6I
         m3IfGqEet3CL19kKPoBi25yt50NpdmIaiOHrRn0eV5kjU8T5ghbfQdTCNRyr1QdErrbu
         0jcH06Ryi9EF8V+hgbKSLJmAEwjQadkQsBik0QGucsilFKkVHVsB3odpza7DVwg6J9Iy
         iJKVMuw1AucBmfKOTiFvgtYD/NXLf2dZXKeUxWwef1+01u7dJGctp0+IPeldMH2tn3tH
         qCNb/cX8a+N1Npwi3PCe7f3rihaEccLfSxU4YydOQIh5TWEeaT1BtIxu4RPy7TGzOruU
         bRgg==
X-Gm-Message-State: AN3rC/4YL0tqh0WvpQ18my+zb3fkn+VoQtiJucWMloMGwSxsD2Dk9SZc
        IvtxG5Gw9GS1LYPtb2Y=
X-Received: by 10.223.171.234 with SMTP id s97mr22111271wrc.167.1492461275494;
        Mon, 17 Apr 2017 13:34:35 -0700 (PDT)
Received: from [192.168.5.102] ([87.116.181.0])
        by smtp.gmail.com with ESMTPSA id r52sm15685140wrb.37.2017.04.17.13.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Apr 2017 13:34:34 -0700 (PDT)
Subject: Re: How to keep log history when renaming and changing simultaneously
To:     Urs Thuermann <urs@isnogud.escape.de>, git@vger.kernel.org
References: <ygfpogbb711.fsf@tehran.isnogud.escape.de>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <f456df1f-cda2-4681-8f01-b693655e79a7@gmail.com>
Date:   Mon, 17 Apr 2017 22:34:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0
MIME-Version: 1.0
In-Reply-To: <ygfpogbb711.fsf@tehran.isnogud.escape.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Urs,

On 17/04/2017 13:36, Urs Thuermann wrote:
> Sometimes I need to rename and change a file in one commit.  One
> example would be a file foo.h that begins with
> 
>     #ifndef FOO_H
>     #define FOO_H
> 
> which should be renamed bar.h and have the FOO_H changed to BAR_H.
> In subversion I would
> 
>     svn mv foo.h bar.h; vi bar.h; svn ci
> 
> and then a
> 
>     svn log bar.h
> 
> also shows the history of that file when it was named foo.h.
> 
> This does not work in git.  After committing,
> 
>     git mv foo.h bar.h; vi bar.h; git commit -a
> 
> the command
> 
>     git log --follow bar.h
> 
> shows only the history of the file when it was named bar.h, but not
> its life as foo.h.
> 
> The only workaround I found was to do the rename and the change in two
> separate commits, so that git sees the same name and the same SHA hash
> which allows it to follow the files' history.  This can be a problem
> when the intermediate version with either only the change or only the
> rename doesn't compile correctly.
> 
> Is there a better way to do this in git?
> 
> A similar problem is splitting a file into two files.  With subversion
> I'd do
> 
>     printf "void foo() {}\nint main() { foo(); }\n" > prog.c
>     svn add prog.c; svn ci -m "Add prog.c"
> 
> Then I would split
> 
>     svn cp prog.c foo.c; svn cp prog.c main.c; svn rm prog.c
>     printf "2d\nwq\n" | ed foo.c; printf "1d\nwq\n" | ed main.c
>     svn ci -m "Split prog.c"; svn up
> 
> and I get
> 
>     $ svn log -v
>     ------------------------------------------------------------------------
>     r2 | urs | 2017-04-17 10:03:06 +0200 (Mon, 17 Apr 2017) | 1 line
>     Changed paths:
>        A /foo.c (from /prog.c:1)
>        A /main.c (from /prog.c:1)
>        D /prog.c
>     
>     Split prog.c
>     ------------------------------------------------------------------------
>     r1 | urs | 2017-04-17 10:02:51 +0200 (Mon, 17 Apr 2017) | 1 line
>     Changed paths:
>        A /prog.c
>     
>     Add prog.c
>     ------------------------------------------------------------------------
> 
> And I can also see this when I run svn log on one of both files.	
> How could I do this in git?

For both cases (renaming and splitting), would using `--find-copies` 
work for you? Perhaps with some low threshold value to start with, if 
the default one yields no results.

If interested, adding `--name-status` to the mix will show similarity 
percentage between old and new file(s).


For example, renaming (with edit):

    git log --follow --find-copies=10% --name-status -- bar.h

... yields something like this (sha1/author/date/message omitted 
for brevity):

    commit 2
    ...
    R034    foo.h   bar.h

    commit 1
    ...
    A       foo.h


Another example, splitting (with minor edits):

    git log --find-copies --name-status

... outputs something like this:

    commit 2
    ...
    C090    prog.c  foo.c
    R090    prog.c  main.c

    commit 1
    ...
    A       prog.c


Regards,
Buga
