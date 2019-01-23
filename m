Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDE541F453
	for <e@80x24.org>; Wed, 23 Jan 2019 11:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfAWLld (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 06:41:33 -0500
Received: from mout.gmx.net ([212.227.15.18]:54279 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726993AbfAWLld (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 06:41:33 -0500
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M8eAd-1h993B02ux-00wBUA; Wed, 23
 Jan 2019 12:41:22 +0100
Date:   Wed, 23 Jan 2019 12:41:21 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH 1/1] tests: explicitly use `test-tool.exe` on Windows
In-Reply-To: <xmqqpnsoe7av.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901231239470.45@tvgsbejvaqbjf.bet>
References: <pull.111.git.gitgitgadget@gmail.com>        <f396aa113ac3c50ca6a2402cedc71a37cdf63504.1548083538.git.gitgitgadget@gmail.com> <xmqqpnsoe7av.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bjghnIVrMHUV4Yum3ON6K9HIFqVzI4Y4bGdaaJ+wP4YGZghFm60
 D8XokCEL5wF2LrGNWNkLCIYP4Y5F2VndAyc6vAPC6w+2Uf46arzaD8OGFVFwwNUBYhjQBNP
 6fYYz/X5TwHPA7HnAlyx2ZP+WIOKD7dvku/BnWno1anvqRbeqZq4ZL0KwttDe1d77qlIoS4
 z1200IHe0IpulPtTJhnXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q0gYEvow4f0=:g9ywrE24jUf5RJdYpbcp4o
 2qoatm8uU4Jbo8ElfI+OkgqfRbzFOOt+9hiROH4VRS+jMDS1BRtSe29aehW3mjtZEV5+vsWCZ
 atwojZed4faie+0ujtHM2iaSGDrhmzCROU9xXkcVZJq+761JpsO5R0amNIgl+j9J4L8VxjY0/
 mtthAejWn6dyDpygG1qln+mg9iTnmriCYxH3f45tOzlxWp6YSgF5TAR3QE7dZoaclWxCHlWav
 JKgPCCPWHw1h0I6KGI98xLDiixpvmB4uYqfnVW4s95Ok2xcxcQRgCUAVeMWD412D98XzKcyh3
 RdHYPf8jzN2O6EHitnKPGeg7c+mN4CUNjIPlkxtfRjLvIb3WnhIOnkCHi2OjisksglR57D75R
 DhbuEcjiXEPX2qblcDIs64kqlxjMLaoWC+cuAAct3R9UNgmo/dVIikrxhPnIA+sN9ulkigt/l
 vr8bEMeHMmx3YOb3l3Tz3hOC22pmXuuyF38JvrCVS6QFbyQCgaNxVYfTjUq3tQ7wzcSZ/E2X4
 o953lMEY1V8Ia+bjp9aG4FP+N3XKVFEt0dY38Jd8pxFHBzzsv1nrXb/Q2kJbqmAYlgUuHc5eT
 tmezkvsBoiwXlpYsdIkeF7cio0le3a4PSO3ZgoeFO/aGtIS4WxNo4PdmVOQL+ugqhu/j2/UpF
 ZvwoAKlbLtRisvFN9F/WZGY3dYTWhScPKt8bakW/Xv/KgZy7mt6B1eVHbhj2DcQSQBhl9SqLd
 yB61SMlekLsbRmWKWRvdgSqwTg9Smx5ZGbX3/6semeIlwcuPzViE2DOHWJAYfbMKsC9yBd2SS
 ivQ3ZETP7hlz9qSeuW76XRsgKpBr6jQhblfxpBMx69S+BLC33Ydmx0ZNqgRGmGk7A5/GMIjIp
 1YNcPRND5lg1723ArIBEEcImDcWqKXrkTRNVzxsHJKgpM7nDH70C84VYvfmHjqLemVkM8ZqCY
 X3YFcb6BXZg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 22 Jan 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > In 8abfdf44c882 (tests: explicitly use `git.exe` on Windows,
> > 2018-11-14), we made sure to use the `.exe` file extension when
> > using an absolute path to `git.exe`, to avoid getting confused with a
> > file or directory in the same place that lacks said file extension.
> >
> > For the same reason, we need to handle test-tool.exe the same way.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  t/test-lib.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index a1abb1177a..9876b4bab0 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -1154,7 +1154,7 @@ test -d "$GIT_BUILD_DIR"/templates/blt || {
> >  	error "You haven't built things yet, have you?"
> >  }
> >  
> > -if ! test -x "$GIT_BUILD_DIR"/t/helper/test-tool
> > +if ! test -x "$GIT_BUILD_DIR"/t/helper/test-tool$X
> >  then
> >  	echo >&2 'You need to build test-tool:'
> >  	echo >&2 'Run "make t/helper/test-tool" in the source (toplevel) directory'
> 
> Thanks for being thorough.  Will queue.

Thank you for the praise. In this instance, I do not deserve it, though,
as it was the MSVC patch series (which I hope to send the mailing list's
way soon) that identified this problem. And it was Ben's bug report
(privately, as we're team mates) that pointed out that I forgot this in
the original patch series.

Ciao,
Dscho
