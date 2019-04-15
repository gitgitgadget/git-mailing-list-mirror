Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92CF120248
	for <e@80x24.org>; Mon, 15 Apr 2019 13:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbfDONUj (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 09:20:39 -0400
Received: from mout.gmx.net ([212.227.17.22]:38985 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbfDONUj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 09:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555334431;
        bh=jNs8jmIFDuN0ABQ4309S3mojslApKZZ/zknDFcSSgEg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OKr3VPgZTH8xafR5L66yJfLEe2zEMCTnlyXAq4zZ3nGWbEFhjiN6gKBJ80cCXzjbk
         PeXx+Wmyz+eVHfJRjrwikPyW3uBOATg+da8q51NJARJ9mjeLApL8doK7VVrkNNbKX6
         1EiKilNm0kDJ/cdZbeSSoTKchwaNSRLpbTVIZTK0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MACmL-1h9k0t3uMD-00BKnU; Mon, 15
 Apr 2019 15:20:31 +0200
Date:   Mon, 15 Apr 2019 15:20:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     dstolee@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: Re: [PATCH v3* 11/33] commit.c: add repo_get_commit_tree()
In-Reply-To: <20190413101600.713-1-pclouds@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904151518530.44@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1904121624160.41@tvgsbejvaqbjf.bet> <20190413101600.713-1-pclouds@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-940565927-1555334433=:44"
X-Provags-ID: V03:K1:K2Q2aGdsbsWsTIe0p0ZbUpds48jVobJhD7LwlCKUz/9Sxh7JZ7c
 Vm7YazHof2nVlK2Y2PR9qP4Z+ldYtxPC9/4DdgUU3oHb3pz6ySMKGsaA7qJnEtp+07kdI3Y
 TpCsALjTkfAFRyV/iB2Zq4tJkRV0js0ymxDPIxf3nHd2VAkjv5J4jysnqhs34gUteTDoVIi
 Fg1xYANPszfNQQ6O74ALw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZV9nLJNOuwY=:pb8iNtdobZ6kNUcl9bDv1T
 xGyc7XoJAVv+D/z+NgvPRd7W345jefx9+BtAXFrDPFSvO/JkFfkU10NBCniB0xYnf8RVTPP+u
 VH7xNma6UmM5PDp3/sm74og5iY8+jxRi+9Z+a1nHFVzZw2AMktP8xcxA2OxRfZ09KfhtwyuzW
 HG283u+ng3LU+ErjIY74orn5o0b7AEA8WxmP3LsKzkqnpe2pzoB66mUq5/VmMZw8tMzGK3+iU
 l09WmjaYNRtPy6EoPbCe6AVP9+umWAoTrNoIe03SA148i8FP+xFQ/7IPILiTXECBFHyrt9Oi9
 cxvXHY9Xpk8k8+gS4or44a8K3Ph9npe3eUI+PoKPZSAWl5kkw6eQHi4OG5kJmZfEQsWUleQBq
 ygveheKrc2ciERB8PwkoOXG1ceMTwY6RYzrlmObKNt3OLGAf3npDG0uDlXRIGEGp0lkSlqTFj
 jHcL0NxVTbsnanwI7RXtZiZqTkWcmhRROOq17ga/+CBNT+GJWYCdC76ThUtTUO1rEBiF6rn0P
 /pMlFU1VfIhepl3Jx0ED2rlIUM7BR32RW2lpwxeuJkFgsJ8IJrlpEpozAY7MCf5fa9j49X9kp
 3X9M0C+kCupH+Nulbi14fPG87BZFlUAxOKQ1rmzgD9vDj27iL4BHhr4o57ZAJDGstrPi/IgrM
 lFw2r3OPJDt0qHUZqNczk8qecKwKKEkc8v7eFErJnzyUIdto5yzk61VSPnJ3+h50oyVOqyVSO
 BoURHnNHqqe+dzhmzZeCdCGNhu2AEa7UytukCWUoivJKg4iqwNnhWwWtyVoKqX6FOG4cRYrlj
 tiJUlcYkyML2gDxdIGNSPXrmybMRVClZg2We6/riQvRxIyfwMOgc4XhPwU7ZlZUw19p6Wjeq4
 muZOR0QlI7ZP0si7k4lMRFgQQl2gqa0q58Q5uyavD9A5HBLDxp/zoL2AlUI1pG+K/aO+j8cb2
 /Je3wTkLObQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-940565927-1555334433=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Duy,

On Sat, 13 Apr 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> diff --git a/commit.h b/commit.h
> index 42728c2906..7342727e46 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -143,9 +143,15 @@ void repo_unuse_commit_buffer(struct repository *r,
>  struct object_id *get_commit_tree_oid(const struct commit *);
>
> +static inline void set_commit_tree(struct commit *c, struct tree *t)
> +{
> +	c->maybe_tree =3D t;
> +}
> +
>  /*

I head *really* hoped that we could keep this function file-local, i.e.
`static` *inside* the relevant file(s). Kind of making this a "private" or
"protected" function, if you know what I mean.

Ciao,
Johannes

--8323328-940565927-1555334433=:44--
