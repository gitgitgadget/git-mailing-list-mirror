Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA1BC433E0
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 12:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C355064E86
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 12:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhCOMXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 08:23:10 -0400
Received: from mout.gmx.net ([212.227.15.19]:56159 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229862AbhCOMWj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 08:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615810947;
        bh=uJCixA8YreFuNfWnGJl6LwApOoYyEh0s114cDx526YQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Jh/n+VdjQB/klLMMVfUS+n9vTiTe55f2ujMYIM7iNOmT9iBjW+GRaIW9qk8jtoaGD
         Hpz2sNT2MjxglIATN/YyLpa8c4TNlsUFwYnsU2jRLGPA4e8D8KRUhISdtFaJ55Tlzo
         HUJG/3NkMSqNh2Mi6oPeaU5TIUqjxYj/D8UqCOtI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.201.226] ([213.196.212.127]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Ygz-1lIlIm0SAl-0039Au; Mon, 15
 Mar 2021 13:22:27 +0100
Date:   Mon, 15 Mar 2021 04:23:16 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe=2E?= <l.s.r@web.de>
cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] vcs-svn: remove header files as well
In-Reply-To: <b937922d-8b56-c333-3f76-6e17a28210e3@web.de>
Message-ID: <nycvar.QRO.7.76.6.2103150421520.50@tvgsbejvaqbjf.bet>
References: <b937922d-8b56-c333-3f76-6e17a28210e3@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1068085971-1615778597=:50"
X-Provags-ID: V03:K1:Vy0V6bksT5HKvWM7vQ+hNc1eafd/4vLG5HS1nzWE71As9hja7Hm
 U/OS3vn2DsRd6dRyA4msFCZHNZKBhbGL8hm4Jm+FJVi3hanUlv2jlDaiBdS51nZAgYvEUjP
 3vuusHPisbAVKyokRCX6a0gd1f3fSlCMcUGisqyx/SfyBFx7swHA2v0S7njLv4FRFdJgZFC
 poPsXACsdjWphpHVlVEYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p8gEaC8YZeA=:yt0CZXHjVHG5mIxq3Ih3+B
 nCm2E+8AyhDFn7ieERr6+4TtZoG9WGHKf4+6JuCvTLJ7zTX9L30BkyzaUSvDRlWfl2LsNdukE
 8qMWer4NiOaZ3ZRoWesNWyT+ECVuYNm50Yu5oeBkvpDXIrAepdde1YNamnXxF3E1xb+kM1/sI
 QyJxdnzKVvgtQR7ra2WusFcZWlkIr6FV9MXQRMC0+PnEsNHZiU8KmLcWLP/aMd7yn7f7ZrkM3
 JcAysIjVqXOFtryd8R88VdoT6JqWcQcQjLuZbD4YHSIhaIa9sEIq14YfgtrueC3kFF899zWx+
 TmL49A1JUUX3ZmMBUfh3D9XybgHbZVuWHKdjzUNeBv3NQ0/YhaE8lGLY8rcsOoW8496oyG+tE
 5W6mB9YB6N0lds7JwC4cNt6jfNy6Velzl3inHy48s5po5IDOcBiCIa1IEZKwdih3ItH1kDa4C
 zg1qxHtlFHtHhJP0Z8bZDWK22Kcd/Niq+r0N72wLcZ/+e91YczVagoIN4pxuENDBypQ2V17FL
 FDMZiOJGREksg7my9ZQkq5iMSYRbGZgkHZytTRv8EmlSdtbu0ffqdERpe9T9plACt8zfDHuX7
 RpRHII63sa/FPtHqwp7QD/pwUPHM9iHXyNYQt1V9cbYaOxJ3Ar4zaKsF861NjXu8RZa7ekf+j
 HOMmTHmmQuAPS34YAb9DNbmAFzjtpA81EWgioXOZk6BaXSzVy/qd/mCy+k8mhJ3XHHfWLpNgy
 xrpsxBOwKMRlIqXliSIRT3J13GqJViwrKakUQmarfq1/D31qccwVGxkIEUSDygBgBGZC/llR/
 Vl0ZDwy7lByd7WMrYNzUVOvkhchKowdAexVlCyZpys+EW4yjRrBm0WhyYzIXJG146Ns5T10ZB
 psE7Y+pcTcncAU2W+Z0zSIr20fAl5TC8S2rCqFX1s=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1068085971-1615778597=:50
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ren=C3=A9,

On Sun, 14 Mar 2021, Ren=C3=A9 Scharfe. wrote:

> fc47391e24 (drop vcs-svn experiment, 2020-08-13) removed most vcs-svn
> files.  Drop the remaining header files as well, as they are no longer
> used.

While it is sad to say good-bye to the last chance of replacing the Perl
script `git-svn` with anything that works with less problems on Windows, I
agree it is the right thing to do.

Thanks,
Dscho

