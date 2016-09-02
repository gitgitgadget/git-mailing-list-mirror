Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4317A1FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 13:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752906AbcIBNwC (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 09:52:02 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:33338 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbcIBNwB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 09:52:01 -0400
Received: by mail-qt0-f172.google.com with SMTP id 11so46131676qtc.0
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 06:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7lPSoczNddnPy0GfBQmx8Rt/7t2JEUtbu2C9iMf5Qw0=;
        b=WFux3HtunTQzyGeD6QFGKVwgKtKdTf1+47Swd4shfCIfrKAEnpoFdW1zAF/1S7C0Fr
         vjayze0pXMA+xZHZktE0LV+98WS0158qsIwFvIsB/ZHpxVRimSUCJrM4/rat4+8yKKHF
         aT9dTBqRrRr8Zil+LD7HCt7JtYjyeoJtlLSI3x2EcZHxXI3f8+Cx/2GAr/3IpdM+SOlU
         kMSWjz6MRlq6Us99LjQhXyobBm5/30Zdo4KS9PYrjwNhVdGwXsV6IZFbsHq1AMeK/a5V
         FlldY3KaovJ3rnTaYOCaOCDAcTSfaUL9Nqgewwnty2qQBfhxf2+LJMYmPOUSTCnRl8y0
         huTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7lPSoczNddnPy0GfBQmx8Rt/7t2JEUtbu2C9iMf5Qw0=;
        b=TBdZG3pRAXctwRK8mJmL9ifBrfrW4Z04COPsRgdq3lb6VSkKbk0YeIjJRMx3sk8wrd
         2s5sQ1peDfXC5KQ7lAENqhoC850qyt0u67aaRFIGAO3iPO/IYsHcner5bMpKmlsTs0Hw
         Op9AlQYovw1ei0cmSrOWHM2PCkldOG92eD5FLY1XanG9ybFKBKYIGcvaJASdPA8mmI2K
         1hIbr/lLQwuQfNCcTrfPoMR0ZGble5NQo3SLWD44LFidpeO5KyCLu2RuMoCZemd3RQAG
         V1dvFbTl3HKeTRqihrCgZvGpmF/JXs9tPCsHF/tAC0cFOwOGvWP7C1Fl3xK0MzcoJ+A6
         ijHg==
X-Gm-Message-State: AE9vXwOAq5Z2EffeTlkiZoK4d3B0o8S1Jl3Ncjlry8UPNWiO2lNGR35N7s7tGWo77+4rXVw49SVPxU69fiNLLg==
X-Received: by 10.200.48.56 with SMTP id f53mr3318207qte.99.1472824320475;
 Fri, 02 Sep 2016 06:52:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.106.66 with HTTP; Fri, 2 Sep 2016 06:51:59 -0700 (PDT)
In-Reply-To: <xmqqr393t4k5.fsf@gitster.mtv.corp.google.com>
References: <CANYiYbGLzg6+pK85gdp3bH7qyrA3BaX1PmjbnbK8Q+23HWuotw@mail.gmail.com>
 <b656bb11-680d-b20b-7aeb-99dc4afcb4b1@gmail.com> <xmqqr393t4k5.fsf@gitster.mtv.corp.google.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Fri, 2 Sep 2016 21:51:59 +0800
Message-ID: <CANYiYbGu=Nqa+1TZ6d8EuJoWcc9h0cZoFkw3JFQ810C8OXb2zw@mail.gmail.com>
Subject: Re: [GIT PULL] l10n updates for 2.10.0 round 2
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Another update comes, please pull.

The following changes since commit 5b18e70009487bb156cac18546d6f91105338f4c=
:

  A few more fixes before the final 2.10 (2016-08-31 10:21:05 -0700)

are available in the git repository at:

  git://github.com/git-l10n/git-po tags/l10n-2.10.0-rnd2.2

for you to fetch changes up to e8e349249c86550d3505c4abfac28caf3d13df46:

  Merge branch 'master' of https://github.com/vnwildman/git
(2016-09-02 21:29:48 +0800)

----------------------------------------------------------------
l10n-2.10.0-rnd2.2

----------------------------------------------------------------
Jiang Xin (1):
      Merge branch 'master' of https://github.com/vnwildman/git

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (1):
      l10n: Updated Vietnamese translation for v2.10.0-rc2 (2757t)

 po/vi.po | 691 +++++++++++++++++++++++++++++------------------------------=
----
 1 file changed, 317 insertions(+), 374 deletions(-)

2016-09-02 10:32 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
> Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n <vnwildman@gmail.com> writes:
>
>> On 31/08/2016 21:14, Jiang Xin wrote:
>>> Hi Junio,
>>>
>>> Would you please pull the following git l10n updates.
>> Please wait! Jiang Xin probably missing pull my one commit[1].
>>
>> [1]
>> <https://github.com/vnwildman/git/commit/800d88e2b3dde41ebf34e2e00955bba=
892419555>
>
> Jiang, I do not mind another update from you before the final.
>
> Thanks.
