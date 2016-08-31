Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AEF21FBB0
	for <e@80x24.org>; Wed, 31 Aug 2016 04:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754489AbcHaE5d (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 00:57:33 -0400
Received: from mout.web.de ([212.227.17.11]:50096 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751202AbcHaE5b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 00:57:31 -0400
Received: from localhost ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0M4qWn-1au2Gk3rTR-00z0Ey; Wed, 31 Aug 2016 06:57:16
 +0200
Date:   Wed, 31 Aug 2016 04:57:13 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        peff@peff.net, sbeller@google.com, Johannes.Schindelin@gmx.de,
        jnareb@gmail.com, mlbright@gmail.com
Subject: Re: [PATCH v6 12/13] convert: add filter.<driver>.process option
Message-ID: <20160831045713.GA15209@tb-raspi>
References: <20160825110752.31581-1-larsxschneider@gmail.com>
 <20160825110752.31581-13-larsxschneider@gmail.com>
 <xmqqzinv6wtg.fsf@gitster.mtv.corp.google.com>
 <7A378528-58DE-4C17-9F00-9708947716DD@gmail.com>
 <xmqqbn0a3wy3.fsf@gitster.mtv.corp.google.com>
 <4020D8E2-77D9-46AE-95DC-F644F7C6FDAF@gmail.com>
 <xmqqmvjt3nht.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmvjt3nht.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K0:AnNaAKekVtzGLvDEKnhWTllht6/0BWf8Vxc+PNEM3cZxlKaeEZl
 ILsy1gmmFuWXrlhqgyh0uhJNhF8xlsS4nkaIPxCJkgVtN0iQrUH7wM+8DlhTYqu4l9draCu
 DgTcTs91tn4wgO6xg/ZrWNJmpa01yKLK89xNqx1R915ciBEZfSvMedDS1y3uqtqSO8e9L8O
 G3vfNqfbcq5QX7meRs+Jg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:p+erqP94Lkk=:65r9QrveI/YHaQ/QJRU9G2
 h3P/sR3GOsWZSOJVH4zZOfXZ1k8fCoMx7DQ4fAx6cY9g2JDHV9yYtX1jTcFdH4sM7rzChPl4N
 jVjZbijKI/qUVyuNwkJKivvpLI3X9JXpBFBIoZax46TYSjy1kjLa2dmoOhp6GuGbdcxFWeSwl
 5v1UdSlU0ClsN9LmCuB0niocmd2HmGk6dwy2updrKO2KI3OoiPSlL4jK6nIHT5P0UlraleB+l
 LuFCXImzpm5IWNY/XqPGUYrwJ4+RQy9kqOfiHFXm9gXsbmwx4T46ZxdVfBoj5tlBI05wBgwIP
 EkVt7EUKBjsIbBPyFOh/hDUHXOr/L0PzI0ZxNvsKyK2HNo/WfV0mHoDbitPwLWpNneuxt6Ta/
 rjTlZIRdDoUpcDQ4pkQoFeVVM5J5hyHtQEVGLqiC6+AUCDNX41cpnQGDZbDA+KoPwkk7pTwzF
 ElZYb3tg3xHXRpKrE1DC5FS5NYITCWE3SX3kW46SNhJC/rkSK5pUZioXPMF87yntA0sEFKNWT
 aLrPEIwncvu7Ao1fTmLN4wphSleX13jgIlaq2nmlwEeNEXr1Q6N+poC4jt/TFY5JvQZH4T3yN
 aNe5rxawtz3yC7KCId3U+gtNdw6InPwTf+QMB+RpI7FN44I6TfF14q1GT2OW213AcH0ai/+8f
 /jCaKBsBPJBocVEnW69qE7JYE8CkEKDoTCGpMX8YWtnVZp5FwS9QEnI11g3ZtJihdVdEZyNfP
 RjFRnd6Vnai0pANU3XZjqOnfrkjdDrncmBGk9Y5JszylOSO6C5Sgs8mb6y4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 30, 2016 at 03:23:10PM -0700, Junio C Hamano wrote:
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
> > On 30 Aug 2016, at 20:59, Junio C Hamano <gitster@pobox.com> wrote:
> >> 
> >>> "abort" could be ambiguous because it could be read as "abort only
> >>> this file". "abort-all" would work, though. Would you prefer to see
> >>> "error" replaced by "abort" and "error-all" by "abort-all"?
> >> 
> >> No.
> >> 
> >> I was primarily reacting to "-all" part, so anything that ends with
> >> "-all" is equally ugly from my point of view and not an improvement.
> >> 
> >> As I said, "error-all" as long as other reviewers are happy with is
> >> OK by me, too.
> >
> > Now, I see your point. How about "error-and-stop" or "error-stop"
> > instead of "error-all"?
> 
> Not really.  I was primarily reacting to having "error" and
> "error-all", that share the same prefix.  Changing "-all" suffix to
> "-stop" does not make all that difference to me.  But in any case,
> as long as other reviewers are happy with it, it is OK by me, too.
> 
> > Good argument. However, my intention here was to mimic the v1 filter
> > mechanism.
> 
> I am not making any argument and in no way against the chosen
> behaviour.  That "intention here" that was revealed after two
> iterations is something we would want to see as the reasoning
> behind the choice of the final behaviour recorded somewhere,
> and now I drew it out of you, I achieved what I set out to do
> initially ;-)
> 
> > I am not sure I understand your last sentence. Just to be clear:
> > Would you prefer it, if Git would just close the pipe to the filter process
> > on Git exit and leave the filter running?
> 
> As a potential filter writer, I would probably feel it the easiest
> to handle if there is no signal involved.  My job would be to read
> from the command pipe, react to it, and when the command pipe gives
> me EOF, I am expected to exit myself.  That would be simple enough.
> 
> >> I meant it as primarily an example people can learn from when they
> >> want to write their own.
> >
> > I think `t/t0021/rot13-filter.pl` (part of this patch) serves this purpose 
> > already.
> 
> I would expect them to peek at contrib/, but do you seriously expect
> people to comb through t/ directory?

How about a filter written in C, and placed in ./t/helper/ ?
At least I feel that a filter in C-language could be a starting point
for others which prefer, depending on the task the filter is going to do,
to use shell scripts, perl, python or any other high-level language.

A test case, where data can not be filtered, would be a minimum.
As Jakub pointed out, you can use iconv with good and bad data.
