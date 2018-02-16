Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24ACF1F404
	for <e@80x24.org>; Fri, 16 Feb 2018 16:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032227AbeBPQe2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 11:34:28 -0500
Received: from mout.web.de ([212.227.15.3]:33249 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751090AbeBPQe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 11:34:27 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LqUan-1eHo8E0WbR-00e7Rd; Fri, 16
 Feb 2018 17:34:23 +0100
Date:   Fri, 16 Feb 2018 17:34:22 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Subject: Re: Line ending normalization doesn't work as expected
Message-ID: <20180216163422.GA2659@tor.lan>
References: <CAHd499B5hM9ixnsnwWwB2uyDT10dRQpN473m5QjxH9raHtFXiw@mail.gmail.com>
 <958c9b03-062c-0bea-3b25-939a36659f32@web.de>
 <CAHd499AD5Kgbp-vxXTnEPkb-Mb5oEeXhaRO5kGniDdqmXwd2QQ@mail.gmail.com>
 <88c57b88-ef2c-d7db-15e2-12791d4cb201@web.de>
 <xmqq8tgrhdt0.fsf@gitster.mtv.corp.google.com>
 <CAHd499CSe6d1SBaDYNRD9HXaWRJ9QYzmOCaBWFrV52UNRMVqhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHd499CSe6d1SBaDYNRD9HXaWRJ9QYzmOCaBWFrV52UNRMVqhA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:la/0wWJvPqy4ssLWap4X/FmW/f7Vw0wbpGvVViifeg4OVe5B9tI
 3Dtp3ZUVk1RJ+p/A7PqTsH9DgQpB1guYHWSEWtEplVOcGPdN0x1DjJHF2GK4tnGh/el+ZS1
 Ri8JY2gSNtcz9exGXxQKpV7mNU9AMdNuOA36K6TArqVeW4r0zTmW4OG77WUzN2BHYMjgXnF
 hUqiqQjNf9oceePHUWrBA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UaNFdHO6EQk=:rMxzyPrW5Rzp/CbRLbt3br
 +EKjSK+hPQUZ4OF31OEitdnkerU1/4OQCVRHCPfXHm0bXb4o858BRcgm7z3AjaPkUdsiEENWa
 FoJNkIlUnf856q3HkBOrOIxz4npL3bcDmBeZbj07t7cCULJOdM/HnellQXrCojC9P1lB35qzw
 3mu6LvCKeSXcmQIDWigX0ATmwGo9XdKNeYyFJcht5AkX6r7wJaVBYERz1ekxFk7+97/4pLN4Y
 f3ghK0Psrau6jj6ygJZinCg0AidoqN62v/zlxaS3ft1YhHPlIozuW7lcUf8mdIjL+NSool1m3
 Pvas9YnqVrZUi0zhvLMxCDh1wUD4aOXs54EtCn7F2JA812GfnzWZc6YUrdXxBpOHbCgvBM2wQ
 8woaMK7wZ1iytmnjXzicne+yWxEP/oBCQJFMshynH1Is5tmf4Wx5/MsMWlOm7/shPa5ysVM7m
 2n3wk4SIVj7KMe2RobVJlL9KrvZUNNs//T9esf52Vm/iT7kd9HdT5/J2IdA7vAEmZ/kq3jjJq
 DVdrKoGSMF0gf5JErylp7xt+zXE0FEUj6FQVlL8u6x6+2CoZlvGAnnLkgNdaKoU+3oaCxDxiE
 EXj5KIj0kYywcVUSxIbNq/uogeU4kWMGMRUJqKGzm3yZl3+qkDR8rQSfsPQvk+zF20ARL344b
 K0SSZRrcPucr3iSvLzPgON+YmeEL1u1j0pDBuzHDeJakkwVjvj6KPDkSj+6ME8PNXswArB46K
 NmsEyztlW+ljzMMrhABnUviARhgCHx6Kkn7m0uV/6amIP9/SEvWcApywUapyjc0cmEECV7deV
 zT1Uwzpg6ozd7zpeQDCEyPmO9MsOA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 15, 2018 at 09:24:40AM -0600, Robert Dailey wrote:
> On Tue, Oct 3, 2017 at 9:00 PM, Junio C Hamano <gitster@pobox.com> wrote:

[]
> 
> Sorry to bring this old thread back to life, but I did notice that
> this causes file modes to reset back to 644 (from 755) on Windows
> version of Git. Is there a way to `$ git read-tree --empty && git add
> .` without mucking with file permissions?

No problem with the delay, under the time we had the chance to improve Git:

>Git 2.16 Release Notes
>======================
>[]
>* "git add --renormalize ." is a new and safer way to record the fact
>   that you are correcting the end-of-line convention and other
>   "convert_to_git()" glitches in the in-repository data.

Could you upgrade to Git 2.16.1 (or higher, just take the latest)
and try with
git add --renormalize .
?
