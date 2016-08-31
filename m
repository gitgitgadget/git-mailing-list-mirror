Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BF0E1F859
	for <e@80x24.org>; Wed, 31 Aug 2016 20:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759047AbcHaUcS (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 16:32:18 -0400
Received: from mout.gmx.net ([212.227.15.15]:62608 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758116AbcHaUcR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 16:32:17 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MIMQR-1bfSM61GJz-00495t; Wed, 31 Aug 2016 22:31:57
 +0200
Date:   Wed, 31 Aug 2016 22:31:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/4] cat-file: introduce the --filters option
In-Reply-To: <xmqqmvk2qcv8.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608312153030.129229@virtualbox>
References: <cover.1471524357.git.johannes.schindelin@gmx.de> <cover.1472041389.git.johannes.schindelin@gmx.de> <320f5e862e8df12bbd1d918f0b347aeacbd25d17.1472041389.git.johannes.schindelin@gmx.de> <xmqqmvk2qcv8.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:iNzc7d2mZwgEy7QVR6VP/eQnnYGE4+kUfDJWzlvUtJ6LqwKWEG+
 fxmWYKKJewrObxUqAzxRr+s7dd0BnCfrH8bcxMxN4a19vjZg2gVa+PaUwfXStcEkC8SJVgD
 ixsbbouVMgA4l9vIhSyvL/Tk8XgNb4SCnSVjGDkPAeKSTWwZCgbi/uO6Hc1TZQ9/pcdwLv6
 Q+4W7PrOh3O538FKESDjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:v2n2ejS1JFQ=:LyeiymichHcTqiTkGZcRBP
 WA1zDYUVun+Qi7iXIjv0O3ooO/jl+DeHbYiJTmiB6+hGHftjCvA8cgdSRcYEl6BpycCUZw3Y2
 03fmJv/vhz1lONB5lcXLN9ezA1Es5/j2M+IkTXxdQN4zgvlssEwhGU3MA8ZDFDE16/pC8m/Um
 7VhkC5ZMaXV9WHjxI8EicYeEX6yD2WtUBbVwqX44ksdU+vNFrzdc/VJTtpQJQ7wqeftQFrG4g
 3Mf9cu05W1qtiBpPndMitW/t7qHBgz5Dhq/4gYZkfu3wOa6OYCOnAU0jNy6ClQ96x2xan3e8d
 79sfzJWyrACLH20EKgysm42eWV6OWVdDv1A16y9/x9h8wkaDpNc4DuBV+hjI474x5lpWaGB5N
 2Fxp7UnV4gPlCGoFpKRuP7uEzqTEuBCeswvPmA9UdNguLJxlGB9+tToLUUv6W62dcJR1lBqxG
 PnRDjl2SIdZw1ZqPFcj0Yalvv7hQfMfWFLfM5gWVLOCUIpPISsy9WNBqyqRC/n4i39KeJqfIk
 zA1/L+6JcF2jtBBGAbRPP9Q7VKCMiBCKUGgv3UykBcZo6O/+7EzZoYHIiHZYRUeEdHW+HRp5O
 JuaDuKIv6bQaDSvdW341WMnv1twFeOUT2pEAUQHojSX4TxTIa2d+/EeTQo+CfhI8GYWrty7JH
 GfN5gvWNXfVKi8Ab0PZwcMTB13TVYpGQ1cYQu6LULnFaJAs7me17CsBRdWN+Vfa4XIwgzWqhk
 RhPBhhnZ42VdEfAkLcdXQ58FFPlabpTaIBUoNn8AoDs+CUQwRoMDcpyXOBw0n6iiacY9L9BkF
 ZgXLsB8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 24 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > +static int filter_object(const char *path, unsigned mode,
> > +			 const unsigned char *sha1,
> > +			 char **buf, unsigned long *size)
> > +{
> > +	enum object_type type;
> > +
> > +	*buf = read_sha1_file(sha1, &type, size);
> > +	if (!*buf)
> > +		return error(_("cannot read object %s '%s'"),
> > +			sha1_to_hex(sha1), path);
> > +	if (type != OBJ_BLOB) {
> > +		free(*buf);
> > +		return error(_("blob expected for %s '%s'"),
> > +			sha1_to_hex(sha1), path);
> > +	}
> > +	if (S_ISREG(mode)) {
> > +		struct strbuf strbuf = STRBUF_INIT;
> > +		if (convert_to_working_tree(path, *buf, *size, &strbuf)) {
> > +			free(*buf);
> > +			*size = strbuf.len;
> > +			*buf = strbuf_detach(&strbuf, NULL);
> > +		}
> > +	}
> 
> When we see a blob that is not ISREG, what is expected to happen?
> Is it an error?

This is not a user-facing command, therefore we have to trust the caller
that they know what they are doing.

And it is quite conceivable that a caller wants to simply apply filters
whenever a blob is specified, and simply not apply any filters when
something else was specified.

That would be in line with specifying the --filters options on a path for
which no filters are configured: the --filters option is basically a
no-op, then.

> In any case, silently succeeding without any output is probably what
> the end-user least expects.

Except that 1) the command is not for an end-user, and 2) when calling
`git cat-file --filters HEAD:directory/` the command does not silently
succeed:

	error: blob expected for <sha-1> 'directory/'

> If we choose to fail the request, the necessary update to the test
> would look like this, I think.

Quite frankly, as cat-file is not an end-user-facing command, I think it
is serious overkill to add more testing here.

Ciao,
Dscho
