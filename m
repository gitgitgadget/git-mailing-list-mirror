Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB4601F404
	for <e@80x24.org>; Fri, 30 Mar 2018 13:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751368AbeC3Ndz (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 09:33:55 -0400
Received: from mout.gmx.net ([212.227.15.15]:46747 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751258AbeC3Ndy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 09:33:54 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MOfx8-1evpsr2Ous-0068ph; Fri, 30
 Mar 2018 15:33:47 +0200
Date:   Fri, 30 Mar 2018 15:33:46 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Sergey Organov <sorganov@gmail.com>
cc:     Jacob Keller <jacob.keller@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
In-Reply-To: <87bmf5zqn3.fsf@javad.com>
Message-ID: <nycvar.QRO.7.76.6.1803301523060.5026@qfpub.tvgsbejvaqbjf.bet>
References: <87y3jtqdyg.fsf@javad.com> <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <c5a5c2cc-6a11-440f-5b9b-964ae1ca07dd@talktalk.net> <f3872fb9-01bc-b2f1-aee9-cfc0e4db77d6@gmail.com>
 <nycvar.QRO.7.76.6.1803111301340.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <b329bb98-f9d6-3d51-2513-465aad2fa37a@gmail.com> <nycvar.QRO.7.76.6.1803121142550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <243ca23d-77a9-4ae1-a120-de6c6b195cdc@gmail.com>
 <nycvar.QRO.7.76.6.1803261455130.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87woxyf4lk.fsf@javad.com> <nycvar.QRO.7.76.6.1803271536020.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <874ll0d9nt.fsf@javad.com> <CA+P7+xoDQ2mzhxeZPFhaY+TaSoKkQm=5AtoduHH06-VggOJ2jg@mail.gmail.com>
 <87r2o48mm2.fsf@javad.com> <CA+P7+xo19mHrWz9Fy-ifgCcVJM2xwzcLj7F2NvFe2LwGbaJiDQ@mail.gmail.com> <87zi2r5swc.fsf@javad.com> <nycvar.QRO.7.76.6.1803301235560.5026@qfpub.tvgsbejvaqbjf.bet> <87bmf5zqn3.fsf@javad.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:dO8L69MMD3mZpCri9TT3YK8mx8+Q3BLhmLdCvoHD9euZ+m8zZGJ
 wHy8d2kpxh2hERtBWmzaPMUt/a8zKC9rrFN7fXdBlLFWn06QriqEbP87WSPIGSUWv1kVcAM
 2mmmTlQ2Jc6W+tNqsOOBh0dN1k+VLhYFEigzxVs2VgoewQONVAsdiyOE8XSS5wMu+Ur5gu9
 /ouZ2kxrFWWayPtuN0/zQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0ACvstk7n6U=:nqtzAIQw4jzoi9a9yfDRG5
 xuz1zLxzvCzLdtmQcXzPVAuPNO7HwEpQLW9xZ89JIx00VXJJTRko2jBvmqCJj9iihiJPD/q8w
 YFJJDlW6lrPqa0pfJNuJMei8wlc3KoNQpz/M4pyyMn8EW0A5Uv2SphF92wZQAx+OKgnbZDTQ0
 bgm2O7manddCLJG2KOHQ7QA76qQdrVFDA7OV5BBIGHvRsDgPnkVTXxfW8ars/VyZ0n9+LfRgY
 nkXmd58jGxDTuUwfxMMzuYxJfsy57O/Nw2uO+5YUY6NBOzhuWY55cac/E5MKB4j8KBalhx9iz
 rfDn/+tkIBBMwEdOO2hGC6fZBZ0juqev4agBjCFz85gdAT2AGaf6ViLIHzI1e4NaVoXLAXMzS
 zgWLDBykNgrKq4DXqi8uKjz+sQqs8Mv81XAMel8IAxxNlIBfbwh/L2FRK78cT4j7cgwtGWa8E
 zz6Z4Mm6D7CL8RJnPbCIZKj1oUO1jMOUC1xKWIWrH80ISEDfuPa0fB6wTEVqmHNRP6QgXug+l
 yWuZCDdH+KPJ3XmH+F9VziKfIFTUj/81ntDE8R5SCzviNAEr2jIvCJ3q1E2T3nUSGTX6Haqk9
 840Dje9laaQ9AYuiL3Wv/6hMnxGHrq8fKED2GmZTPdCuxhMx5gQUEdc3WGQgYnZTLBs3I+hWB
 elmZTdDI5O2o7UF84PLzSJMWk2v15sI2twrTvP4eI6qtfo5BAfqPS7Ke8xQqsEBfkAMkuk4AA
 bWZY1vaDFa+au5Q0G0+mCJtdyjtvIXsRnHnVz27yBTfvVEOMmRMuLMjIjVTUzfQkcAD5bXzmC
 1hnWbUDEa4LXF4RFS2Ztpyrh5PP2eHtGA7Dq+rEOeUNPc69UxkTnZSFlYPjbS6EXp82Is8+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On Fri, 30 Mar 2018, Sergey Organov wrote:

> Could we please agree to stop using backward compatibility as an
> objection in the discussion of the  --recreate-merges feature?

No.

The expectation of users as to what a `pick` is has not changed just
because you wish it would.

That is a matter of backwards-compatibility.

You see, if you are driving a car for a hundred years already, and then
switch to a different car, and it has a lever in the same place as your
previous car's windshield wiper, but in the new car it has a button that
activates the emergency driver seat ejection OMG *it has a seat ejection
like in the James Bond movies! Where can I get that car?* Sorry for
disgressing.

I am really concerned about that willingness to put an innocuous button,
so to speak, onto something users got really used to, over the course of a
decade or so, when that button should really be made red and blinking and
OMG where can I get that car?

So to reiterate, I am really interested in a practical solution that won't
cause nasty surprises. Meaning: `pick` != merge. That was a mistake in
preserve-merges, as I have only mentioned like a hundred times, and we
won't repeat it.

Now back to that important question: where can I get such a James Bond
car? Ideally also with Turbo Boost. Oh wait, that was somebody else's car.

Ciao,
Johannes
