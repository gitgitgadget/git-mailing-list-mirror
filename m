Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 215571FD99
	for <e@80x24.org>; Tue,  9 Aug 2016 11:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbcHIL2C (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 07:28:02 -0400
Received: from mout.gmx.net ([212.227.15.19]:60930 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752100AbcHIL2A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 07:28:00 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MWCgz-1bhoi71h3R-00XJcO; Tue, 09 Aug 2016 13:27:50
 +0200
Date:	Tue, 9 Aug 2016 13:27:35 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
Subject: Re: t0027 racy?
In-Reply-To: <20160809070345.rpdxjvmb6ujeefhv@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1608091325430.5786@virtualbox>
References: <alpine.DEB.2.20.1608081556280.5786@virtualbox> <20160808152926.mciovipy5qlnqegs@sigill.intra.peff.net> <20160808203224.GA28431@tb-raspi> <20160809065110.GB17777@peff.net> <20160809070345.rpdxjvmb6ujeefhv@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Yeow0JYhmxqVliPoRmrotbE/kMrK4MDBfL/jkFRzZhHOXGsNhB0
 pBffES7TYqcIO2Vo6Rrro0qgfkItGMXd5IqQrv/QmKWN1/5weKybdVhwGsJB8Te9vyWHtoE
 vcCX3fMEuoUAQ8m3P123zeByJR4Wb6SsbIjjjlUcnbHWXfru2JRhkHvb38as/fbb58chJ8N
 P2tkxYfdMt3sI5ZEkGDvA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:CFYJY19stxo=:f8qsW5huGRNeUmCT4Xa3yA
 hI+HgUz/HuHv3x6SV8DUt7PuI05O3o0J6FZpBNGQbWIWd+TR0BFpPrhhLo5qvciPROZCYzw3O
 TxrFG5J6vGMAWLNEqrlnPDNrDNKp56FdEuKxuID0epI7BBEcJf5Uapr30dXzX2HFIDmtBYbPW
 4FyRp8uSCy4Tzano2/3gnJ/YEglQsj+Bs1Pb7OvlT8D/2A4Q9pgvj7hwK/kB+LCR23Ed2S62F
 0h0waq8p80fcDMzzvV2ZUlbM9w8IyQhn0nqqe0r+SofjZ3V/+1sywIabe0ynlrv0KzeA9C3ni
 LQ/R2mfR+l2hWUvkcKNK6/4dB1O3xY7gssIUPn+hSgZIDrqs2lFe7kh2aL4BTgMmENu+MzqL/
 liSiArEt/AvdayJmb7V/pjQNbGgbbB+mkRBUxzNrjFZ/XBjmhuyJlZeRDdg0DzUNLuoLWvNXM
 vCM6C/5zrlddufHkVL0EgNSl0nl6wzQDV+Iq4tkzr3BPILgyvKpjJ8zjskhnxX9gjs27DwCE9
 yw5f1tY/dFwUvM1cGLRT1SfgmojPIHV7bWeasOepM7MyMhI02tJF/qlDdMP7FsHLa9OcAti3H
 YC2jz0RPu5cxJubn/EmDwPfGdl0TQ7QqS0Qmfp2Isere2FgiF4WceIxurq0fLjp3B4b5moHLQ
 fBGLYXZ3NpTs6XpMg/Xc9jNA6WGkNMwlpaVOEvdLuBKw4PkxeCJnTBoSQG21QPdk25PMecmA1
 UGoka5wmJ88hDHBRpWGiAcBVeXHaDmV7KWTec1+gZPGhqQ2uEXGLeacZjantRsQLP81CpxMjS
 vLT261E
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff,

On Tue, 9 Aug 2016, Jeff King wrote:

> And indeed, this seems to fix it for me (at least it has been running in
> a 16-way loop for 5 minutes, whereas before it died after 30 seconds or
> so):
> 
> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> index 2860d2d..9f057ff 100755
> --- a/t/t0027-auto-crlf.sh
> +++ b/t/t0027-auto-crlf.sh
> @@ -120,6 +120,7 @@ commit_chk_wrnNNO () {
>  		cp $f $fname &&
>  		printf Z >>"$fname" &&
>  		git -c core.autocrlf=$crlf add $fname 2>/dev/null &&
> +		touch $fname && # ensure index raciness
>  		git -c core.autocrlf=$crlf commit -m "commit_$fname" $fname >"${pfx}_$f.err" 2>&1
>  	done

I will test this patch as soon as my poor machine has less work.

> I'm not sure if there is a more elegant solution, though (for instance,
> why not collect the output from "git add", which should have the same
> warning, I would think).

That should work, too. I am a bit overwhelmed with t0027, though, I do not
really understand what is going on. It tests *so many* things, and in no
test case is it clear to me what it tests and what it expects let alone
why those expectations make sense.

Ciao,
Dscho
