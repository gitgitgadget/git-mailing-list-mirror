Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AECCE1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 17:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeA2RDD (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 12:03:03 -0500
Received: from mout.gmx.net ([212.227.15.15]:54412 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751262AbeA2RDC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 12:03:02 -0500
Received: from [192.168.0.129] ([37.201.193.1]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MA91t-1eUyQy2xkf-00BLFm; Mon, 29
 Jan 2018 18:02:57 +0100
Date:   Mon, 29 Jan 2018 18:02:56 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jacob Keller <jacob.keller@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 9/8] [DO NOT APPLY, but squash?] git-rebase--interactive:
 clarify arguments
In-Reply-To: <CA+P7+xoO4twSgYVNJ4WaTj80WHS_ViEOBOEVST1nX9UzRA4JxQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1801291802400.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <20180118183618.39853-1-sbeller@google.com> <20180118183618.39853-2-sbeller@google.com> <nycvar.QRO.7.76.6.1801182233480.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <xmqqinbxpp5m.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xoO4twSgYVNJ4WaTj80WHS_ViEOBOEVST1nX9UzRA4JxQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:nyIvVbeMc4aAZVky6DB0sMcM5xtknQkp3tF1IQqZZIJAhTmU15i
 pLUOpksxP8HUZbH2qJMR8uuz79AuBNDGLkfZouCheuKXCc47SqoKU5cPG6TKe6Qp4zhAPRz
 HOtUiwf7WLeIaN3yPq89fFOTeZ0OIgF0npFshPlumWkRQ/awbN+/JLVEAM3OA8jfsmNxjug
 TjfLy8xXvZ1BoTOjLY5rg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KtilAnyoJhY=:Na2SLx+9wRTwW2CG2ebdDx
 ECgMsjvnQI/jvbFPXaxN+7NHpxj0F5/WXN+m5gLFkeV20IBUVWYHrOM1SoW7MwiaBKIpqk+W/
 II6mSoO/qYXiHQqLpGuy0UK2Y3zQT86MTxAZEonCnStTY3EaCWDue54nMzYeCCRQ5BySQXHUR
 6+ViX0BGZKOD9thZbm9S2fKU5qH9KVa2y8DWAz+nn5f2NvpkLdAqJbyUPzYWnkhDx2gDSYj0Y
 piJQCugyrZQsBV6O6WCfxLwcV6F2jhbZ44IUy8SH5a3NP42skVVjyHZdgyA5FFMb4T/ldJ+Dd
 nRsyLjxL5GvUIDP/oCOsl/P8Qx6y+Rfpiv0jdt/34aQqSDspl2Af0FJh2vx3gVRr1X/1b1s8g
 3cBOL805qOiR2klHoshuMw2MD5ZsXUDTlvklI6anoBul3BxG1+5GR+deEP1d6qIkH4XPrFNGT
 0eole0MvYAQECaeHE18yY3jK1xaaxDLDdAxPIGejihetOT1/HsRimmQlhB1IF5AuBtKU5Ql2M
 f3iv7dGXHD7FmCYFYRlWfz4LXxg8JBhozFwVjTOQMbRxxcejHdkaKP3OJE6yi7rBrNd+5QtLN
 ygWiXGTA1dtOUWIKZwOp9YoXJdsHhGpfhs6jdBF+a94Lq0hytmUydcoqxKxnrLztHZtLFrFtT
 +5gLpDl/ohD4yoNFfaxxl80iGoho5RJ8KYdpI0qsEtp2+uHaGs04CfpTO1wqF2Apj2BO4wwKs
 7eAmBzgRC9e/+ENtiWzOjj4UtFvV3vdWOfh24o9Z7eCRGg5oeFYgHbs6bjSPd3VipNogqPM95
 S4rK5YVfQmlR/RpQLkS21hAo0gV0WWJXrZhBwJuqOEqJGDF/viYn+X/TerykiVZwRM7cd25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 20 Jan 2018, Jacob Keller wrote:

> On Fri, Jan 19, 2018 at 12:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >> Good idea! I would rather do it as an introductory patch (that only
> >> converts the existing list).
> >>
> >> As to `merge`: it is a bit more complicated ;-)
> >>
> >>       m, merge <original-merge-commit> ( <label> | "<label>..." ) [<oneline>]
> >>               create a merge commit using the original merge commit's
> >>               message (or the oneline, if "-" is given). Use a quoted
> >>               list of commits to be merged for octopus merges.
> >
> > Is it just the message that is being reused?
> >
> > Aren't the trees of the original commit and its parents participate
> > in creating the tree of the recreated merge?  One way to preserve an
> > originally evil merge is to notice how it was made by taking the
> > difference between the result of mechanical merge of original merge
> > parents and the original merge result, and carry it forward when
> > recreating the merge across new parents.  Just being curious.
> >
> 
> It looks like currently that only the commit is kept, with no attempt
> to recreate evil merges.

Yep. I even documented that somewhere ;-)

Ciao,
Dscho
