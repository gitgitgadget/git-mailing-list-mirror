Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C310E1F576
	for <e@80x24.org>; Sat, 10 Feb 2018 09:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751002AbeBJJtM (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 04:49:12 -0500
Received: from mout.web.de ([212.227.15.3]:44821 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750909AbeBJJtL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 04:49:11 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MEqOg-1eUYoe2Yqg-00G1Ym; Sat, 10
 Feb 2018 10:48:54 +0100
Date:   Sat, 10 Feb 2018 10:48:52 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, gitster@pobox.com, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v6 5/7] convert: add 'working-tree-encoding' attribute
Message-ID: <20180210094852.GB11525@tor.lan>
References: <20180209132830.55385-1-lars.schneider@autodesk.com>
 <20180209132830.55385-6-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209132830.55385-6-lars.schneider@autodesk.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:Udz7yQTUWdH7JOr0IoD9OVUB+jE/AUhOBEnzP7KltKr8goSz6hw
 0RPdthanalg5lebpicYN1ZBeymwhIDGEHgbNgNh9sjNq73Gg1GWWA8DgnjEvAZ+PT9tu/oO
 NI2yQ0weg6r94yAAl6Fuu4cL0NYAEA0SVN5EbQRUCNEls94kaYesWt5BTILY6AhxTKtT8ss
 7hVTtTpTeXVBDk+F7hAOw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Sz7o6WgatXE=:MX3rtiyajFhG53lQAN+xaC
 9E05UPjlmT084GfrI6+rAWRRVWoVS+ljdZjTF3tUIjBnGHLzBa0iQWyhxEfZ8QvidQqCHurRZ
 Pw33L/B+reOId+IK3zRkj0HFJdVRDonIhEcndtGDGgYlPYgJc6MAGsw3wK+QuMjZDnvFjICNm
 lSQeV+30BysSLmJ49DArEbd9/SXz+ShjPX2NBc/Vk/pCYJGJZwMQiTwYCH+LZabJ8GwHurBs2
 P7/QRfglQghH4SbhMVgzX6n8sRurmxWrWn1jD2LKiT0E0xzXbzaNnaRFgWY7+Gr44lSreMhqg
 rBWN0r2aiAiMmA5dR3h0/2glga7peQeYcccoOJ4PmvfGTxyzQrn40Yj1c9Me4jx2GNTeev9Lv
 H/S02iOMsB0gRI+o0S73Yx5CvGRh+TSO4NasCxOyufIIiTq62YT2TtMuEDMfjVoJZxljM8i5l
 rOgab94G6Oldcr8qE/R+oZR0bopW0WeRrBh2a0zU+R3J/mJtVciPdD0O3mISb8sxOzzk0XGIe
 Hy2Q91I5dDIqksfFluPIFXdT6rFVqdznUZOyflpjOaJXJatOenPz95xpjMWutg+Gv7ydJuKTb
 lbqO8v5kJF2YqZrZuHW9n1nNwKqrKXiEOxS6lB6GIahecGEOXHxsTjsroTPEsnO8elgNCouWV
 aEjftvUXglA4TKbJpZzojHQhIhxQLsCWC4X4LvH6vU6ZsqumgeO3cgmOUtwCp4fcCA/IzAxH8
 Cn2oqWwnlSDFnGGA57PIKrdMarRkLlmzPf3ThspTR/CICUOxa0OBon4E67f0fT3d5gBGoTXb/
 pbgo9Ph0aeLBrOfPExrMB6jdUO5AQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 09, 2018 at 02:28:28PM +0100, lars.schneider@autodesk.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Git recognizes files encoded with ASCII or one of its supersets (e.g.
> UTF-8 or ISO-8859-1) as text files. All other encodings are usually
> interpreted as binary and consequently built-in Git text processing
> tools (e.g. 'git diff') as well as most Git web front ends do not
> visualize the content.
> 
> Add an attribute to tell Git what encoding the user has defined for a
> given file. If the content is added to the index, then Git converts the
> content to a canonical UTF-8 representation. On checkout Git will
> reverse the conversion.
> 
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  Documentation/gitattributes.txt  |  66 ++++++++++++
>  convert.c                        | 157 ++++++++++++++++++++++++++++-
>  convert.h                        |   1 +
>  sha1_file.c                      |   2 +-
>  t/t0028-working-tree-encoding.sh | 210 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 434 insertions(+), 2 deletions(-)
>  create mode 100755 t/t0028-working-tree-encoding.sh
> 
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 30687de81a..4ecdcd4859 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -272,6 +272,72 @@ few exceptions.  Even though...
>    catch potential problems early, safety triggers.
>  
>  
> +`working-tree-encoding`
> +^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Git recognizes files encoded with ASCII or one of its supersets (e.g.
> +UTF-8 or ISO-8859-1) as text files.  All other encodings are usually
> +interpreted as binary and consequently built-in Git text processing
> +tools (e.g. 'git diff') as well as most Git web front ends do not
> +visualize the content.
> +
> +In these cases you can tell Git the encoding of a file in the working
> +directory with the `working-tree-encoding` attribute. If a file with this
> +attribute is added to Git, then Git reencodes the content from the
> +specified encoding to UTF-8. Finally, Git stores the UTF-8 encoded
> +content in its internal data structure (called "the index"). On checkout
> +the content is reencoded back to the specified encoding.
> +
> +Please note that using the `working-tree-encoding` attribute may have a
> +number of pitfalls:
> +
> +- Git clients that do not support the `working-tree-encoding` attribute

A client to Git ?
Or may be "third party Git implementations"

> +  will checkout the respective files UTF-8 encoded and not in the
> +  expected encoding. Consequently, these files will appear different
> +  which typically causes trouble. This is in particular the case for
> +  older Git versions and alternative Git implementations such as JGit
> +  or libgit2 (as of February 2018).
> +
> +- Reencoding content requires resources that might slow down certain
> +  Git operations (e.g 'git checkout' or 'git add').
> +
> +Use the `working-tree-encoding` attribute only if you cannot store a file
> +in UTF-8 encoding and if you want Git to be able to process the content
> +as text.
> +
> +As an example, use the following attributes if your '*.proj' files are
> +UTF-16 encoded with byte order mark (BOM) and you want Git to perform
> +automatic line ending conversion based on your platform.
> +
> +------------------------
> +*.proj		text working-tree-encoding=UTF-16
> +------------------------
> +
> +Use the following attributes if your '*.proj' files are UTF-16 little
> +endian encoded without BOM and you want Git to use Windows line endings
> +in the working directory. Please note, it is highly recommended to
> +explicitly define the line endings with `eol` if the `working-tree-encoding`
> +attribute is used to avoid ambiguity.
> +
> +------------------------
> +*.proj 		working-tree-encoding=UTF-16LE text eol=CRLF
> +------------------------
> +
> +You can get a list of all available encodings on your platform with the
> +following command:

One question:
 +*.proj		text working-tree-encoding=UTF-16
vs
*.proj 		working-tree-encoding=UTF-16LE text eol=CRLF

Technically the order of attributes doesn't matter, but that is not what we
want to demonstrate here and now.
I would probably move the "text" attribute to the end of the line.
So that readers don't start to wonder if the order is important.

> +
> +------------------------
> +iconv --list
> +------------------------
> +
> +If you do not know the encoding of a file, then you can use the `file`
> +command to guess the encoding:
> +
> +------------------------
> +file foo.proj
> +------------------------
> +
> +
>  `ident`
>  ^^^^^^^
>  
> diff --git a/convert.c b/convert.c
> index b976eb968c..dc9e2db6b5 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -7,6 +7,7 @@
>  #include "sigchain.h"
>  #include "pkt-line.h"
>  #include "sub-process.h"
> +#include "utf8.h"
>  
>  /*
>   * convert.c - convert a file when checking it out and checking it in.
> @@ -265,6 +266,110 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
>  
>  }
>  
> +static struct encoding {
> +	const char *name;
> +	struct encoding *next;
> +} *encoding, **encoding_tail;
> +static const char *default_encoding = "UTF-8";
> +
> +static int encode_to_git(const char *path, const char *src, size_t src_len,
> +			 struct strbuf *buf, struct encoding *enc, int conv_flags)
> +{
> +	char *dst;
> +	int dst_len;
> +
> +	/*
> +	 * No encoding is specified or there is nothing to encode.
> +	 * Tell the caller that the content was not modified.
> +	 */
> +	if (!enc || (src && !src_len))
> +		return 0;
> +
> +	/*
> +	 * Looks like we got called from "would_convert_to_git()".
> +	 * This means Git wants to know if it would encode (= modify!)
> +	 * the content. Let's answer with "yes", since an encoding was
> +	 * specified.
> +	 */
> +	if (!buf && !src)
> +		return 1;
> +
> +	if (has_prohibited_utf_bom(enc->name, src, src_len)) {
> +		const char *error_msg = _(
> +			"BOM is prohibited for '%s' if encoded as %s");
> +		const char *advise_msg = _(
> +			"You told Git to treat '%s' as %s. A byte order mark "
> +			"(BOM) is prohibited with this encoding. Either use "
> +			"%.6s as working tree encoding or remove the BOM from the "
> +			"file.");

"You told Git" is probly right from Gits point of view, and advises are really helpfull.
But what should the user do about it ?
Could we give a better advise ?


"A byte order mark (BOM) is prohibited with %s.
Please remove the BOM from the file %s 
or use "%s as working-tree-encoding"

I would probably suspect that a tool wrote the BOM, and that is
good and can or should not be changed by a user.

So a simply message like this could be the preferred (and only)
solution for a user:
"A byte order mark (BOM) is prohibited with %s.
Please use "%s as working-tree-encoding"


(And why %.6s and not simply %s ?)

No more comments for now, I didn't review the test cases.
