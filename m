Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24FF9208E9
	for <e@80x24.org>; Fri, 20 Jul 2018 18:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388379AbeGTTlu (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 15:41:50 -0400
Received: from mout.gmx.net ([212.227.15.19]:55305 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388160AbeGTTlu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 15:41:50 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MaqqY-1fQhFZ4C54-00KRhU; Fri, 20
 Jul 2018 20:52:12 +0200
Date:   Fri, 20 Jul 2018 20:51:54 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: refs/notes/amlog problems, was Re: [PATCH v3 01/20] linear-assignment:
 a function to solve least-cost assignment problems
In-Reply-To: <xmqqa7qngnon.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807202049540.71@tvgsbejvaqbjf.bet>
References: <cover.1525448066.git.johannes.schindelin@gmx.de> <pull.1.v3.git.gitgitgadget@gmail.com> <39272eefcfe66de3ca1aa2ee43d6626ce558caae.1530617166.git.gitgitgadget@gmail.com> <xmqqtvpcgf40.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807071320110.75@tvgsbejvaqbjf.bet>
 <xmqq7em7gg3j.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807072116570.75@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1807080017160.75@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1807092342490.75@tvgsbejvaqbjf.bet> <xmqqefg94uq1.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1807121720340.75@tvgsbejvaqbjf.bet> <xmqq8t6gz8xz.fsf@gitster-ct.c.googlers.com> <xmqqa7qngnon.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NyCwhRTKOMW+l3WrbPTzn1vDRLsjrm5onjyr3Xl67jkUYxCtK8X
 VCw0TWTUfuk2UdUk4xhP9sgpCymHT/bUMxScJpa9BDss1MYY6/53QBwIsFkEi7P+wi0A0u8
 KK0OIztYW9EZ7zbxO1i1qUb81FGSh7/4kqgvlkEngkJYUZVrI9MNPMCCPSkGOvPchcMPbYb
 KpBzrHmNiuOfNm0pq91Dw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:F25+pf7hLzk=:Bsy9PMtmq/tVSPsOe2VkKv
 iM5wQJUAqHSUViHQP3rOruPP9et0+Q6Ha8ECpBMJCGVa2q54RvdvpIFMReYNkjJlUVJyQDl+Z
 uy8y6NqIPpt6BMTBDPjR/DsLXD4QxIp3BHaFvdB7XuZ/H75OXf/tmUE9dONZ9e5JdlP9Aw1MA
 ZVaOWlpWW5OkkGWaB4cV1EJqUJvXtH4zgyogaQnHGaMcyV+IKcJplHT3kvTQpDnVD4iIVIUFg
 HZVcmGu+5jb9dI+MhV2TEweVwtyXb+MuACyCPVxd6TM5ui2i7yN3Eadeymiq3NWA/ooLVwLgf
 yxMIwWJECHcXAlHCQGNvi9BgawKBmVHOt2GPWMWndkK7rtnpWkdgdSb8OgDg5gQjyWLROx8mT
 O5/uIc6iLM9+nWMUkkSjapGFBcF4KKzOjzL8vEPSnbHAUm6s5oUr5cBUVh0eRNtzNt02TQPVi
 Gsi0dK89OAxHKXsAd21BULcHrz3xx9Ch4MMajaG6/sBWGhoySn8u46rDGYlRdDvrmaqCVRwQp
 eOEx1Lb3Ep4uhbTZ/73Hjs3PJNTfsMKNxCBs2DcwA2HwGRHmtyfMiEEA3/h7lZu9FGsvyWes7
 10PV+6ijaR9Kphq9lUYE2jnXsCV481/Oas8VCX+7dB5KcvF93sr9LXOcI7qj55KAS/8JDVfG0
 n0JwlQpeOKpY+8cFcSWtG5neZ6fX/NIyPclkFoJw+aGpIncb3CEOM6yWDIZJWUdn3U0ZR1pwi
 x2oBrr6WZsZ32Y+bcrPfzjVlY8djF37JNMIMkXtblV+B9pKUTGdDI4xbboPRryMDO/ZBeu7qQ
 WlEqylY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 19 Jul 2018, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >> I would like to ask you to reinstate the post-rewrite hook, as it still
> >> improves the situation over the current one.
> >
> > Without post-rewrite I seem to be getting correct amlog entries for
> > commits created by "git rebase"; do our rebase--am backend still
> > trigger post-applypatch hook in its "am" phase to apply the patches
> > created with "format-patch"?
> 
> That was a wrong line of thought that led to a dead end.  format-patch
> won't recreate Message-Id to its output from notes/amlog, so even if
> the "format-patch --stdout | am" pipeline inside rebase-am triggered
> the post-applypatch hook, it would not have a chance to carry the
> notes forward that way.
> 
> What was really happening was I have
> 
> 	$ git config --list | grep amlog
> 	notes.rewriteref=refs/notes/amlog
> 
> and that ought to be sufficient to carry "commit-to-original-msg-id"
> entries across rebases.  And it seems to correctly work.  I however
> suspect that "cherry-pick A..B" may lose the notes, but I haven't
> checked.

AFAICT there is at least one scenario where you run `rebase -i`, the notes
get updated, and of course the *reverse mapping* does *not* get updated:
you have a mapping both from commit to Message-Id *and crucially* from
Message-Id to commit. The automatic rewrite of commit notes in `rebase -i`
tackles only the commit notes, obviously, not the reverse.

Hence the post-rewrite hook I think I already suggested at least once in a
previous reply.

Ciao,
Dscho