>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  vcs-svn/fast_export.h    | 34 ----------------------------------
>  vcs-svn/line_buffer.h    | 30 ------------------------------
>  vcs-svn/sliding_window.h | 18 ------------------
>  vcs-svn/svndiff.h        | 10 ----------
>  vcs-svn/svndump.h        | 10 ----------
>  5 files changed, 102 deletions(-)
>  delete mode 100644 vcs-svn/fast_export.h
>  delete mode 100644 vcs-svn/line_buffer.h
>  delete mode 100644 vcs-svn/sliding_window.h
>  delete mode 100644 vcs-svn/svndiff.h
>  delete mode 100644 vcs-svn/svndump.h
>
> diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
> deleted file mode 100644
> index 9dcf9337c1..0000000000
> --- a/vcs-svn/fast_export.h
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -#ifndef FAST_EXPORT_H
> -#define FAST_EXPORT_H
> -
> -struct strbuf;
> -struct line_buffer;
> -
> -void fast_export_init(int fd);
> -void fast_export_deinit(void);
> -
> -void fast_export_delete(const char *path);
> -void fast_export_modify(const char *path, uint32_t mode, const char *da=
taref);
> -void fast_export_note(const char *committish, const char *dataref);
> -void fast_export_begin_note(uint32_t revision, const char *author,
> -		const char *log, timestamp_t timestamp, const char *note_ref);
> -void fast_export_begin_commit(uint32_t revision, const char *author,
> -			const struct strbuf *log, const char *uuid,const char *url,
> -			timestamp_t timestamp, const char *local_ref);
> -void fast_export_end_commit(uint32_t revision);
> -void fast_export_data(uint32_t mode, off_t len, struct line_buffer *inp=
ut);
> -void fast_export_buf_to_data(const struct strbuf *data);
> -void fast_export_blob_delta(uint32_t mode,
> -			uint32_t old_mode, const char *old_data,
> -			off_t len, struct line_buffer *input);
> -
> -/* If there is no such file at that rev, returns -1, errno =3D=3D ENOEN=
T. */
> -int fast_export_ls_rev(uint32_t rev, const char *path,
> -			uint32_t *mode_out, struct strbuf *dataref_out);
> -int fast_export_ls(const char *path,
> -			uint32_t *mode_out, struct strbuf *dataref_out);
> -
> -void fast_export_copy(uint32_t revision, const char *src, const char *d=
st);
> -const char *fast_export_read_path(const char *path, uint32_t *mode_out)=
;
> -
> -#endif
> diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
> deleted file mode 100644
> index e192aedea2..0000000000
> --- a/vcs-svn/line_buffer.h
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -#ifndef LINE_BUFFER_H
> -#define LINE_BUFFER_H
> -
> -#include "strbuf.h"
> -
> -#define LINE_BUFFER_LEN 10000
> -
> -struct line_buffer {
> -	char line_buffer[LINE_BUFFER_LEN];
> -	FILE *infile;
> -};
> -#define LINE_BUFFER_INIT { "", NULL }
> -
> -int buffer_init(struct line_buffer *buf, const char *filename);
> -int buffer_fdinit(struct line_buffer *buf, int fd);
> -int buffer_deinit(struct line_buffer *buf);
> -
> -int buffer_tmpfile_init(struct line_buffer *buf);
> -FILE *buffer_tmpfile_rewind(struct line_buffer *buf);	/* prepare to wri=
te. */
> -long buffer_tmpfile_prepare_to_read(struct line_buffer *buf);
> -
> -int buffer_ferror(struct line_buffer *buf);
> -char *buffer_read_line(struct line_buffer *buf);
> -int buffer_read_char(struct line_buffer *buf);
> -size_t buffer_read_binary(struct line_buffer *buf, struct strbuf *sb, s=
ize_t len);
> -/* Returns number of bytes read (not necessarily written). */
> -off_t buffer_copy_bytes(struct line_buffer *buf, off_t len);
> -off_t buffer_skip_bytes(struct line_buffer *buf, off_t len);
> -
> -#endif
> diff --git a/vcs-svn/sliding_window.h b/vcs-svn/sliding_window.h
> deleted file mode 100644
> index a7fc0999cb..0000000000
> --- a/vcs-svn/sliding_window.h
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -#ifndef SLIDING_WINDOW_H
> -#define SLIDING_WINDOW_H
> -
> -#include "strbuf.h"
> -
> -struct sliding_view {
> -	struct line_buffer *file;
> -	off_t off;
> -	size_t width;
> -	off_t max_off;	/* -1 means unlimited */
> -	struct strbuf buf;
> -};
> -
> -#define SLIDING_VIEW_INIT(input, len)	{ (input), 0, 0, (len), STRBUF_IN=
IT }
> -
> -int move_window(struct sliding_view *view, off_t off, size_t width);
> -
> -#endif
> diff --git a/vcs-svn/svndiff.h b/vcs-svn/svndiff.h
> deleted file mode 100644
> index 625d950bb8..0000000000
> --- a/vcs-svn/svndiff.h
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -#ifndef SVNDIFF_H
> -#define SVNDIFF_H
> -
> -struct line_buffer;
> -struct sliding_view;
> -
> -int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
> -		   struct sliding_view *preimage, FILE *postimage);
> -
> -#endif
> diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
> deleted file mode 100644
> index 26faed5968..0000000000
> --- a/vcs-svn/svndump.h
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -#ifndef SVNDUMP_H
> -#define SVNDUMP_H
> -
> -int svndump_init(const char *filename);
> -int svndump_init_fd(int in_fd, int back_fd);
> -void svndump_read(const char *url, const char *local_ref, const char *n=
otes_ref);
> -void svndump_deinit(void);
> -void svndump_reset(void);
> -
> -#endif
> --
> 2.30.2
>
>

--8323328-1068085971-1615778597=:50--
