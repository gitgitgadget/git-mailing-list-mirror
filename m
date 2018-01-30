Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A69C71F404
	for <e@80x24.org>; Tue, 30 Jan 2018 14:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752842AbeA3OkQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 09:40:16 -0500
Received: from mout.web.de ([212.227.15.14]:62460 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752834AbeA3OkO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 09:40:14 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LegAQ-1f6Izi0WY2-00qSAP; Tue, 30
 Jan 2018 15:40:04 +0100
Date:   Tue, 30 Jan 2018 15:40:02 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH/RFC v5 7/7] Careful with CRLF when using e.g. UTF-16 for
 working-tree-encoding
Message-ID: <20180130144002.GA30211@tor.lan>
References: <xmqqshawfgaa.fsf@gitster.mtv.corp.google.com>
 <20180129201911.9484-1-tboegi@web.de>
 <55B6C3D5-4131-4636-AD0E-20759EDBE8CD@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55B6C3D5-4131-4636-AD0E-20759EDBE8CD@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:7bu58FS0cJNHd4L1ybEV1lqmFEWe2Jn0ecp1HW0b+Jo76Sw5rs1
 XtCT7GS+z16i1+kOzzCJxXPFGTXSH6+iCmwPSGm+bDuwv9+2n+U8TBDoqjB5Qj8JCy9l/cW
 QrkCuj9AKz137C5fY3fZiEpCI0EhBYapZqhr14Xi57BQ62hpCMnqp8LN2UB5sAOhiH9qJQZ
 vT0PLJpdiaMPcwQwqXVlw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qdXj9ttWzoE=:k9VyJlTHDmwtjy/mtuaIdg
 VfLY8vlcdNzl9csBUtPjcc1WMN8CdX+HplU5hNFxKGiEA197ZlwANSRliGryBxAiRIfT7Jvan
 +yYtEnidQmyV/9g2sRfJYTDtLb2pAjVzovIfAMYCg1NW82ymClqXc+g7cuncrsOW8c/IdIJMm
 7CoOOEFx2E5D6XjT5X2cOKHfQGCIvKb1qInwLV/l3vDFL0dExUU9RPt+tyegm0aXu0y9iHu8r
 c0zUiiz0/y/mXC++aAupXNWIVN4nwmorCuXJL1t53E7uuJYwLCwa0LYKMTzLIlcd1Yjrsq0Yp
 DkndBMM+7IDep0onkwott+PCiZnkjci3Go79/GtjcpBw9ZrXc+ycRvCOYNAfMNlqo7UANdTiL
 /Abk63tEogbhei/0Wla6Rw6etCnGAsa+rQ+wxDNkP/4P7RYA5iMLjLbJe6KK2mPhlb+kO2p4t
 MKMpIAXsNuXQ5X41gEHI7cT+WfG1VE6oEi33CqmiUJawM0L/vsmA3HKqZ+nDmU6bTmzPqLU91
 5vhqIbkOOOwhJ7SZvOeuYTePrbKSY7+zge3wlmDyFqLwvG0J9uMWxdIPjYKhb4Kno5LUX23IC
 5M5PrYFU/oNziswqNHemJHmnFjCaEaSaqMtR0jEKc6L6k7x7SusiGabY2cgms/toffiH/TjAb
 VzNPEjUh3g9wKNAGzhL/NkBgbEb4bv0Wz4QOLwIn6U/7rzgVp5ewhEUMn4G+c/nKlyeCq9SZa
 Xg1JBXZEImVQNax4ZoO3jnn8x+aQaOc1FbXYK+s4/AyqvoWd6v1Rd1VM4OQe5skwaNznwh6oP
 iYICCs9wUbjddmhqwMrm+tP+a41eg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 30, 2018 at 12:23:47PM +0100, Lars Schneider wrote:
> 
> > On 29 Jan 2018, at 21:19, tboegi@web.de wrote:
> > 
> > From: Torsten Bögershausen <tboegi@web.de>
> > 
> > UTF-16 encoded files are treated as "binary" by Git, and no CRLF
> > conversion is done.
> > When the UTF-16 encoded files are converted into UF-8 using the new
> s/UF-8/UTF-8/
> 
> 
> > "working-tree-encoding", the CRLF are converted if core.autocrlf is true.
> > 
> > This may lead to confusion:
> > A tool writes an UTF-16 encoded file with CRLF.
> > The file is commited with core.autocrlf=true, the CLRF are converted into LF.
> > The repo is pushed somewhere and cloned by a different user, who has
> > decided to use core.autocrlf=false.
> > He uses the same tool, and now the CRLF are not there as expected, but LF,
> > make the file useless for the tool.
> > 
> > Avoid this (possible) confusion by ignoring core.autocrlf for all files
> > which have "working-tree-encoding" defined.
> 
> Maybe I don't understand your use case but I think this will generate even 
> more confusion because that's not what I would expect as a user. I think Git 
> should behave consistently independent of the used encoding. Here are my arguments:

