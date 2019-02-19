Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4CB21F453
	for <e@80x24.org>; Tue, 19 Feb 2019 14:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfBSOJv (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 09:09:51 -0500
Received: from mout.gmx.net ([212.227.17.20]:37559 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbfBSOJv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 09:09:51 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MKt5A-1gw65U2Fii-0004aV; Tue, 19
 Feb 2019 15:09:32 +0100
Date:   Tue, 19 Feb 2019 15:09:15 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Max Kirillov <max@max630.net>
cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>,
        'Johannes Schindelin via GitGitGadget' 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/1] Fix hang in t5562, introduced in v2.21.0-rc1
In-Reply-To: <20190218205725.GB3373@jessie.local>
Message-ID: <nycvar.QRO.7.76.6.1902191507380.41@tvgsbejvaqbjf.bet>
References: <pull.126.git.gitgitgadget@gmail.com> <005401d4c4b3$147aa8c0$3d6ffa40$@nexbridge.com> <xmqqef8a6lnb.fsf@gitster-ct.c.googlers.com> <005901d4c4b9$3b9a2a60$b2ce7f20$@nexbridge.com> <nycvar.QRO.7.76.6.1902182139490.45@tvgsbejvaqbjf.bet>
 <005001d4c7cb$0cc4ce60$264e6b20$@nexbridge.com> <20190218205725.GB3373@jessie.local>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:67DUJBw7pFC+JnhTbrn3qtTe/yb5L8F9Pz8YE/slrVETNaA3XWm
 ZExfhunnbJOFhSNZaOVTS45pCY67xUiDCZnfG2jdDgoTz6/4W90+lbsXasEr9QsFmUkhPEW
 kRoYiS/0kTbBZvyANyYbQmdqyjQdpHE8uj5Elw9tRP7mkKZ/DxplcV+Cff/LOHe+XwzCoV6
 BPpTHIPcEBLVmnIon2r5w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XtcrjogT5Co=:K7IJ+CFRzPNB58p/FPjrkc
 m35927QkRnDzLOSevoLI9TYPR3gx/u1WzzPTj3TXAqqqeXPnHsaSsDqVcLcJXpJJC4IDSs36y
 vSG2ylcH6nRHfpe6eJ7G7Ggfp2plItwkjm+eq06O9F65D/UPiVGNoJ1vB64oH9sFdJVpaEpUS
 +jdB+5JOinHi7F0ZVW0SR1MgnNtErol7Qmw/iWaWFhXcuJ/YKI7G//P9cDKRF1dOJMNAxa7fu
 /d/YHPam4wZterU2t+JmEaThIkNzqAPOJdAdOsVV6M+5bHsNTrQRdJD0DGgJeYKjcF8+nB7qC
 G1DC79w89q/UXj1jDcisYoNwDq2gXgbxlnw33Qr+9e3TUdjorcVD9mephQteQOy8yNoSMVSD9
 52RD829105PJRcBu07hpKsORBG71gmI/xRnErkGnOpOU78boNbjuuw9gI+sbpXO7fQJQcIgRZ
 s5R5ChMYsgIDrmeYhAGYFhLM0468nBfdF/Eg99YeO8/FIgWECvtbHZ+JOcGE2yDxyrNIRqXn9
 Xlp9ICig9RAuso6+68opilcC4MB001yzhXV9vX8f2EEQv0MYJB0YdtagtKWyTAQ7NfjGeTDoz
 4PdGrssiOmkNDe0o70OURrmGJywsKqHcCiqOCiKM7fAyR2QKdIbJjApQJbs/48GiRxczxQCxI
 i9HfLT9Wfi0mhLNRVk74xyHWswpxPlybmorGILGYk6KcxqUj/5HwnbfduaRxWvT3qIaMxdJ7f
 k9NOfzT+F5uMQ8ynebn7Bw/VvJE7FAXxTqm55MMvxWi3IuEu8JVp9X+F5AQf2Tg1l001pDXvz
 H5rfDIgICmR3l6cSo5siKSMv/tkdm4408x2lRxMgAsx1oSc92HyB8WDd20UcoMZ7Zz6CRGq0n
 xzTuDD4NAp4ut7lBSd7T09AYT74RsGuGQsz7d2EzvXll+63iWiJIzeP8BiciIAHQV4hteGXQZ
 vZrI0YNwU8w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Max & Randall,

On Mon, 18 Feb 2019, Max Kirillov wrote:

> On Mon, Feb 18, 2019 at 03:46:34PM -0500, Randall S. Becker wrote:
> > On February 18, 2019 15:41, Johannes Schindelin wrote:
> > > So could you try with this patch?
> > > 
> > > -- snipsnap --
> > > diff --git a/http-backend.c b/http-backend.c index d5cea0329a..7c1b4a2555
> > > 100644
> > > --- a/http-backend.c
> > > +++ b/http-backend.c
> > > @@ -427,6 +427,7 @@ static void inflate_request(const char *prog_name,
> > > int out, int buffer_input, ss
> > > 
> > >  done:
> > >  	git_inflate_end(&stream);
> > > +	close(0);
> > >  	close(out);
> > >  	free(full_request);
> > >  }
> > 
> > In isolation or with the other fixes associated with t5562? Or, which
> > baseline commit should I use? 8989e1950a or d92031209a or some other?
> 
> As far as I understand, it should be tried instead of 
> https://public-inbox.org/git/20181124093719.10705-1-max@max630.net/

Don't ask me which patches you need to try this with. I was just answering
to the observation that the hangs happen in the gzip-encoding test cases,
and this was my guess as to what is going wrong there. I have no idea
whether other patches try to address the same thing, are obsoleted by this
diff, or whatever, as I have not been able to pay attention to the Git
mailing list in the past 5 days.

Ciao,
Johannes
