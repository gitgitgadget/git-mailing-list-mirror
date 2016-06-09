From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/4] Resurrect "diff-lib.c: adjust position of i-t-a
 entries in diff"
Date: Thu, 9 Jun 2016 18:18:15 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1606091815310.2680@virtualbox>
References: <20160606111643.7122-1-pclouds@gmail.com> <20160606111643.7122-3-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1943953028-1465489096=:2680"
Cc: git@vger.kernel.org, thomas.braun@virtuell-zuhause.de
To: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 18:21:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB2hm-00073r-VC
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 18:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbcFIQVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 12:21:11 -0400
Received: from mout.gmx.net ([212.227.17.20]:56480 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932155AbcFIQVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 12:21:09 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MZwYd-1asgjZ15sl-00Lohb; Thu, 09 Jun 2016 18:21:02
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160606111643.7122-3-pclouds@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:N0pnvyYTF4Oo+0DVuKyu/sWzCKjytqmBeadzvqBpk3QNrxN5HCH
 frpfakh16EZeEqDFR/dBOXt4kI2SzoOWMPxkVm8XsnEiClfXMFzrsmUAyUvgsOYRd2/E+Lr
 DMDG//DfRIObCRwaY9XB/FjEARTVQq4YwjFIHdRNUBOlZC2t+lQ4uXhfHxLo4Yxgw9N0d5G
 blgBq3llYpyvzu5l+WmrQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gAo15lqggJE=:7tSi+iR37cVNZr6CO64fN9
 AZUvWSsz1qGbxt2Rl7LwMwjufSPQcHb/p4fQyCABdPcDPOvvmSCv1bGj6w/Fvq4pbt8IWNZ8a
 nMb9erCiN4MZTimOEYYdT2GnjBAAjNck/tmTh/LnJUM0FSjI0fmrm2LmxN9GkQLJOZrsdITy5
 YfcCcWRFkcXWFKvP8F3wAoISeSPONorKnVa9Nz/Vy/PLhhTFHVDDPXByjBgZ2ukbF3T3xqBoo
 g4RUyv8qny5Prz8PbPvnqpaEXc/lLXtPBfujXtYRzYou5JLSt8/8IWdy7jl5b/NUXHo02kmvd
 sBii/QsJknstnfxxs4i6eTn7Gmtdc0hAQS+rc/xKao52LzEYIo4DpYaVABuij6en16PtW91gA
 0rJXAv+PtbfmKlLFWWoZIr6Qe8wNMXNoYI1DxcFn3V+b4JZeUrJSx12GbVLBXWStl3qAI9oV7
 eeQ1E7orXIB84Lke8g6TD73Bo6V9BUTC7yQ1EKOxyC8egBzPcOFaYYuQDaymGx/eoeWGizlEN
 vC7vDPKOiH7JX7IiaV1VZFnHwWWF6yQsXllOCTBjqfvOnFo0KCN8YmBh55BE5ccaGyodm2jSs
 rc/X3LAVG5nO696/5cVGHb+lsGOBjxF4kc+TpkxTB+qIN61eM3RnkobD2l+WYeqOtWl+TqJAK
 qxLqA/kQxf2DCl2TR2IZPcZNdhGEosIrY+yg4SiayszLXymDbJXMOqD2SAqZvsnsCX+o0oBeX
 rKgi0/UNcEHlSW//2LzlxHj5S64joAeH9tCnxkX++CbLIXBzVx7IypjeUbOnFpJd5ygZQuwz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296900>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1943953028-1465489096=:2680
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,

On Mon, 6 Jun 2016, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> diff --git a/diff.h b/diff.h
> index b497078..9e42556 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -92,6 +92,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_=
options *opt, void *data)
>  #define DIFF_OPT_FUNCCONTEXT         (1 << 29)
>  #define DIFF_OPT_PICKAXE_IGNORE_CASE (1 << 30)
>  #define DIFF_OPT_DEFAULT_FOLLOW_RENAMES (1U << 31)
> +#define DIFF_OPT_SHIFT_INTENT_TO_ADD (1UL << 32)

I am afraid that this is not enough. On Windows, sizeof(unsigned long) is
4 (and it is perfectly legal). That means that you would have to use at
least (1ULL << 32), but then you also have to change the type of xdl_opts
to uint64_t, which in turn means that you will have to change the
definition of xpparam_t's "flags" field from unsigned long to uint64_t.

Maybe this can be avoided?

Ciao,
Johannes
--8323329-1943953028-1465489096=:2680--