To start with: I have probably seen too many repos with CRLF messed up.

> 
>   (1) Legacy users are *not* affected. If you don't use the "working-tree-encoding"
>       attribute then nothing changes for you.

People who don't use "working-tree-encoding" are not affected,
I never ment to state that.

I am thinking about people who use "working-tree-encoding" without thinking
about line endings.
Or the ones that have in mind that core.autocrlf=true will leave the
line endings for UTF-16 encoded files as is, but that changes as soon as they
are converted into UTF-8 and the "auto" check is now done
-after- the conversion. I would find that confusing.

> 
>   (2) If you use the "working-tree-encoding" attribute *and* you want to ensure 
>       your file keeps CRLF then you can define that in the attributes too. E.g.:
>       
>       *.proj textworking-tree-encoding=UTF-16 eol=crlf

That is a good one.
If you ever plan a re-roll (I don't at the moment) the *.proj extemsion
make much more sense in Documentation/gitattributes that *.tx
There no text files encoded in UTF-16 wich are called xxx.txt, but those
are non-ideal examples. *.proj makes good sense as an example.


> 
> - Lars
> 
> 
> 
> > The user can still use a .gitattributes file and specify the line endings
> > like "text=auto", "text", or "text eol=crlf" and let that .gitattribute
> > file travel together with push and clone.
> > 
> > Change convert.c to e more careful, simplify the initialization when
> > attributes are retrived (and none are specified) and update the documentation.
> > 
> > Signed-off-by: Torsten Bögershausen <tboegi@web.de>
> > ---
> > Documentation/gitattributes.txt |  9 ++++++---
> > convert.c                       | 15 ++++++++++++---
> > 2 files changed, 18 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> > index a8dbf4be3..3665c4677 100644
> > --- a/Documentation/gitattributes.txt
> > +++ b/Documentation/gitattributes.txt
> > @@ -308,12 +308,15 @@ Use the `working-tree-encoding` attribute only if you cannot store a file in
> > UTF-8 encoding and if you want Git to be able to process the content as
> > text.
> > 
> > +Note that when `working-tree-encoding` is defined, core.autocrlf is ignored.
> > +Set the `text` attribute (or `text=auto`) to enable CRLF conversions.
> > +
> > Use the following attributes if your '*.txt' files are UTF-16 encoded
> > -with byte order mark (BOM) and you want Git to perform automatic line
> > -ending conversion based on your platform.
> > +with byte order mark (BOM) and you want Git to perform line
> > +ending conversion based on core.eol.
> > 
> > ------------------------
> > -*.txt		text working-tree-encoding=UTF-16
> > +*.txt		working-tree-encoding=UTF-16 text
> > ------------------------
> > 
> > Use the following attributes if your '*.txt' files are UTF-16 little
> > diff --git a/convert.c b/convert.c
> > index 13fad490c..e7f11d1db 100644
> > --- a/convert.c
> > +++ b/convert.c
> > @@ -1264,15 +1264,24 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
> > 		}
> > 		ca->checkout_encoding = git_path_check_encoding(ccheck + 5);
> > 	} else {
> > -		ca->drv = NULL;
> > -		ca->crlf_action = CRLF_UNDEFINED;
> > -		ca->ident = 0;
> > +		memset(ca, 0, sizeof(*ca));
> > 	}
> > 
> > 	/* Save attr and make a decision for action */
> > 	ca->attr_action = ca->crlf_action;
> > 	if (ca->crlf_action == CRLF_TEXT)
> > 		ca->crlf_action = text_eol_is_crlf() ? CRLF_TEXT_CRLF : CRLF_TEXT_INPUT;
> > +	/*
> > +	 * Often UTF-16 encoded files are read and written by programs which
> > +	 * really need CRLF, and it is important to keep the CRLF "as is" when
> > +	 * files are committed with core.autocrlf=true and the repo is pushed.
> > +	 * The CRLF would be converted into LF when the repo is cloned to
> > +	 * a machine with core.autocrlf=false.
> > +	 * Obey the "text" and "eol" attributes and be independent on the
> > +	 * local core.autocrlf for all "encoded" files.
> > +	 */
> > +	if ((ca->crlf_action == CRLF_UNDEFINED) && ca->checkout_encoding)
> > +		ca->crlf_action = CRLF_BINARY;
> > 	if (ca->crlf_action == CRLF_UNDEFINED && auto_crlf == AUTO_CRLF_FALSE)
> > 		ca->crlf_action = CRLF_BINARY;
> > 	if (ca->crlf_action == CRLF_UNDEFINED && auto_crlf == AUTO_CRLF_TRUE)
> > -- 
> > 2.16.0.rc0.2.g64d3e4d0cc.dirty
> > 
> 
