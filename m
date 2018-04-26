Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A80EA1F404
	for <e@80x24.org>; Thu, 26 Apr 2018 09:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754900AbeDZJ0j (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 05:26:39 -0400
Received: from mout.gmx.net ([212.227.17.20]:33881 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754891AbeDZJ0g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 05:26:36 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M96Jd-1f5swx0Pmf-00CTo5; Thu, 26
 Apr 2018 11:26:34 +0200
Date:   Thu, 26 Apr 2018 11:26:17 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Abinsium <abinsium@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: `iconv` should have the encoding `ISO646-SE2`
In-Reply-To: <6e8c0ae9-c699-6f39-014f-2008888722c8@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804261125200.4978@tvgsbejvaqbjf.bet>
References: <6e8c0ae9-c699-6f39-014f-2008888722c8@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Juv16cHEh4NRJfPhHMb3UseFXzLJE0oLTptynguFwhi5gzwW2om
 gwlfE3Rgbixh1CQZAWiO5Chzi4h4rj46HQCLIKpGICuyvvfexUk50FVERZq4jljeihygR++
 MYTdj16m8Av+OujkXr9BrsIOMVJMh7v6ggj6XYLb3ZdnXdtLzh/NnuiUY2hl/C5bna+vD5E
 5NkMLNknaDW/81JLt+YlQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:I9/UTqWCS1Q=:KLEtGI+vljk9wPEFnvJuJ3
 8KUE3cTzX2ozA8H9i9jrB7VNqViGIh6xNa7MLoOG0tlTorINkck89qztISc4FmxTWzjldFMwi
 Qs86Iine9PgdfsyIy81RS/P6C5X+H3YFQQ52OB7YF30vHNoLoO5mcDCxjPuM9NEFHSQBXqSB9
 kLr62/8pkfqkaj7TQQEpSlodA0kW5HG1an/iJqZ4xi8vp1SiXhuig2Ut9StmPdcGDvkwL6NOF
 UtlRudU1e2GWHJkHJggOdRtfBCl2QI7nkgvuNSexAT/6zfcimlINS9FKMISwKFkytfLh2fp26
 YhwTlkgEgtwOiRS6HFVam76FhvHg6Ihf3tmzmWDDmzddnZEJi6FM8ZqPI4raJuyXwO/+1Xzca
 vufwfA+kr4vRT3y9zi4tmvk49hAFLjYKdmd84c/U3uW8LM0hQ7sJ9nycQ2UzsgNjHS6H+ZQDB
 TSWMu9e4WpYsJZYGMFCkM5DUQeqm97B8DyXyHvXSQbYGCMgrgbIAG18aKCk4ml8U7I2jtXwFI
 iWFhI7xIihHJyhICbNTQHyXZO3UTA1ti5a8llaRPEFyeb+C4pcdMSHbXFnAvyOIzdN0t39LId
 p/CT9dG89jev5btGHLyO0cp3u7DUe8WU8ZTuVcMYPBLb4Filyuk/YVUYXl+1icRPgSKk4V5++
 c7AXwCr6uitylIHH2N4vpWg8JgF7fzFeYWAaABlyQ7GIm8zuZshrJxvO5c0cKh5ofQNNwxm9v
 zB0+jKhX312Xg0GKE3kXqel4zsuFG7mlZ/F0tBt+EHzcNEAMcX5VYmnN9DIXBJUIX3QJ80ZTU
 dDj4eT+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abinsium,

On Wed, 25 Apr 2018, Abinsium wrote:

> I installed from `Git-2.16.2-64-bit.exe` from git-scm.com. `iconv` is included
> in this package. I think `iconv` should have the encoding `ISO646-SE2`. Ubuntu
> 16.04 has this encoding. I use it to read old Swedish text files, which there
> are a lot of e.g.:
> `curl -s https://www.abc.se/programbanken/abc/abc80/asmkod/basicii.txt |
> dos2unix | iconv -f ISO646-SE2 -t UTF8 | less`
> `ISO646-SE2` is used by e.g. the retro-computers Luxor
> [ABC80](https://en.wikipedia.org/wiki/ABC_80) (1978) and
> [ABC800](https://en.wikipedia.org/wiki/ABC_800)-series (1981). At my
> university we only have Git Bash and not Ubuntu for WSL in Windows 10
> computers.
> 
> (Not clear where I should report this, but one should be able to report issues
> with the configuration of the other programs than `git` in the package
> somewhere. If there is a better place, please let me know.)
> Originally reported at https://github.com/git/git-scm.com/issues/1199

This has also been reported as
https://github.com/git-for-windows/git/issues/1655. I will comment there,
as this issue is really not relevant to Git.

Ciao,
Johannes
