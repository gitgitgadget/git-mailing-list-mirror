Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 347081F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 22:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933997AbcJQWqD (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 18:46:03 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:36094 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933629AbcJQWqC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 18:46:02 -0400
Received: by mail-io0-f182.google.com with SMTP id j37so204160520ioo.3
        for <git@vger.kernel.org>; Mon, 17 Oct 2016 15:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=co60mz+kfU994imtqotHLDEZ4TOyWB2JNPOrizao1yY=;
        b=WCeZWQKRW1gH+TzndESbm0N/cjMbi/+STFKgDo5zX6pJUSZvPghEFhsZORKmrQavy/
         ihFnoGDk7RKmuta0HAkZquzr5LJYZBT3Zy0j3FtH6DCnA24Lpw0VF/5ez9/LPTjfgLRH
         6rjK0W3/kaq1Yk7FsrkIMCztARKzeUekX6tlYnJGonfjw2JmYs89XvxXtF1MUAuziRr7
         qqABLJC/CREWEn9lAO+0069hLvBclcmHo5ulSGRIpAAbG1J76UYBcFZEMBl7tIs5CiyA
         n1q8jUPBLNYpuqzu6M3tpUlDuU1z7Fvc5DGww3cTYQdRgwJu6ADVDgmnqQ8BwnXt03tO
         xEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=co60mz+kfU994imtqotHLDEZ4TOyWB2JNPOrizao1yY=;
        b=I64XgAKKIM3SzAqXp7LZqfm4zIKAnI7c5DJtIIjpItgJxk+dPaqjuzdXpFlL3AxBeN
         HVnfnxOx8FVInq6mleVVLbrgW3pdNYwSpfmhrgfZgvChNgySk8S+ZH9QjL67/0Z/Dgfj
         VUywfT3PnCJxaQ7Y2GnIgcjdFczmrbNHvE3r6IjpMo9uy6JqhiHM7BIjkh468MsFN05R
         EsrzubavI4oKIR9bEaq9cKds15DtTiR8wYwpD71voD+EtchFbeLfzIiLPBsnHHt0K0xG
         0v50K/6ashzZO2TtPUipQQGmeU648cWgJIUAL+gvlfva2y9lyAsHI01x7EYodNorbOUd
         Yn9w==
X-Gm-Message-State: AA6/9RnyR7VRiRiHad+c/fRa16JmNJYbeLZ8U2GNYCjl79+DFzY1quru1rW4x9wgJIRxP2kvYJwJQWCDgwGxAA==
X-Received: by 10.107.53.166 with SMTP id k38mr26319677ioo.74.1476744361329;
 Mon, 17 Oct 2016 15:46:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.38.215 with HTTP; Mon, 17 Oct 2016 15:46:00 -0700 (PDT)
In-Reply-To: <xmqqtwcasj8y.fsf@gitster.mtv.corp.google.com>
References: <xmqqtwcasj8y.fsf@gitster.mtv.corp.google.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Tue, 18 Oct 2016 04:16:00 +0530
Message-ID: <CAFZEwPOvpddh5tZmX1ETv=wmuwwyQSt2zjbnvq9eDg5vghDAog@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2016, #04; Mon, 17)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Junio,

On Tue, Oct 18, 2016 at 3:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * pb/bisect (2016-10-14) 28 commits
>  - SQUASH???
>  - bisect--helper: remove the dequote in bisect_start()
>  - bisect--helper: retire `--bisect-auto-next` subcommand
>  - bisect--helper: retire `--bisect-autostart` subcommand
>  - bisect--helper: retire `--bisect-write` subcommand
>  - bisect--helper: `bisect_replay` shell function in C
>  - bisect--helper: `bisect_log` shell function in C
>  - bisect--helper: retire `--write-terms` subcommand
>  - bisect--helper: retire `--check-expected-revs` subcommand
>  - bisect--helper: `bisect_state` & `bisect_head` shell function in C
>  - bisect--helper: `bisect_autostart` shell function in C
>  - bisect--helper: retire `--next-all` subcommand
>  - bisect--helper: retire `--bisect-clean-state` subcommand
>  - bisect--helper: `bisect_next` and `bisect_auto_next` shell function in C
>  - t6030: no cleanup with bad merge base
>  - bisect--helper: `bisect_start` shell function partially in C
>  - bisect--helper: `get_terms` & `bisect_terms` shell function in C
>  - bisect--helper: `bisect_next_check` & bisect_voc shell function in C
>  - bisect--helper: `check_and_set_terms` shell function in C
>  - bisect--helper: `bisect_write` shell function in C
>  - bisect--helper: `is_expected_rev` & `check_expected_revs` shell function in C
>  - bisect--helper: `bisect_reset` shell function in C
>  - wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
>  - t6030: explicitly test for bisection cleanup
>  - bisect--helper: `bisect_clean_state` shell function in C
>  - bisect--helper: `write_terms` shell function in C
>  - bisect: rewrite `check_term_format` shell function in C
>  - bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
>
>  GSoC "bisect" topic.

You could squash your commit. Thanks!

Regards,
Pranit Bauva
