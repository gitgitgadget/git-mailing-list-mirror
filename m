Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F21E1F731
	for <e@80x24.org>; Wed, 31 Jul 2019 12:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387653AbfGaMce (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 08:32:34 -0400
Received: from mout.gmx.net ([212.227.17.20]:47389 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387639AbfGaMce (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 08:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564576336;
        bh=rr1VXObDOcXUIux4znR+S1VBrFssTqZ86hZBvP2FXwc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NOUMwy3sVw9qTOM5f0NN65mcTk5MQC7XyECMcFgdCgNvcucrjIuo34O5ky3RfaOrs
         /e84m0efIifyB8vgAwM838g08xxkSe7cBc5ifO4Z9cSQ0AIXO2cfAPjv8/saYqpdkP
         ebA1vmZGQz0WWD4wCMzPeif2jagB4Tw4HMsOfnUc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MFctN-1i6so11r1h-00EeQC; Wed, 31
 Jul 2019 14:32:16 +0200
Date:   Wed, 31 Jul 2019 14:32:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     git@vger.kernel.org, avarab@gmail.com,
        sandals@crustytoothpaste.net, gitster@pobox.com, dev+git@drbeat.li
Subject: Re: [RFC PATCH v2] grep: allow for run time disabling of JIT in
 PCRE
In-Reply-To: <20190729105955.44390-1-carenas@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907311426290.21907@tvgsbejvaqbjf.bet>
References: <20190728235427.41425-1-carenas@gmail.com> <20190729105955.44390-1-carenas@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-246020940-1564576338=:21907"
X-Provags-ID: V03:K1:c0OZUzBO+ZIrJSbp9xi/zjGZXaNuhqmsyTeJUamo5OkNFNmcJDb
 cAcp+ordYH7EJmNuLa+F1J8RmeVT+f9extL4sDtdhBeK17DExm7/x1gOlP1KHTsjBIQHD23
 0qwgOqj2I6a3jjucWgiJA/Th1DTlhunda+i/s/CDiEChpnngBG6nopW2+vWR2EMVRiW6EWh
 pWFIMpnpHhH9a1zzQE6QA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tQzRzg8lYR4=:lUIMm0gUnE9myDLpCk9oAd
 IPyJlcxLaMV3Ykw0J0OZEN3owYSIdZbddgyUxkbfwLhFi5Eg1d4snCfX5fHEGKgVBU3hmku+l
 RuXrLhCLJN2yGxPj3z7HDX6U5xwkiEMRobls37H6VxLAwWvWuJb83c3F5I2qn5CEa8u/Ivf8r
 2WZQ3sQvVQHMGkdf7UzCvdKV+8UAvf4l7op1rQ5XuHCp9zgwf6ty5mq9iDakCSpyAmckWz3vg
 wH2O9NqbvEYzsxVSUjMtDXJOvme+BymiAHCDkSwHTwBREh0mb7LEr4i5fKR14HKRgRewDiWFr
 dK9qI/AN1LwuneWuKnhPwuukXn9Cz8TZywlC9axSO4IfJ4Gto/vn8HxPpeKeRyMYEPbamFtRv
 RXzyPhrcKu1KVspjcJB6ZKu5yrGnD4kv2c5v09oqXUHhwfT9Btd6vI6ZnmCQCz/U6NCeEnUFD
 GlcsLDPR3WbTuPQw5ym9jFWtTpb6GcV01pybtMSC7LtfzQlcV52ZgsWjubhY+vK+3sYES/BjL
 qSUQyPd8pIgNe7tEWvyIPgfx7U8VmOsJPMlKYtobNifhHR+8+uxvYQMpGFZCQ6Oax0udRmgjR
 cNVPOHRqzNY8lA+QmWnVSr45e68zSjHURJit5nImbWOo9iuYyws3Cm9mlY5EGc/pcv4eI3T50
 k7NLEf6MKijs0nTZD9nx1hurBWDgAmtPF2Nqgkqb9IOf2tXUGtcT+r1445UGNyVoGEKR+DZ0f
 Tohwt9Tepdt/ngxO6Y2LsOod07xzM0az0z0vWolGM8vSXPgVD00aOSmR6EDD1In7TQftxADOI
 pTEhZ4JbDzBzodwdMlMGAnBCQsqdi5kgPQd7IYJnHcHpGFoMBkH6cvAHCLhekdK6ojqRcfqkM
 SRX86MF55D2bkwoZyScqHW5OZ6yJcso6pB5sGuiTB3YhIHUp8bKb9bJvKLjzNpxZOUzRjIPf+
 NaUHdTsQ0UPAMumGh3D5dhNaveo77zfKSw3W+wx2uy1pZ75WuLYFCNN0CazzvjB4hZHFLUYce
 AX32d5AfmfhVfG2bM+rsuVWSlO72Dvns9cslelaopyGoTN4P/S3liP6RRfUsMFvAQzVPKvJLQ
 emeX/xKDVv7If9+e/9jdLWetPtF8bCIBXQu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-246020940-1564576338=:21907
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 29 Jul 2019, Carlo Marcelo Arenas Bel=C3=B3n wrote:

>   $ git grep 'foo bar'
>   fatal: Couldn't JIT the PCRE2 pattern 'foo bar', got '-48'

My immediate reaction to this error message was: That's not helpful.
What is `-48` supposed to mean? Why do we even think it sensible to
throw such an error message at the end user? Can't we do a much better
job translating that into something that makes actual sense without
knowing implementation details?

But then, I realized that -48 must be a well-known constant in PCRE2,
and my reaction transformed into something much more hopeful: why don't
we detect the situation where the JIT'ed code was not actually
executable [*1*], and fall back to the non-JIT'ed code path ourselves,
without troubling the end user (maybe warning, but maybe better not lest
we annoy the user with something pointless)?

Even after finding out that -48 disappointingly means
PCRE2_ERROR_NOMEMORY (as opposed to something like
PCRE2_ERROR_CANNOT_EXECUTE_JIT_CODE), I like the idea of not bothering
end users and doing the sensible fallback under the hood.

Ciao,
Dscho

Footnote *1*: Why anybody would think it sensible to build a PCRE2 with
JIT on an OS that does not allow executing code that was written by the
same process is beyond me. Or is there a mode in OpenBSD that *does*
allow JIT'ed code to be executed?

--8323328-246020940-1564576338=:21907--
