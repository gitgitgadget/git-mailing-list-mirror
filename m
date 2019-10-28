Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 448D91F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 15:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389855AbfJ1PoJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 11:44:09 -0400
Received: from mout.gmx.net ([212.227.15.19]:45411 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfJ1PoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 11:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572277446;
        bh=sTUku6v8mL+k2L9A8l2I9JjZ37e16wrzBToB6QjtWhw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=imjbhPLVvXjnbc+G+HaaNKV8NdovU/LBoQRXIlpj/HKtuPhOFlHJXHZYdyD5Fr0nO
         eneWQsQH7tK4R1u8OhEEZuhHm/+YamTxbdlwefDnHCfMwOK9DeLnKtLePKCQugpcpm
         5M0JgsmVmkaVt1GkzqKxGkKYSJYfB9m4LbT7XLZg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLR1V-1ifxcE3nlr-00IRCB; Mon, 28
 Oct 2019 16:44:06 +0100
Date:   Mon, 28 Oct 2019 16:43:50 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 7/9] bugreport: add packed object summary
In-Reply-To: <20191025025129.250049-8-emilyshaffer@google.com>
Message-ID: <nycvar.QRO.7.76.6.1910281608170.46@tvgsbejvaqbjf.bet>
References: <20191025025129.250049-1-emilyshaffer@google.com> <20191025025129.250049-8-emilyshaffer@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qb0aXpnfRDf9kN/bMoP4xz8d2hrUJOvVkEBsO5SUbbnoUAw0PK7
 HTpyNenf2p8h91HfRqfxcMkVHK9Z8KUThBXyHWJUr1yEj/CXtjzXxajvzfYjshC/KP0toYl
 b2FUQ1H1c2Cg9Ls2J+OjQN0Alh8u1b7flPhPsZC02vof5OhHsApKPhovx2aD2Vr7Pex48/7
 u51I0oylZjDfWuOkOECvg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fB6V4cj7A0o=:3WQANM+Tp/98QubDaBvDYW
 9reo6Ku1f33eg1MunNi7vrc/Idjti7ZmnICVT1SMDJ4ZcaFq86/gVuLvdBqOo+xNALqibG8B2
 XaV1uN5q5MKlVymrK+w5uglfyTiOSYJKmAAYgjAM7e7pSsMHVG3QLBa0uR6voDtkUsDbUSIFm
 r6eexHBddMnK+QykO9BrWx+fxlkpled7w9SzmBuW/+/KtYyy6q60kQXuRrZLSYx7KyhSdQZ/Z
 vPnJUTotqfn2Tt6ozShj9DEXlJwOBJGSj6vQq6GzanJbOa1nK43uZhjIxpvVACKyG1OTfbLSo
 MVOcDoEwaKsSc8o8nyQTyDilC5zEzRhkmkYFTHjo0sXHqhcUw8coTcp4+OwPK+7Ug40+JPoN1
 EljqVmacz812eb24zlAaNj+Xk+kLvW/P+Uw6Qw60S9SWDy1ob/GkpoH+fFoOeFh4K2sVW3Kyf
 hOnsB8KD6HwGLRitF+2A4klVcR4H83N+Oqq/T3bcQneT2+scBkRB7SCnjyvGcaiNBJmYSyvNz
 jkjp2uqg8hBDsh8U8cxgtMnJ/2x/zJQZo66WE/gSNNQCIXntnxcCcLHCkt4EjP8R4MXiaq9Qm
 InINtgXCHPYSwYXYQHPZcCf7Bme+mwjso5C91nRSYBgJM/NE6x2ohwato9s49HVCbAsPZ+GK+
 TvkMBrKSFsWxf/qos0rGmqOUKQ560RvdOEnJrqFyLZedjOKvUQAVVNBSqvlryYRdNss4Am4c3
 1crIYncu21K7PglIBmRtzHyIosnqYf7Agk9BBSrSA9NOLERt9BvOJkH2MSAY/1QkWRkUOV7qR
 D8TOLfDIy9ZzfvVQHC48UjhorVkyzWfANShACOkwKomszywa49ImbtsVmcMViYxURHcmnvtrH
 4NgWRVPSp4RNRRhT6Pqj1+yXyjzLYfqs9pvour2KPAcakx7U+RDCgBJyoPn3tWSIYiQROkIS3
 RYTOHqDY47I1uecXypobY2NuANgrYaAs3d3m/oSdMutQx/SOcnTCQlCJ9kTiffKoTZsyh9Suf
 XC42Zf1wnmKaZJaOpdloqHITrqKCPbpyckDjgATM5wFPCoyNIimmUXklPf1lV2hQ7Ys3mbH/3
 XUj/8yRD/uDdMJfSDLjDXo/Ha9ECjEvj5Lut5KJd1e3r77C4SkT0mubG0cNHBSolM37cJ3U8B
 KO2P1X1LJB5uCP+rYh4fnyAqfIF2vuNb5+slzkzLUE/Y2xg8fgB6xcKfuxYwtxtWwDpGaDmzd
 XfTCXbafrltU+MZb6dZ8iXhV4IewbrgRSu5o9C4bgUoFVEr0y+/MfAfRExVc=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Thu, 24 Oct 2019, Emily Shaffer wrote:

