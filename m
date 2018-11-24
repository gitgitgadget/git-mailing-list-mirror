Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4A121F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 15:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbeKYCNq (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Nov 2018 21:13:46 -0500
Received: from mout.web.de ([212.227.17.12]:39947 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbeKYCNq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Nov 2018 21:13:46 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M5g0a-1fTG362wOm-00xdcC; Sat, 24
 Nov 2018 16:25:04 +0100
Date:   Sat, 24 Nov 2018 16:25:04 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Frank =?iso-8859-1?Q?Sch=E4fer?= <fschaefer.oss@googlemail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: BUG: CR marker ^M doesn't show up in '-' lines of diffs when the
 ending of the removed line is CR+LF
Message-ID: <20181124152504.GA14440@tor.lan>
References: <1f068f3a-d636-9b9c-f501-51d33412b964@googlemail.com>
 <4dca3f64-4851-6d48-8266-dfe55f597739@kdbg.org>
 <edadf857-2d4b-f058-5e07-286afb312901@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <edadf857-2d4b-f058-5e07-286afb312901@googlemail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:aHh3372YrSSlsp7l9lCRbWTMZOpjS/lGWNi1Glrc+SKTFBEN9Ns
 TOzqDzIV0mjx5OrtURwAKxizodmtXIhUzShvAekFKjh37w3s353SmH6hgTW8mg0eqmSrjSs
 lG33dSO5MKlkmrJoWz8HkX0PrGWuvWOzq6KNuhuccUBcDVC02QrPcQPeac7u9qZB/i2xpY+
 SqbzVXxPHqbH7Ycfu/X1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oiutZwhBbh4=:vc0RXShWPWzA9ZhMHw5CWz
 TjmLKMZTB2CCo5m4DiCaAxl7+aQ8NSozo0qiuo1pVkOe6NBZFriiPGB0alM+P+mGXEavLDGbd
 znhQAoiLzTVZn9nXhxMI61YJk8t5iB8Ae3tzv8BMS0um2qG57P9EFzOZKMauM1eS8hlrjrsqW
 LIPmwVEWixEQ5YM0G6ui3TM3KenjD6Wo3APbaY3Orvb4r/CmiavB2LaHp7ypS3ZhSJXlS/FNC
 VeEGKEwmE94FE2tu5GFd8TSXbihWJ/Q3lIZxqg1HmnWF+HHbLsPhD9AnbKO5PJupmcPp8Xf4p
 nYlfaIndoFz0ks3M/gDeZOHWMESd0DNUF739Rvz5zRUKkXokgDSaNLp5HCQStZ+9YspfUmSz3
 bNQ1LrP8GJ3YwIerL9aQTrZJmtIshny19jPNogIQ8LuCoZmISfjPoau3wS7zbkyaaE3fnMFbs
 H2ghy9adJ2PWJfZiKUnDHfG3/EGEAbvAQzwevvQRf3IT7RPtRi6rXCD1w5naY9OF1klNa20KL
 f7IPItw4YviDldL18B7Rf3bV//TkpLiWx0C7BK5cIS+jBuwi1yPIOBfGOUhjOjp2CQJNne/LB
 WplMAeU4Nw1GZVRDZi/GdLpq+1mJGK4J/B3JRkexfg5zB6LtcwAPJipbCI2FJJ3r4NmOHSgPq
 bqK1V0Yf8Y1nNJSCOUt384rU9VG7MP3DTIuFByAAEMvZPdFqXtYbJuxFXT0JTOEJ+wXRNuLnf
 XuLlJ3jU0pLfEbqa5PcNbFCcpgrJdvN+uPBfWU/t6yHd4BRM6mF37Aqft3y4JJyzP5O6Z9IOy
 Ny51wwCcBgbMBw3TxA8AcvxT4RP9+fIFtwmU0y4zkdbNTCjdSHChtk1aiA2FYxdaYSyuWBb3K
 Ltu3/S141fFW6fRIRdnFgZxS5T3EvYyGmDDOLvslw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 24, 2018 at 03:51:26PM +0100, Frank Schäfer wrote:
[]
> 
> Hmm... is CR-only line termination supported at all ?
> E.g. 'eol' can be set to 'lf' or 'crlf' but not 'cr'...
> 

No, CR-only is not supported, because:
Nobody was implementing it, and that is probably because
the only question abou CR-only (at least what I remember)
was a when an old Mac OS (not the Mac OS X)
was used (which used to use CR instead of LF).

And, such feature may be implemented by writing a filter,
replace CR with LF as "clean" and "LF" with "CR" for smudge.

