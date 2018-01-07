Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D7E11F428
	for <e@80x24.org>; Sun,  7 Jan 2018 09:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752630AbeAGJik (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 04:38:40 -0500
Received: from mout.web.de ([217.72.192.78]:63687 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752396AbeAGJih (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 04:38:37 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MCZh8-1ehQoU3ucc-009QJG; Sun, 07
 Jan 2018 10:38:17 +0100
Date:   Sun, 7 Jan 2018 10:38:15 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, gitster@pobox.com, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3 0/7] convert: add support for different encodings
Message-ID: <20180107093815.GA7442@tor.lan>
References: <20180106004808.77513-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180106004808.77513-1-lars.schneider@autodesk.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:2su+DH4HTz7HvS2L72uUcXVJPyFYJvTVUgBC3OLuig7Es1XwtbL
 /sqYStbIsCA5C5a7k35Xz6XaU6enCq8+/jY8wCChvwn9FaUXh/abzuz95R9WS7kAYQ2eW2j
 25wltVo4mht8I9jhtVik0CyHppJ9l8hTwgGb4tDVFjM4+pCmSnqEhBHyRQE7wC389Cx+o7D
 Wc0NT6RCc9xWgzQx7nJew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oxLCtYpym0s=:2JVCNGP1qvCXdU2q6gZ26N
 rP8rSIrgcPnXRg8givIE9jB98l/urHQ++9wtkClvKwY0RrwiR8O1+aS078PkwYMXRhkH/VSF0
 nsdfCBdOYLIbXhE9plfBZhJ0zmFenxWAoL3h30tk2h6mV6MI0aPhzk894GHDqtJMf5ZlYCn/t
 /gUhCFzfrv8LGB/JOl7PhUo7/zBLO9ogj5zxCbfprhisqxkXfNK4FAyC1sdEqzjmCYgU7hF+Y
 QA+kL8Q71xo6YjjNUhcrNnfDCO6wdgq8h+glxOLWbVpyU/im/fsS2e6sIRykTopvZFf9AZyQG
 OPhkhUkW5M6AU0gmvfYQo9cRD8/6eoMExa+UXVozelvmbKgx8g3A3//PElygAmA8rojN1rzs7
 lhzLu1JzGztp3euyDYC/voQ5m5Tl5Nei/wZVLiDzj9UQtERuW2SR1iq14R8AVRgUCvOFUcz3/
 aJw1cqbol3Mv7MD7qgVSs+REwvOILNYQRoEUdx0NTUeeJoxwiaaV2PjAeDqDf4u+Rx0M4rpXa
 YjaC4U8k85e5QPzjPw/X2tdiYEZ/K0y8JYk0pvc+msNJamRxd+nwq7DG5QlEbE19beyWyVJ28
 FSPjCKwybPt0d65+lrsB526ZtelYHzE9sSJCuDfqPGzeEIIZOXpCXrxnN8HXZvKutKuJvvszl
 +YU1ZHxcbL008RHoxB/6BB5adiGKTSfi/jImV0ycsxxc2FrERCE0FMgCyxCJnsJFq5BHksjK0
 ZgFgN6eIU1YJgDeUOXgz16EgeUuIyxWHXpqBYU7XlnUiqQv/vY+1d1bXGSVEutIuMHt7oB0dn
 uV7fiUiTxO06AoRom5beduUivI0Qw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 06, 2018 at 01:48:01AM +0100, lars.schneider@autodesk.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Hi,
> 
> Patches 1-5 and 6 are helper functions and preparation.
> Patch 6 is the actual change.
> 
> I am still torn between "checkout-encoding" and "working-tree-encoding"
> as attribute name. I am happy to hear arguments for/against one or the
> other.

checkout-encoding is probably misleading, as it is even the checkin-encoding.

What is wrong with working-tree-encoding ?
I think the 2 "-".

What was wrong with workingtree-encoding ?
Or
workdir-encoding ?



> 
> Changes since v2:
> 
> * Added Torsten's crlfsave refactoring patch (patch 5)
>   @Torsten: I tried to make the commit message more clean, added
>             some comments to and renamed conv_flags_eol to
>             global_conv_flags_eol.
> 
> * Improved documentation and commit message (Torsten)

Good, thanks.
> 
> * Removed unnecessary NUL assignment in xstrdup_tolower() (Torsten)
> 
> * Set "git config core.eol lf" to made the test run on Windows (Dscho)
> 
> * Made BOM arrays static (Ramsay)


Some comments:

I would like to have the CRLF conversion a little bit more strict -
many users tend to set core.autocrlf=true or write "* text=auto"
in the .gitattributes.
Reading all the effort about BOM markers and UTF-16LE, I think there
should ne some effort to make the line endings round trip.
Therefore I changed convert.c to demand that the "text" attribute
is set to enable CRLF conversions.
(If I had submitted the patch, I would have demanded
"text eol=lf" or "text eol=crlf", but the test case t0028 indicates
that there is a demand to produce line endings as configured in core.eol)

Anyway, I rebased it onto git.git/master, changed the docu, and pushed it to
https://github.com/tboegi/git/tree/180107-0935-For-lars-schneider-encode-V3B

Here is a inter-diff against your version:

 diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
 index 1bc03e69c..b8d9f91c8 100644
 --- a/Documentation/gitattributes.txt
 +++ b/Documentation/gitattributes.txt
 @@ -281,7 +281,7 @@ interpreted as binary and consequently built-in Git text processing
  tools (e.g. 'git diff') as well as most Git web front ends do not
  visualize the content.
  
 -In these cases you can teach Git the encoding of a file in the working
 +In these cases you can tell Git the encoding of a file in the working
  directory with the `checkout-encoding` attribute. If a file with this
  attributes is added to Git, then Git reencodes the content from the
  specified encoding to UTF-8 and stores the result in its internal data
 @@ -308,17 +308,20 @@ Use the `checkout-encoding` attribute only if you cannot store a file in
  UTF-8 encoding and if you want Git to be able to process the content as
  text.
  
 +Note that when `checkout-encoding` is defined, by default the line
 +endings are not converted. `text=auto` and core.autocrlf are ignored.
 +Set the `text` attribute to enable CRLF conversions.
 +
  Use the following attributes if your '*.txt' files are UTF-16 encoded
 -with byte order mark (BOM) and you want Git to perform automatic line
 -ending conversion based on your platform.
 +with byte order mark (BOM).
  
  ------------------------
 -*.txt		text checkout-encoding=UTF-16
 +*.txt		checkout-encoding=UTF-16
  ------------------------
  
  Use the following attributes if your '*.txt' files are UTF-16 little
 -endian encoded without BOM and you want Git to use Windows line endings
 -in the working directory.
 +endian encoded without BOM and you want Git to use LF in the repo and
 +CRLF in the working directory.
  
  ------------------------
  *.txt 		checkout-encoding=UTF-16LE text eol=CRLF
 diff --git a/convert.c b/convert.c
 index 13f766d2a..1e29f515e 100644
 --- a/convert.c
 +++ b/convert.c
 @@ -221,18 +221,27 @@ static void check_global_conv_flags_eol(const char *path, enum crlf_action crlf_
  	}
  }
  
  
  static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
 @@ -432,7 +441,7 @@ static int crlf_to_git(const struct index_state *istate,
  		 * cherry-pick.
  		 */
  		if ((!(conv_flags & CONV_EOL_RENORMALIZE)) &&
 -		    has_cr_in_index(istate, path))
 +		    has_crlf_in_index(istate, path))
  			convert_crlf_into_lf = 0;
  	}
  	if (((conv_flags & CONV_EOL_RNDTRP_WARN) ||
 @@ -1214,9 +1223,28 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
  			ca->crlf_action = git_path_check_crlf(ccheck + 0);
  		ca->ident = git_path_check_ident(ccheck + 1);
  		ca->drv = git_path_check_convert(ccheck + 2);
 +		ca->checkout_encoding = git_path_check_encoding(ccheck + 5);
  		if (ca->crlf_action != CRLF_BINARY) {
  			enum eol eol_attr = git_path_check_eol(ccheck + 3);
 -			if (ca->crlf_action == CRLF_AUTO && eol_attr == EOL_LF)
 +			if (ca->checkout_encoding) {
 +				enum crlf_action crlf_action = CRLF_BINARY;
 +				/*
 +				 * encoded files don't use auto.
 +				 * 'text' must be specified to
 +				 * do crlf conversions
 +				 */
 +				if (ca->crlf_action == CRLF_TEXT) {
 +					if (eol_attr == EOL_LF)
 +						crlf_action = CRLF_TEXT_INPUT;
 +					else if (eol_attr == EOL_CRLF)
 +						crlf_action = CRLF_TEXT_CRLF;
 +					else if (text_eol_is_crlf())
 +						crlf_action = CRLF_TEXT_CRLF;
 +					else
 +						crlf_action = CRLF_TEXT_INPUT;
 +				}
 +				ca->crlf_action = crlf_action;
 +			} else if (ca->crlf_action == CRLF_AUTO && eol_attr == EOL_LF)
  				ca->crlf_action = CRLF_AUTO_INPUT;
  			else if (ca->crlf_action == CRLF_AUTO && eol_attr == EOL_CRLF)
  				ca->crlf_action = CRLF_AUTO_CRLF;
 @@ -1225,11 +1253,11 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
  			else if (eol_attr == EOL_CRLF)
  				ca->crlf_action = CRLF_TEXT_CRLF;
  		}
 -		ca->checkout_encoding = git_path_check_encoding(ccheck + 5);
  	} else {
  		ca->drv = NULL;
  		ca->crlf_action = CRLF_UNDEFINED;
  		ca->ident = 0;
 +		ca->checkout_encoding = NULL;
  	}
  
  	/* Save attr and make a decision for action */


