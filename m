Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6752920188
	for <e@80x24.org>; Wed, 10 May 2017 19:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbdEJTzX convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 10 May 2017 15:55:23 -0400
Received: from mout.web.de ([217.72.192.78]:56622 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751208AbdEJTzW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 15:55:22 -0400
Received: from [192.168.209.63] ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MC1fA-1dHJ832L7g-008v5V; Wed, 10
 May 2017 21:55:19 +0200
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 1/1] t0027: tests are not expensive; remove t0025
From:   =?utf-8?Q?Torstem_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: iPad Mail (12F69)
In-Reply-To: <alpine.DEB.2.21.1.1705101746470.146734@virtualbox>
Date:   Wed, 10 May 2017 21:55:22 +0200
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <7BD61CA1-47DC-481D-8491-5945333C8E55@web.de>
References: <11da00e8-a62c-bf07-d97e-ab755647082b@web.de> <20170510140619.22808-1-tboegi@web.de> <alpine.DEB.2.21.1.1705101746470.146734@virtualbox>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Provags-ID: V03:K0:kLlT1MUIQn5X1uPMH/qJi5w0+vdz4dLiEZk6kyYLplyffQlWpSe
 jEXp20E8dnhQ8TVAVPPAKwg7Sf0oA+vDmOh+G+wrsEYRD9Eq9NJoapWRmm4RhUPIYPAsP5x
 0rqoLi84LePPq7d1vHNCfvfrgLrMbn8OJp2+6rUzmCUoZn2M1YA4lfjWShWQP5p21G0x2fz
 n4ot1tC4cjooCoP3QdbfA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HXyHWRd1MC4=:1GISWpsbEn4kKvnYpjDkk4
 DqDVofwQzKbQXH9GI9+ZOFhoh0cQGgDe9YiMSVjxZ8RcxUj27U4he9aQUuw5uuUzZdfIUseNA
 TOK1OM50L2C6pg5eQqAmS5BSk+6E8ZpOYU8U/1RgnNUgpllxtOlpMdnogzqkEn+7HJSjq4f9z
 aXTwrr3hinTzzy+m+G3I7tJaUCOgFFWUmUf6lYexHyTxU4kFhcWCurZYNk7krN1V81E8MZi6a
 Sen4x8eP+LlZYpdrFJV+5FgxEBzTeGxTW3fw/P0lSQRmvdrPiThogIwE1gMUPjlTWot0u7q3s
 9pZuydvXK7TviSMI3LaqCojhXUmIodAGIHKczRvEazJX/bF8BYu3NkyRFQ68BTQ1+gfnYz8TL
 Vtx9LHkozAH2/qJA6ZehrLj/TYAUn72w3zGlh5PntqNDcYnsT1zTK5zTUeQLThje5ESsW1B5T
 /dAvSxYdAPh95/lyHWbwn5NLpYMSqS9A21C0KoRC9ZaQdo2mlfOCAgn/uW4EyLdkQ6scu0zQ2
 tsjUBR910BlS8HkCx1ytV6EpBFkmmL3xWHjP6JGsM+u7KttKNaG97GP2EKV+YyHRZ2ToG7oQl
 sXG8XLAg4Zv1CXzGHdb+bP+tETcN2QANMhYxDXEf4A3YsZnfsg12EYjbzG9jIm1VSFSyGkgOl
 oNC3yYPz5DYXeG6BSph2cUtjVSRaYrCOGob9WGDu4Asa34Q9aTEL155gTQD3KWS9PyNUYrBzq
 ZmdtPM19gtkSPG83hOi2ejf7fESn1DezObGP49KJu0bB2bYpWvcnq1ZmHzgeOgeUhLbFJnFyN
 dkpPEq9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ok for me, thanks for helping out.



> Am 10.05.2017 um 17:52 schrieb Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> 
> Hi,
> 
>> On Wed, 10 May 2017, tboegi@web.de wrote:
>> 
>> From: Torsten Bögershausen <tboegi@web.de>
>> 
>> The purpose of t0027 is to test all CRLF related conversions at "git checkout"
>> and "git add".
>> 
>> Running t0027 under Git for Windows takes 3-4 minutes, so the whole script had
>> been marked as "EXPENSIVE".
>> 
>> The source code for "Git for Windows" overrides this since 2014:
>> "t0027 is marked expensive, but really, for MinGW we want to run these
>> tests always."
>> 
>> Recent "stress" tests show that t0025 if flaky, reported by Lars Schneider,
>> larsxschneider@gmail.com
>> 
>> All tests in t0025 are covered by t0027 already, so that t0025 can be retired.
>> t0027 takes less than 14 seconds under Linux, and 63 seconds under Mac Os X,
>> and this is more or less the same with a SSD or a spinning disk.
>> 
>> Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>> Signed-off-by: Torsten Bögershausen <tboegi@web.de>
> 
> This is still formatted very awkwardly. How about this instead (I fixed
> the formatting, reworded a little here and there, and fixed the order of
> the footers)?
> 
> -- snipsnap --
> From: Torsten Bögershausen <tboegi@web.de>
> 
> The purpose of t0027 is to test all CRLF related conversions at "git
> checkout" and "git add".  Running t0027 under Git for Windows takes 3-4
> minutes, so the whole script had been marked as "EXPENSIVE".
> 
> However, the "Git for Windows" fork overrides this since 2014: "t0027
> is marked expensive, but really, for MinGW we want to run these tests
> always."
> 
> The test seems not to be expensive on other platforms at all: it takes
> less than 14 seconds under Linux, and 63 seconds under Mac Os X, and
> this is more or less the same with a SSD or a spinning disk.
> 
> So let's drop the "EXPENSIVE" prereq.
> 
> While at it, retire t0025: Recent "stress" tests show that t0025 if
> flaky, reported by Lars Schneider <larsxschneider@gmail.com>, but all
> tests in t0025 are covered by t0027 already.
> 
> Signed-off-by: Torsten Bögershausen <tboegi@web.de>
> Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
