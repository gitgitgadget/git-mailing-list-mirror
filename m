Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A78771F45F
	for <e@80x24.org>; Fri, 10 May 2019 14:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfEJOFs (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 10:05:48 -0400
Received: from mout.web.de ([217.72.192.78]:52763 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbfEJOFs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 10:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557497140;
        bh=sKbolr+KspejgIlbyU79i14nYXSwcsdxWNqWcYOKykI=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=H+zuSHmk9RA27jSldugrGpRP6w//0fZOnebVBIIFIrc921trIX9luQh7231d5J2Ey
         xZqSK+Sub2CdyGTB6KkBDHLKqsLzswubODxpSqVM5vwu5w+UpQQYzTrIpY7GYeNDFY
         PoX/nlTXjFbLQsWlf2pLrNueMCZoSbLWLsLyMx68=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MRl5x-1hIKnl2sht-00SyOV; Fri, 10
 May 2019 16:05:40 +0200
Date:   Fri, 10 May 2019 16:05:40 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: How to exchange rerere/redo resolutions?
Message-ID: <20190510140539.77elozdmfnlkys3v@tb-raspi4>
References: <b8e56556-6c83-9e37-38e9-ac67f51b5cd2@iee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b8e56556-6c83-9e37-38e9-ac67f51b5cd2@iee.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:KdTJ45bOW+zqL/RwKQ4PsHNulX7xtcvrnGGJ5G4whg5PApHtXBj
 1360cz2D5ZQ34/09xzZ+X5MsReLCEuQ7xgWIrCWAvx7V3qHtq/dHd8h8eBuPa3ZNZuYnIqL
 dh3cN3Si9a8aa91mfk9a1duucRphurnKBh5wMmigEn+rE1tBUswYIomNkTzQvqcGqa6J+/L
 JORTg+L7lFbq77e2M1Qzg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VzWKuXoO2eI=:lEkAKTcx9nPie0cmE39Xqo
 eYQDVpvCHVOCCD0blrtSO8FxYy+6q/YN7ZUjU9MPrjY9ZWleps2uLty1EPdBzTe4aUhntUjoY
 RiVKRQIHVvkkLjF6+CjqeXl0TlU7U+GdZjhy6WFhbCp5by6WngqV1CGFh8uWqR9LoK3/mBbYK
 ojWLc2dGxWE7ZUP9mlc+iGoi5M7qknANVi9XF6RLHO60VyRMmWfgfRNtNgQvGlFRedfevedug
 4Z82CCUEhmuVWELnUr/YQFlzqoWRYUneU4Pf61VewVLshmWMNgSFiRxKQlLsE9dgiVfgoT7kc
 exuVvsJDjoO69xFqPalyPFGSpgdOJNiNxkhyuyBvp67GiZmqq7iMN3Jlyq84bjQKqA9O07osq
 qDl6BecR3jI/JR7ohD99divvwumPwp5eiVVV3BiJ8xMxNKzNDf9CFtc4nTpT9NvTiZfybHLAg
 edd8/8IR0ohdoAbPDrtKsULagYCRkZdVx9wn3cAwEJl/a+YOsP6NOE2wfSReOKMLVkWvuhtxI
 Ab6CQ7q3E8ciLDIeWnjB6jwdukvQneFE9OmVfWUs9pHp9JnprHnmY9W+cGXlGtI3igCHZZeUR
 xaOo5WXmCUOaF5RDrUkAgGz/ONrW8/DMVl0uYs9tIaJIYi+7hEtuGRBEWtAvMDm2sbz8pMHEn
 ghnwkaz+TKyW59WPFkFpk3+rGH2D8Z4QmDBpsKQ1/LAmqrE6mCmS39v8QXODkkeZhJ3+1/0IE
 0upIoc/DX1UqWjYZJcooXEE3DUFYQ9E8Gjc6iiBnhEQaKwDSl7S+Zuq0EHXww9N7NrlOUFkEf
 bgzFwYuvfw5YCB3I2wsHLel5ZF7NCObQ8o/oR3FfmVqYVksrGHsdQm87Uam44pbwhXz5WWFl2
 uwSgCoWlidXcw/FxL5rvpleNhkoJF/OHtj0XT6iiGoH2dmYPNxzjBWg32ILZ/g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 10, 2019 at 12:23:28AM +0100, Philip Oakley wrote:
> Hi,
>
> Is there a mechanism for exchanging the rerere resolutions, so that futu=
re
> fixups, e.g. future clashes on pu rather than master, can be sent with p=
atch
> series?
>
> My current use case that there is a large patch [1] for updating long to
> size_t for use on Windows, which notes that it will have clashes with pu=
,
> but doesn't appear to have any method=A0 of sending a rerere resolution =
(which
> the author is already aware of) to the list. Being able to flag up such
> fixes should simplify such conflict resolutions.
>
> I had some very rough ideas about how the resolutions should look rather
> similar to three-way conflict markers, with the resolution as the 'base'
> (between the ||| - ||| marks), which would be resolved via a --base merg=
e
> strategy.
>
> However if there is already a method for exchanging resolutions, where
> should I look?
>
> Philip
>
> [1] <20190413151850.29037-1-tboegi@web.de> [PATCH v3 1/1] Use size_t ins=
tead
> of 'unsigned long' for data in memory
>
> --
> Philip
>

That is not an answer to the question.
If it helps, I can rebase the first patch onto git.git/master, and the
cherry-pick the next patches. That can happen next week or so.
And then let it go through the normal pu->next->master->git-for-windows wo=
rkflow.

