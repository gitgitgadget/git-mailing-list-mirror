Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DF061F404
	for <e@80x24.org>; Fri, 20 Apr 2018 15:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755533AbeDTPbm (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 11:31:42 -0400
Received: from mout.gmx.net ([212.227.17.20]:60483 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755517AbeDTPbl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 11:31:41 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MW8PN-1euYEY25Un-00XLpJ; Fri, 20
 Apr 2018 17:31:35 +0200
Date:   Fri, 20 Apr 2018 17:31:18 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/7] Add a test for `git replace
 --convert-graft-file`
In-Reply-To: <xmqq7ep2d665.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1804201728210.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <0f0942043678fe76f8d654306482ee26fac643f0.1523617836.git.johannes.schindelin@gmx.de> <cover.1524125760.git.johannes.schindelin@gmx.de> <cf8169c80f08612185f81927ee6ff22e087b2835.1524125760.git.johannes.schindelin@gmx.de>
 <xmqq7ep2d665.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HbiRdj3Sj3J5IpTDD7WhuoE2wudunKBqCM65Y1TH4XG/ZkJUMB4
 3NFILqKoGoMILp+IOOifcroykgvz2w3IeKr4f6v80J7v+DkbMLc0N9yyOqExEJsDU6zuqct
 1NHfzUZdL0H4VYK6yMJc3XeNpbfXECOzLr6G8+D60TeFRjT9apl2AbiMt/Mm4opoGQ9RlSq
 a9YCm42uNPMSGSBxWbLXQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KClWh7K4LAc=:wv/eYVqkyPStCdObQ6wnMe
 gyeKADiz3cC3xZdvgE/ymrdSIRYnyKA6HE2fVhIsCiCVTJ74LVlnVE3PusMoeJplR7vrjymG8
 6LgroSDe2yfHe29jP/iN1jxJFYhql9doNh1RzFx8VfGgbV+4SMF7VTlHNnCMEXGOBaz8WWwnV
 WKHLnS3LBt8yYWe5eBwKmD+pomTHIAY7veQatqpHpFxO3xT4pNaXHL8QbDy99IGutVy1sqEWb
 /qrgkPaa+pyK3KFgqlEaHXJIrRZgrHr01t5NRt5BAeUbq3Liagr2VQupgNUIXePmN3wJLic0j
 rXms+9T55dJiUbO83knzehBbrmZFMeZq2XPmCqrKEZ81OO6YbQ2wf6fb6Ax2oODnLq3MAwqbc
 RASL+yXWeWlHnBWeQiqgR3reDhwiNmF7blraMD/qt6W3SE39gfl2j5NZPCNGbKi5SaV2u2f/3
 bq3EMND0JrMtUceapbGS3d1LRxhFVz2e7jTCKjUEGYpGNWKcRXbmNg6Qr9RY44A2roHPVpzkI
 3VXfoH9vVK6CiF8QLHu0MosuLjNtvu77aU1o6RGNU2y3MHnuhPf/X++VhHJOjnjykZOSazx3F
 6PBNXbBuDyOyBwCtsEhICDag6xQbu85v3NtMpNNZJ88qecV5g2Q5pSFW5Slh4NKF5gEaRHdwu
 JB2FYtT/l6mHZ/Faj3iWyvUS9kbwNxgJ0SXRm+0M11NIHlrw/Xxa50fUdnLrIDch1AsfxX5ox
 MXlh6TBBI30WnvHJDfwtjZLJUYh7n3miSBu5/MFjLAqlKSf9eTt19Uncz86v6mAusF+9SH8Tp
 C/CIhYVFxahK57Gbpr49T0uMBam+R3r9JwI51cWo9PuzfyiaVA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 20 Apr 2018, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > The proof, as the saying goes, lies in the pudding. So here is a
> > regression test that not only demonstrates what the option is supposed to
> > accomplish, but also demonstrates that it does accomplish it.
> 
> The above spreads the misconception that the value of the test is
> "what I wrote works, look here".  It is not.  "Here is how this
> thing is supposed to work.  You are free to improve it, but do not
> break the basic promises these tests outline" to protect the
> resulting system is.

I am but a lousy foreigner, but to me, basically we said the same.

> > diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
> > index c630aba657e..77ded6df653 100755
> > --- a/t/t6050-replace.sh
> > +++ b/t/t6050-replace.sh
> > @@ -444,4 +444,24 @@ test_expect_success GPG '--graft on a commit with a mergetag' '
> >  	git replace -d $HASH10
> >  '
> >  
> > +test_expect_success '--convert-graft-file' '
> > +	: add and convert graft file &&
> > +	printf "%s\n%s %s\n%s\n" \
> > +		$(git rev-parse HEAD^^ HEAD^ HEAD^^ HEAD^2) \
> > +		>.git/info/grafts &&
> 
> I find the above much less readbale than something like
> 
> 	{
> 		git rev-parse HEAD^^
> 		git rev-parse HEAD^ HEAD^^
> 		git rev-parse HEAD^2
> 	} >.git/info/grafts

Well, don't you know, that is how my first version looked. It failed,
though, as `git rev-parse HEAD^ HEAD^^` outputs two *lines*.

And the version with a here-doc and inlined `$(git rev-parse ...)` really
looks even uglier.

> because printf formatting string must be deciphered and then matched
> against the order and number of rev-parse arguments (and printf's
> ability to happily accept more args than the placeholders does not
> help in readablity---the reader needs to verify that the code is not
> doing anything overly clever exploiting that ability) before I can
> figure out who's parent of whom.
> 
> Of course, it saves a few spawning of subprocesses; I am not sure if
> that is worth the loss of readability in this case, though.

I disagree that it is so horrible to read. If a regression occurs, you
will have the .git/info/grafts file as a reference anyway, so there is
little you need to decipher.

Ciao,
Dscho
