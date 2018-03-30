Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32F501F404
	for <e@80x24.org>; Fri, 30 Mar 2018 12:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751749AbeC3Mgx (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 08:36:53 -0400
Received: from mail.javad.com ([54.86.164.124]:43615 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751118AbeC3Mgw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 08:36:52 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id A6B143E9A4;
        Fri, 30 Mar 2018 12:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522413411;
        bh=ha72L2EwR6W3M0o2uuyEl/IJijn0N1DaivIcZmDbH2U=; l=1813;
        h=Received:From:To:Subject;
        b=LHBHVzzz8Gc+I27ksspLnsXU5HdZbhmSwj96qtSCupw42FeYPeOmBQcRc9O9vHVHO
         6cMsyl5DHjBdByWEveTxmrh+RgtBF4CXM1L/+2vMWj+yCfhWmw4F1sLXQMm2yCwjoY
         GBRBFZLWACUZcXfk4/nRDX7njn2FXPMZcdz9dubw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522413411;
        bh=ha72L2EwR6W3M0o2uuyEl/IJijn0N1DaivIcZmDbH2U=; l=1813;
        h=Received:From:To:Subject;
        b=LHBHVzzz8Gc+I27ksspLnsXU5HdZbhmSwj96qtSCupw42FeYPeOmBQcRc9O9vHVHO
         6cMsyl5DHjBdByWEveTxmrh+RgtBF4CXM1L/+2vMWj+yCfhWmw4F1sLXQMm2yCwjoY
         GBRBFZLWACUZcXfk4/nRDX7njn2FXPMZcdz9dubw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522413411;
        bh=ha72L2EwR6W3M0o2uuyEl/IJijn0N1DaivIcZmDbH2U=; l=1813;
        h=Received:From:To:Subject;
        b=LHBHVzzz8Gc+I27ksspLnsXU5HdZbhmSwj96qtSCupw42FeYPeOmBQcRc9O9vHVHO
         6cMsyl5DHjBdByWEveTxmrh+RgtBF4CXM1L/+2vMWj+yCfhWmw4F1sLXQMm2yCwjoY
         GBRBFZLWACUZcXfk4/nRDX7njn2FXPMZcdz9dubw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522413411;
        bh=ha72L2EwR6W3M0o2uuyEl/IJijn0N1DaivIcZmDbH2U=; l=1813;
        h=Received:From:To:Subject;
        b=LHBHVzzz8Gc+I27ksspLnsXU5HdZbhmSwj96qtSCupw42FeYPeOmBQcRc9O9vHVHO
         6cMsyl5DHjBdByWEveTxmrh+RgtBF4CXM1L/+2vMWj+yCfhWmw4F1sLXQMm2yCwjoY
         GBRBFZLWACUZcXfk4/nRDX7njn2FXPMZcdz9dubw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522413411;
        bh=ha72L2EwR6W3M0o2uuyEl/IJijn0N1DaivIcZmDbH2U=; l=1813;
        h=Received:From:To:Subject;
        b=LHBHVzzz8Gc+I27ksspLnsXU5HdZbhmSwj96qtSCupw42FeYPeOmBQcRc9O9vHVHO
         6cMsyl5DHjBdByWEveTxmrh+RgtBF4CXM1L/+2vMWj+yCfhWmw4F1sLXQMm2yCwjoY
         GBRBFZLWACUZcXfk4/nRDX7njn2FXPMZcdz9dubw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522413411;
        bh=ha72L2EwR6W3M0o2uuyEl/IJijn0N1DaivIcZmDbH2U=; l=1813;
        h=Received:From:To:Subject;
        b=LHBHVzzz8Gc+I27ksspLnsXU5HdZbhmSwj96qtSCupw42FeYPeOmBQcRc9O9vHVHO
         6cMsyl5DHjBdByWEveTxmrh+RgtBF4CXM1L/+2vMWj+yCfhWmw4F1sLXQMm2yCwjoY
         GBRBFZLWACUZcXfk4/nRDX7njn2FXPMZcdz9dubw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522413411;
        bh=ha72L2EwR6W3M0o2uuyEl/IJijn0N1DaivIcZmDbH2U=; l=1813;
        h=Received:From:To:Subject;
        b=LHBHVzzz8Gc+I27ksspLnsXU5HdZbhmSwj96qtSCupw42FeYPeOmBQcRc9O9vHVHO
         6cMsyl5DHjBdByWEveTxmrh+RgtBF4CXM1L/+2vMWj+yCfhWmw4F1sLXQMm2yCwjoY
         GBRBFZLWACUZcXfk4/nRDX7njn2FXPMZcdz9dubw=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1f1tGy-0001x2-Tl; Fri, 30 Mar 2018 15:36:48 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution(RoadClear)
References: <87y3jtqdyg.fsf@javad.com>
        <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com>
        <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <c5a5c2cc-6a11-440f-5b9b-964ae1ca07dd@talktalk.net>
        <f3872fb9-01bc-b2f1-aee9-cfc0e4db77d6@gmail.com>
        <nycvar.QRO.7.76.6.1803111301340.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <b329bb98-f9d6-3d51-2513-465aad2fa37a@gmail.com>
        <nycvar.QRO.7.76.6.1803121142550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <243ca23d-77a9-4ae1-a120-de6c6b195cdc@gmail.com>
        <nycvar.QRO.7.76.6.1803261455130.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87woxyf4lk.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803271536020.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <874ll0d9nt.fsf@javad.com>
        <CA+P7+xoDQ2mzhxeZPFhaY+TaSoKkQm=5AtoduHH06-VggOJ2jg@mail.gmail.com>
        <87r2o48mm2.fsf@javad.com>
        <CA+P7+xo19mHrWz9Fy-ifgCcVJM2xwzcLj7F2NvFe2LwGbaJiDQ@mail.gmail.com>
        <87zi2r5swc.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803301235560.5026@qfpub.tvgsbejvaqbjf.bet>
Date:   Fri, 30 Mar 2018 15:36:48 +0300
In-Reply-To: <nycvar.QRO.7.76.6.1803301235560.5026@qfpub.tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Fri, 30 Mar 2018 12:38:55 +0200
        (DST)")
Message-ID: <87bmf5zqn3.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> Hi,
>
> On Thu, 29 Mar 2018, Sergey Organov wrote:
>
>> Jacob Keller <jacob.keller@gmail.com> writes:
>> 
>> > I care about the general compatibility of the rebase todo list
>> > regardless of which options you enabled on the command line to
>> > generate it.
>> 
>> It's a good thing in general, yes. However, I recall I was told by the
>> author that --recreate-merges was introduced exactly to break backward
>> compatibility of the todo list. If so, could we please agree to stop
>> using backward compatibility as an objection in the discussion of this
>> particular feature?
>
> That is a serious misrepresentation of what I said.
>
> If I had changed --preserve-merges to the new format, *that* would have
> broken backwards-compatibility.
>
> So the entire reason of introducing --recreate-merges was to *not have to
> break backwards-compatibility*.
>
> I definitely did not say the *exact opposite*.

I'm sorry I committed ambiguity in my wording that allowed it to be
misinterpreted. I actually intended to say roughly the same thing you
are saying, as what matters for the discussion is that new todo list
format does not need to be (backward-)compatible to that of
--preserve-merges. 

> Hopefully this clarifies your confusion,

There was actually no confusion on my side, and I like your wording
better.

Except that you've managed to clarify your intentions without actually
addressing the primary concern:

Could we please agree to stop using backward compatibility as an
objection in the discussion of the  --recreate-merges feature?

Could we?

I understand you are still resistant to change 'pick' syntax, but it's
not because of backward-compatibility, right?

-- Sergey
