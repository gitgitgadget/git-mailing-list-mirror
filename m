Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2574A1F404
	for <e@80x24.org>; Wed, 25 Apr 2018 07:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751588AbeDYHRm (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 03:17:42 -0400
Received: from mout.gmx.net ([212.227.17.22]:57591 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751332AbeDYHRl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 03:17:41 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M9wrU-1f4aql2Uqe-00B1mz; Wed, 25
 Apr 2018 09:17:35 +0200
Date:   Wed, 25 Apr 2018 09:17:33 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 09/11] technical/shallow: describe the relationship
 with replace refs
In-Reply-To: <xmqq4lk05dau.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1804250917090.4978@tvgsbejvaqbjf.bet>
References: <cover.1524125760.git.johannes.schindelin@gmx.de> <cover.1524262793.git.johannes.schindelin@gmx.de> <853b0a445ab1d78e8cbe19dacd09e70892b34b03.1524262793.git.johannes.schindelin@gmx.de> <52C2C5A51FE7400E937F06B7641F4319@PhilipOakley>
 <nycvar.QRO.7.76.6.1804242106220.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <538CF27C224E4AE0A1C45374AE367C3A@PhilipOakley> <xmqq4lk05dau.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DPDL6OX0C8+91EsSSu5ZkdFmZKFm3MXI2jbyucxuq9gm2fa9GhV
 yA6/rAiKLm6xDO83pXztZE5HlkSxAAt546RZQXP+cFSSycFviBY+CUtsHeNeBed+A1I/+6M
 LXKU2ynK0CJBx5iQ5bv2MUfJ3QdPUdSJQWOTR/CdSG54C8fkpculvcrTplfLY/IpXwx1Yx0
 FNv6l9fjRE18fwKtis58w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:V6niHiH4UF4=:o3N8BChIYPpuhENLcievtQ
 HviWN5xUcp0AF5z9SULx36ufl/zuj/vbw8r2eahODggdi+uZXBwQa9rzl3bFkd2ZXvAIDTUZY
 FM96UpCKs8lJISZvBuZZEuMCpu1c8AZ5pd2HI90fjPy1zBsXFsPcIMwVUdVZw0YadSDviEcGt
 DQnkVGmCdcgVtWoZGL0/xpJt0cTCxeh0Vq6Uyf2zn1mo3w+KDXtPKoT+dWzDFUfBl1EWF+8Ox
 IXFbSVcCRiwvLRANCtin9dVnt+Vd8UxgdTb5Kl9hYiV5Mb/iD93AjivoEuQaDjd1PJ1upVYdI
 z+8Sk5ypYVAhwGBY7BgrukhS39pVNHjnuIz0giEvefjTeAvijwZLisd0pQ47cB17psdPwuuHs
 jjS+p7wYQovgNm9I+LyqTy94trdfNGPzXUP0PYlg9tjujqYzViDFWuxgWe+5TyZSP/SQPX7V3
 mFqzCa+01sCrA44RltHjchkDbEniCIsM3G6OSKCpSA8qxa/OzdNvwSNWZaTYSl2JHsl1f5WQE
 vrY05z9/3HpvKGlKhHFq6LoP3by0EKKcK+AVbjeM95l1AX4mTs0/WMdd5lUcKRmCLcbDwiPS8
 2CaIqAHcIiNdEs0r2PCT9X6+ZhcxmOwnfsriytOBCFBrMntAwIKXeFYaon4/RMlKAV1asaYQ7
 xG5dN9iPjfP15WUkeMvtU0vaf9/tfcRU+55xpYJz9uUNAjcSppbda+M0Y1Asz7IdW5tJaPOdc
 QsH3GsNfKdi9Osh7Y2aP6+LRljyQ1AAhYzefS0Dx8e0Nkt9S6PNcmLd8XNz1gEZNuI/OArhXg
 3+ejAN3/N9k1YDt8D8UbnSqfLTt0v6AP9duJA6QK/vEUSrzerg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip & Junio,

On Wed, 25 Apr 2018, Junio C Hamano wrote:

> "Philip Oakley" <philipoakley@iee.org> writes:
> 
> > Perhaps something like:
> > +$GIT_DIR/shallow, and handle its contents similar to replace
> > +refs (with the difference that shallow does not actually
> > +create those replace refs) with the difference that shallow commits will
> > +always have their parents not present.
> 
> I am not sure if there is enough similarity to replace mechanism to
> mention that.  It has lines of text, each of which records a commit
> object for which Git is told to pretend that it has no parent.
> 
> To those who are familiar with "graft" format, it is possible to
> explain the format as "it is similar to graft", as a line with a
> single commit object name tells Git to pretend that it has no parent
> in the "graft" format, but because we are getting rid of graft, it
> probably makes sense to just explain it without reference to replace
> (which may serve a similar purpose, but is certainly very far from
> "similar" as a mechanism when you explain how the contents of shallow
> is handled).
> 
>     $GIT_DIR/shallow lists commit object names and tells Git to
>     pretend as if they are root commits (e.g. "git log" traversal
>     stops after showing them; "git fsck" does not complain saying
>     the commits listed on their "parent" lines do not exist).

Good point. Thank you for that suggestion, I'll take it as-is.

Ciao,
Dscho