> Alongside the list of loose objects, it's useful to see the list of
> object packs as well. It can help us to examine what Git did and did not
> pack.

Yes, I was write! Packs are next ;-)

>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  bugreport.c         | 21 +++++++++++++++++++++
>  bugreport.h         |  6 ++++++
>  builtin/bugreport.c |  4 ++++
>  3 files changed, 31 insertions(+)
>
> diff --git a/bugreport.c b/bugreport.c
> index 54e1d47103..79ddb8baaa 100644
> --- a/bugreport.c
> +++ b/bugreport.c
> @@ -219,3 +219,24 @@ void get_loose_object_summary(struct strbuf *obj_in=
fo)
>  			    objects.nr);
>  	}
>  }
> +
> +void get_packed_object_summary(struct strbuf *obj_info)
> +{
> +	struct strbuf dirpath =3D STRBUF_INIT;
> +	struct string_list contents =3D STRING_LIST_INIT_DUP;
> +	struct string_list_item *entry;
> +
> +	strbuf_reset(obj_info);
> +
> +	strbuf_addstr(&dirpath, get_object_directory());
> +	strbuf_complete(&dirpath, '/');
> +	strbuf_addstr(&dirpath, "pack/");
> +	list_contents_of_dir(&contents, &dirpath, 0, 0);
> +
> +	// list full contents of $GIT_OBJECT_DIRECTORY/pack/
> +	for_each_string_list_item(entry, &contents) {
> +		strbuf_addbuf(obj_info, &dirpath);
> +		strbuf_addstr(obj_info, entry->string);
> +		strbuf_complete_line(obj_info);
> +	}
> +}

Okay, but I think that you will want to discern between regular `.pack`
files, `.idx` files and `tmp_*` files.

> diff --git a/bugreport.h b/bugreport.h
> index 09ad0c2599..11ff7df41b 100644
> --- a/bugreport.h
> +++ b/bugreport.h
> @@ -24,3 +24,9 @@ void get_populated_hooks(struct strbuf *hook_info);
>   * will be discarded.
>   */
>  void get_loose_object_summary(struct strbuf *obj_info);
> +
> +/**
> + * Adds a list of the contents of '.git/objects/pack'. The previous con=
tents of
> + * hook_info will be discarded.
> + */
> +void get_packed_object_summary(struct strbuf *obj_info);
> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> index b2ab194207..da91a3944e 100644
> --- a/builtin/bugreport.c
> +++ b/builtin/bugreport.c
> @@ -68,6 +68,10 @@ int cmd_bugreport(int argc, const char **argv, const =
char *prefix)
>  	get_loose_object_summary(&buffer);
>  	strbuf_write(&buffer, report);
>
> +	add_header(report, "Packed Object Summary");
> +	get_packed_object_summary(&buffer);
> +	strbuf_write(&buffer, report);
> +

Hmm. At this point, I am unclear whether you want to write into an
`strbuf`, or directly into a `FILE *`? I would rather have only one, not
a mix.

Ciao,
Dscho

>  	fclose(report);
>
>  	launch_editor(report_path.buf, NULL, NULL);
> --
> 2.24.0.rc0.303.g954a862665-goog
>
>
