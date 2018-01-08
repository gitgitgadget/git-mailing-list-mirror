Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E32B1FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 18:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754901AbeAHSIs (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 13:08:48 -0500
Received: from mout.web.de ([212.227.15.14]:54004 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754560AbeAHSIr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 13:08:47 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LakkS-1fIdue2pGC-00kLeU; Mon, 08
 Jan 2018 19:08:28 +0100
Date:   Mon, 8 Jan 2018 19:08:26 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes.Schindelin@gmx.de,
        Patrick =?iso-8859-1?Q?L=FChne?= <patrick@luehne.de>
Subject: Re: [PATCH v3 0/7] convert: add support for different encodings
Message-ID: <20180108180826.GA16999@tor.lan>
References: <20180106004808.77513-1-lars.schneider@autodesk.com>
 <20180107093815.GA7442@tor.lan>
 <B51940E6-95AB-424A-AF62-0018E9934279@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B51940E6-95AB-424A-AF62-0018E9934279@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:BCGB7JcFnESEDlwCimYS3sMZCK2En9o38kQyg/CCiCSWlU0hBem
 JiTcdmy+LLdp448XK1LICY/rp7w9+BGirGatfLnuhoYD0XFuSwIF4+SXNloh3/ufMX8G+1t
 bCvHc6dVOBaA3rtOz+MWITNCaVIGqrQ/eA9W6GIJjTCzgjUHR8Z+B7haxTci6eEPd2xnMif
 lfw09mmrKDSZRfFAFMhgg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:u4JWOqh2ViQ=:QG7QCXVhWWejmwOLVAvRR8
 rPZMIctsen5cDcB7gfGwmCqFKqxf1lJUwxKfh2iH/lKAOrjjfg49SUH8EWOl6dNwElw9WpdUH
 9yVrn71mKCCwCTBRB+ic8uLlDiGG6bYwlYr2Ta0Xgr6Kd6OszK6VMt+/IFrWjQ2OqnMAwCM+m
 pUhw79v5ByTG+qm6OSLeuqh1Uxetp5m9mTM4vfCRKznWMiQ+yWm/Lw6xRlfvZcSx7pfl+J08U
 TzmSGzzKVmDSxsoC7/e2bvV3I7uSFEA0PPtOGmI+1YaBnfohejGeLP/4DBauzBX6T5X4FopyH
 JbEVBnI1+uZexU9y9W2WHeZwMXyRxOuhXIrNFRzDX9Ajg14+Hi1z81I4YslMBwjyvbD5U3dsx
 3g5WJNhe72u1Ve6uqoogx+D56fvWG3DH0EY2qX9L/s6yyVgEY7u89x4cV8psSZ/uQgrTIBoEg
 UyCGwc+FtOKK9JqipMRY8LzdW5Bj7jIwLspa+dRUPc5vWbM6/RitkumaYJqSzPm78ZFQQYZZS
 CG/cBgl5vXvETBkBW6BPuYv1FDyxEHYygnhT1lPWMsb+7m7rRAh5YV5C/ZZL6pnXmm4ruWXJk
 VuUsJF3ZQPvLLPjUt/koB7xcGdYiYFh3jyPPyLBgeUftkrV10M2JbyInpfbVxsnSxirRRerZ0
 SOa/3JGs7vbrfdLZK0zzbaA30FVLbsjcg3bjMe1F9W04fzuoo9E9wbu3cBd338YnPxf/nxLi5
 /vND0dRBBYEEAIhFLNq37hCY49LhrKZRb//cyIPlvYRds2rvnXh1bQKqdSMAvaBOInWYnAr03
 URMVc+rFKMPWFaefzeLZsrEfQeQig==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 08, 2018 at 03:38:48PM +0100, Lars Schneider wrote:
[]
> > Some comments:
> > 
> > I would like to have the CRLF conversion a little bit more strict -
> > many users tend to set core.autocrlf=true or write "* text=auto"
> > in the .gitattributes.
> > Reading all the effort about BOM markers and UTF-16LE, I think there
> > should ne some effort to make the line endings round trip.
> > Therefore I changed convert.c to demand that the "text" attribute
> > is set to enable CRLF conversions.
> > (If I had submitted the patch, I would have demanded
> > "text eol=lf" or "text eol=crlf", but the test case t0028 indicates
> > that there is a demand to produce line endings as configured in core.eol)
> 
> But wouldn't that be inconvenient for the users? E.g. if I add a UTF-16
> file on Windows with CRLF then it would be nice if Git would automatically
> convert the line endings to LF on Linux, no?
> 
> IOW: Why should we handle text files that have a defined checkout-encoding
> differently compared to UTF-8 encoded text files? Wouldn't that be unexpected
> to the user?
> 
> Thanks,
> Lars

The problem is, if user A has core.autocrlf=true and user B
core.autocrlf=false.
(The line endings don't show up as expected at user B)

Having said that in all shortness, you convinced me:
If text=auto, we care about line endings.
If text,  we care about line endings.

If the .gitattributes don't say anything about text,
we don't convert eol.
(In other words: we don't look at core.autocrlf, when checkout-encoding
is defined)

A new branch is push to github/tboegi


