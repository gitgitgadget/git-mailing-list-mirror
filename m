Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AED8209F1
	for <e@80x24.org>; Thu,  6 Apr 2017 08:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756495AbdDFI4A (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 04:56:00 -0400
Received: from mout.gmx.net ([212.227.15.15]:53002 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755233AbdDFIzk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 04:55:40 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MHHZT-1crQU70epv-00E4UQ; Thu, 06
 Apr 2017 10:55:20 +0200
Date:   Thu, 6 Apr 2017 10:55:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] Fix stack-use-after-scope error reported by ASAN by
 GCC 7.
In-Reply-To: <072afb58-6159-ddeb-b7dc-40a87e8c6ae7@suse.cz>
Message-ID: <alpine.DEB.2.20.1704061051130.4268@virtualbox>
References: <072afb58-6159-ddeb-b7dc-40a87e8c6ae7@suse.cz>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-2047997368-1491468735=:4268"
Content-ID: <alpine.DEB.2.20.1704061052280.4268@virtualbox>
X-Provags-ID: V03:K0:GqyK2GNTOlTo0z3EVgEhkPUePwezqRdsu5H0xRlOh2zfvmeMttP
 m6GwAmYvDo6eUSNFZE/3CAZWdCjfejlRxp8dfUOOMjHZlHhqQpo4Ocpc2XFuDH2cilGGNVZ
 8ownbm4Mzn9aLjWQhfUiHr6IqWUqkf+6JVLJSqyOYq8b1AXLrLeBnciSJE/QuReFY2np4nY
 7EV1Ks+TLyVVfHnSCP1LA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:e4kuC8SdgrI=:zs9P8l+GXyz/1r0G/wViRL
 zv0jrn8x86m1/VDIxxXkT4YGhd//h99CzGA5hYFubMZ01DBa976HL/NqXi/ul5bqCT1xagElR
 jhNRKscueEnpFdLjE4gqI+1OG1FwycHH02JXebu5T55JIJ2YHVeH4tq4s5C2RfJ/ng8QLY4a1
 W4G55BiM0/1/ZP1b5vnzKbH0zvCA/8lHznQnx2z+dPoiIy5HZHpGXmK82RIDFtBHeeLWNFbYq
 NqGaOtmGdvYMoBZ5AFAq75Ka0666UP6jjN6MAnskbxYWwmUnsiRkAak7chcRfyO/j1PVVOFhs
 NsonjAZAXm4PoRtXeDfvvHST3bQS5/gKdj+vpyUxUs1JRR8Nxwej03WrLx9gGbD2Q2f+Hjj2i
 YkVSXUXt+jP4In+p+6mGhM6fQ4uyVJe8ljQY4L9beB/cBQ1plAZzh01hUz+VetPkOFRr1/4VL
 /1VHYg7sdLIHMwFFA5wH5YHfiCUgXtDVyVUwQrbLsefnvkNGQolrlpKM2VsXWSSUvcZYdLaY8
 dLgBebBzDKMNT0uxFCFIs3+DZK8KyADa3WsRJUxA/MeCVeOrMOHFzSo5ar73IiUVyQNrO+YuV
 sSbJSI/hRYMbBOU8TRb318hLOejdRhy5YGCNP1MIl4k1iAsPUn8RpnvHH4GAf+F1Q1qUjzhaY
 K8ySox0URgtNCyfA5/rhw7ePJKUmh4i+L6HmWquL6OKwOSOYzrMEqeX6Y84EVE9X/n0pIN05G
 Z0Qdlh13olYG9iAr/O2mEmprg4/m2QEewPlPQtY0lFzi02nuZmHCx3F0sAAM0ysvvXoiWbLC2
 umCEp3b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2047997368-1491468735=:4268
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.20.1704061052281.4268@virtualbox>

Hi Martin,

On Thu, 6 Apr 2017, Martin Li=C5=A1ka wrote:

> Following patch fixes issues that can be seen with -fsanitize=3Daddress o=
n
> GCC 7.

Good catch.

However, it may make more sense to switch to using the "args" field
instead of the "argv" field: it is of type "struct argv_array" and is
released automagically by finish_command().

In other words, you would use something like

@@ -600,7 +601,8 @@ static struct cmd2process
*start_multi_file_filter(struct hashmap *hashmap, cons
        process =3D &entry->process;

        child_process_init(process);
-       process->argv =3D argv;
+=09argv_array_push(&process->args, cmd);

instead, making even for a nice LOC reduction.

Ciao,
Johannes
--8323329-2047997368-1491468735=:4268--
