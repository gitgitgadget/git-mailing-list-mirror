Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A6B3202A7
	for <e@80x24.org>; Fri, 30 Jun 2017 05:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751696AbdF3FWw (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 01:22:52 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35496 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751333AbdF3FWv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 01:22:51 -0400
Received: by mail-pf0-f181.google.com with SMTP id c73so61354304pfk.2
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 22:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=01Vk3Q5gWMc2/RCqCZD8VTKD405ictVqKuLAPMotRjs=;
        b=I9hb5HhDTz0rFgq1cbzh2K/sAUZhouEGtmGhNKR8t2/noYqT1z1WRqfWFfyO5poHHb
         LJr4N7M27s8jxyEivvVytFQIpTvV++a+TANL/Bx+3SGr9bxvMFzkdf2omiU9PJDmPCOO
         61l9zgVkTQdXHZdvvfyiU4hbLa6GRuB5Dfs/UCjtyMEk0QQbd5U2fS9YbhO/gjQlGemd
         V4y12DTg2skYvP0ZODbfl3aIcGZLazm3MAl9F8hs6bzZLbUu6mmBeD3l2rTRUN51Y5Jn
         U9Pm7xJqKvGX4Z/EJ/i3NGrjlLJA6BNWwCnOBwqH+bLUHHRp17tyocBA61YATyPE/igZ
         f4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=01Vk3Q5gWMc2/RCqCZD8VTKD405ictVqKuLAPMotRjs=;
        b=acm9UzdP3mdwbU1cE/PcZTQlgb3mYQenhlxorGiP3crU195r8BtBvzHsrtmibItO7z
         faDdGGsRW/oyqtKpOiTRJwrfDuqUrmcpcV4U7+37En9m+AqpRFdCIAKE+EA01+fKmn9n
         5obKGUlyYnaSUSkSoRWdXIKa++tCewmKLydptCoS7pJ38mEyESSMxjnpHsbVvupYzWHu
         1L9a3Z/kaNB2P8DMWG+j2kUmnVCao/ggM4SOLCFIdjxEp/9eeuqaDxIuA45/A2uyxtsl
         ODxcArXPEuBRXU5gWJ6y2XIHjHYAhd31ORqzhAIuvoxRf4hOv9bRVEjnQr1cPSpaZU9G
         WeSw==
X-Gm-Message-State: AKS2vOwe9AJm36LMj5+HVElNtG+F3tbZJNBQIw79puLnN1mxuJUY8SoA
        jIKVwlY93vO5DfUsKBOCY70g5hNagdZcmTE=
X-Received: by 10.98.19.136 with SMTP id 8mr20295439pft.105.1498800170890;
 Thu, 29 Jun 2017 22:22:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Thu, 29 Jun 2017 22:22:50 -0700 (PDT)
In-Reply-To: <SY3PR01MB050601CFAFEFDEFFF51CD26FC8D30@SY3PR01MB0506.ausprd01.prod.outlook.com>
References: <SY3PR01MB050601CFAFEFDEFFF51CD26FC8D30@SY3PR01MB0506.ausprd01.prod.outlook.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 29 Jun 2017 22:22:50 -0700
Message-ID: <CAGZ79kYB1DXgY8Xh0+FKG6yHQVLz_8gxdE0BRp5O8h_GBnNZGw@mail.gmail.com>
Subject: Re: git-gui: Error on restoring defaults
To:     Samuel Leslie <sdl@nexiom.net>,
        Pat Thoyts <patthoyts@users.sourceforge.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+cc Pat who maintains git-gui

On Thu, Jun 29, 2017 at 6:13 PM, Samuel Leslie <sdl@nexiom.net> wrote:
> Hi there,
>
> When selecting =E2=80=9CRestore Defaults=E2=80=9D in the Options dialogue=
 via the Edit -> Options menu the following application error is received:
>
> window name "!paving" already exists in parent
>     while executing
> "ttk::frame $w.!paving"
>     (procedure "pave_toplevel" line 4)
>     invoked from within
> "pave_toplevel ."
>     (procedure "apply_config" line 37)
>     invoked from within
> "apply_config"
>     (procedure "do_restore_defaults" line 14)
>     invoked from within
> "do_restore_defaults"
>     invoked from within
> ".options_editor.buttons.restore invoke "
>     invoked from within
> ".options_editor.buttons.restore instate !disabled { .options_editor.butt=
ons.restore invoke } "
>     invoked from within
> ".options_editor.buttons.restore instate pressed { .options_editor.button=
s.restore state !pressed; .options_editor.buttons.restore instate !disabled=
 { ..."
>     (command bound to event)
>
> Tested using Git Gui 0.21 as included with Git 2.13.2 x64 on Windows x64.=
 Also tested on a Windows VM with a clean install of Git.
>
>
> Kind regards,
> Samuel Leslie
>
