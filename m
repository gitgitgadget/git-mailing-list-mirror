Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C165F207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 17:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbcJCRfY (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 13:35:24 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35376 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751725AbcJCRfW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 13:35:22 -0400
Received: by mail-wm0-f42.google.com with SMTP id f193so120678911wmg.0
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 10:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=G8UL2Dbji9dY/exd+OEdY87BOFsWHrKyAkHxKRmQPwU=;
        b=wH/c4eQ1vOQgoC/fZe+ryKUrhYllL7SE+Z6iEPzhT1qGcgTS1vqfkMV0IJtQKjNAyl
         NgL4nbnlMv+h6izD2E7jvgoNDOSi33OmOraMExvk4xw7F5M4UBP9rfRcVH9SmDjvhwYJ
         Tx2DRqZLTo4YZY2wfy8tUzE03kwgu4WvmUfFFyK9poV499HVbebrQGl4zk4A8Mp++8s5
         grwmxMn5SdgYsXpckLPWmIktusezWf1nQO7EUIU9tWmJPG8/PVk8s5EWxrFp9TTvQaBH
         MW9E8lrGKcuV0M5yzzbXJPIhZlYlxFLMP6c4Akb9kUewdCnQda03tMyifllsCjFhgvSe
         k4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=G8UL2Dbji9dY/exd+OEdY87BOFsWHrKyAkHxKRmQPwU=;
        b=aNb4tBc79sri+OOp0e85gGlHrl+bMBHFd9BmV/qrBaEuTpURKBqEJV4/OAiwAv96ZH
         TVs4/xxhLyFtRcA1hSLHjAGd9y1Jcnu/pjW24qRe7XwxdPLwJnuqw8XQ1cJYoXsKJRy7
         zi8fl+HJZAHCKxJM0+xK8GK1o/NaywLig1DBlkpF2ve077yqdkrd8NLhXYG5P6OMvJAi
         BAJR179oE/FVRuJjKp2r6aPjMEe6GGaMcCQKYf5w8CCRGCG+VYqQeOagRahpuSlPf5w7
         fbnAW69jFeOpbQuv8/n+e4kFIckTkxDoCrFFLhCFsz9etXro/FBOJAC2pxWzi6aqc6Y6
         Pqmg==
X-Gm-Message-State: AA6/9RnfUo6jiUw2OvNBrzTA7rywZPxCqjPpcKUW4y0ZxvuD2AT6wccjPfS15jJtxJu1qg==
X-Received: by 10.28.19.194 with SMTP id 185mr10329244wmt.51.1475516121029;
        Mon, 03 Oct 2016 10:35:21 -0700 (PDT)
Received: from slxbook4.fritz.box (p508BA00A.dip0.t-ipconnect.de. [80.139.160.10])
        by smtp.gmail.com with ESMTPSA id 123sm19976944wmj.5.2016.10.03.10.35.19
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Oct 2016 10:35:20 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v8 00/11] Git filter protocol
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqvax974dl.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 3 Oct 2016 19:35:19 +0200
Cc:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        ramsay@ramsayjones.plus.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <56FAEF34-6A31-4E10-9671-F890796EF5A6@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com> <xmqq8tubitjs.fsf@gitster.mtv.corp.google.com> <C2C9761E-986F-473D-BFB7-CBEF900D9FA3@gmail.com> <f7a4f828-bb1d-0ffa-e369-3b4fa476d9e5@web.de> <xmqqk2duhcdm.fsf@gitster.mtv.corp.google.com> <1A8A9127-4DF9-44AD-9497-F8A630AB1193@gmail.com> <xmqq60pee6rp.fsf@gitster.mtv.corp.google.com> <C53500E8-7352-4AAC-9F53-40CCFA7F1418@gmail.com> <xmqqvax974dl.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 03 Oct 2016, at 19:02, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>>> If the filter process refuses to die forever when Git told it to
>>> shutdown (by closing the pipe to it, for example), that filter
>>> process is simply buggy.  I think we want users to become aware of
>>> that, instead of Git leaving it behind, which essentially is to
>>> sweep the problem under the rug.
>>>=20
>>> I agree with what Peff said elsewhere in the thread; if a filter
>>> process wants to take time to clean things up while letting Git
>>> proceed, it can do its own process management, but I think it is
>>> sensible for Git to wait the filter process it directly spawned.
>>=20
>> To realize the approach above I prototyped the run-command patch =
below:
>>=20
>> I added an "exit_timeout" variable to the "child_process" struct.
>> On exit, Git will close the pipe to the process and wait =
"exit_timeout"=20
>> seconds until it kills the child process. If "exit_timeout" is =
negative
>> then Git will wait until the process is done.
>=20
>> If we use that in the long running filter process, then we could make
>> the timeout even configurable. E.g. with =
"filter.<driver>.process-timeout".
>>=20
>> What do you think about this solution?=20
>=20
> Is such a configuration (or timeout in general) necessary?  I
> suspect that a need for timeout, especially needing timeout and
> needing to get killed that happens so often to require a
> configuration variable, is a sign of something else seriously wrong.
>=20
> What's the justification for a filter to _require_ getting killed
> all the time when it is spawned?  Otherwise you wouldn't configure
> "this driver does not die when told, so we need a timeout" variable.
> Is it a sign of the flaw in the protocol to talk to it?  e.g. Git
> has a way to tell it to die, but it somehow is very hard to hear
> from filter's end and honor that request?
>=20
> I think that we would need some timeout in the mechanism, but not to
> be used for "killing".
>=20
> You would decide to "kill" an filter process in two cases: the
> filter is buggy and refuses to die when Git tells it to exit, or the
> code in Git waiting for its death is somehow miscounting its
> children, and thought it told to die one process but in fact it
> didn't (perhaps it told somebody else to die), or it thought it
> hasn't seen the child die when in fact it already did.

Agreed.


> Calling kill(2) and exiting would hide these two kind of bugs from
> end users.  Not doing so would give the end users a hung Git, which
> is a VERY GOOD thing.  Otherwise you would not notice bugs and lose
> the opportunity to diagnose and fix it.

Aha. I assumed that a hung Git because of a buggy filter would be a =
no-no.
Thanks for this clarification.


> The timeout would be good for you to give a message "filter process
> running the script '%s' is not exiting; I am waiting for it".  The
> user is still left with a hung Git, and can then see if that process
> is hanging around.  If it is, then we found a buggy filter.  Or we
> found a buggy Git.  Either needs to be fixed.  I do not think it
> would help anybody by doing a kill(2) to sweep possible bugs under
> the rug.

I could achieve that with this run-command patch:=20
=
http://public-inbox.org/git/E9946E9F-6EE5-492B-B122-9078CEB88044@gmail.com=
/
(I'll remove the "timeout after x seconds" parts and keep the "wait =
until=20
done" part with stderr output)


Thanks,
Lars=
