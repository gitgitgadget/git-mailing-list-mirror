Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE05C1F858
	for <e@80x24.org>; Mon, 14 Nov 2016 19:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934090AbcKNTIH (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 14:08:07 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:59168 "EHLO
        homiemail-a61.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753379AbcKNTIH (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 14 Nov 2016 14:08:07 -0500
Received: from homiemail-a61.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a61.g.dreamhost.com (Postfix) with ESMTP id 6655557807D;
        Mon, 14 Nov 2016 11:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=
        mattmccutchen.net; bh=mLkToz/mflH84WCQ9KEIPP+2/3I=; b=UYhpAIBCP5
        vAs1JvWWwzH6YnxYkUcGEozHnA1+hhxnR5gf37yueQLEW/KpdznEvMQNRRf93XkR
        u2e9kuJqMKsoc82wCqsYsWbv0E7AUYn6U2HjopWdZwyzkrQiKe53F+v3NfryvtvE
        amNUnOu5NXLRV6oPcrHWFfL2upWQGwE6w=
Received: from main (30-10-119.wireless.csail.mit.edu [128.30.10.119])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a61.g.dreamhost.com (Postfix) with ESMTPSA id DB458578077;
        Mon, 14 Nov 2016 11:08:05 -0800 (PST)
Message-ID: <1479150482.2406.35.camel@mattmccutchen.net>
Subject: Re: [PATCH] fetch/push: document that private data can be leaked
From:   Matt McCutchen <matt@mattmccutchen.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Date:   Mon, 14 Nov 2016 14:08:02 -0500
In-Reply-To: <xmqqbmxhyjij.fsf@gitster.mtv.corp.google.com>
References: <xmqqy416uvan.fsf@gitster.mtv.corp.google.com>
         <1479001205.3471.1.camel@mattmccutchen.net>
         <xmqq1syezs3g.fsf@gitster.mtv.corp.google.com>
         <1479148088.2406.27.camel@mattmccutchen.net>
         <xmqqbmxhyjij.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2016-11-14 at 11:00 -0800, Junio C Hamano wrote:
> Matt McCutchen <matt@mattmccutchen.net> writes:
>=20
> >=20
> > >=20
> > > Yup, and then "do not push to untrustworthy place without
> > > checking
> > > what you are pushing", too?
> >=20
> > If there is no private data in the repository, then there is no
> > need
> > for the user to check what they are pushing. As I've indicated
> > before,
> > IMO manually checking each push would not be a workable security
> > measure in the long term anyway.
>=20
> Then what is?

Don't put private data in the same repository, then the whole issue
becomes moot. =C2=A0Am I missing something?

Matt
