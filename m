Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17EBB2022A
	for <e@80x24.org>; Sat, 29 Oct 2016 16:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751900AbcJ2QHy (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Oct 2016 12:07:54 -0400
Received: from homie.mail.dreamhost.com ([208.97.132.208]:42671 "EHLO
        homiemail-a62.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751352AbcJ2QHy (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 29 Oct 2016 12:07:54 -0400
Received: from homiemail-a62.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a62.g.dreamhost.com (Postfix) with ESMTP id B7E1163406E;
        Sat, 29 Oct 2016 09:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=
        mattmccutchen.net; bh=9LrpR2iqVvOCJNL6hEq8R4Dv0Ik=; b=hP6HDcpj7Z
        +CGyrs+t2sXNDMb42T4jEPZrCFboiyqqjRLzFeOCl1tlj9ghgd7htzfMsqh+gyW7
        5WVPjBHpqY3AxBan5JbRolD+cvuroUd1CwyyICsjP+zo3mSNXueQxHEOoY31umVy
        XufGUcREnkrMzMwpptcbCNtbre1GNDQBc=
Received: from main (c-50-177-20-184.hsd1.ma.comcast.net [50.177.20.184])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a62.g.dreamhost.com (Postfix) with ESMTPSA id 5825B63406C;
        Sat, 29 Oct 2016 09:07:51 -0700 (PDT)
Message-ID: <1477757268.1524.20.camel@mattmccutchen.net>
Subject: Re: Fetch/push lets a malicious server steal the targets of "have"
 lines
From:   Matt McCutchen <matt@mattmccutchen.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Sat, 29 Oct 2016 12:07:48 -0400
In-Reply-To: <CAPc5daVOxmowdiTU3ScFv6c_BRVEJ+G92gx_AmmKnR-WxUKv-Q@mail.gmail.com>
References: <1477690790.2904.22.camel@mattmccutchen.net>
         <xmqqmvhoxhfp.fsf@gitster.mtv.corp.google.com>
         <1477692961.2904.36.camel@mattmccutchen.net>
         <xmqq7f8sx8lg.fsf@gitster.mtv.corp.google.com>
         <1477712029.2904.64.camel@mattmccutchen.net>
         <CAPc5daVOxmowdiTU3ScFv6c_BRVEJ+G92gx_AmmKnR-WxUKv-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2016-10-28 at 22:31 -0700, Junio C Hamano wrote:
> Not sending to the list, where mails from Gmail/phone is known to get
> rejected.

[I guess I can go ahead and quote this to the list.]

> No. I'm saying that the scenario you gave is bad and people should be
>=C2=A0taught not to connect to untrustworthy sites.

To clarify, are you saying:

(1) don't connect to an untrusted server ever (e.g., we don't promise
that the server can't execute arbitrary code on the client), or

(2) don't connect to=C2=A0an untrusted server=C2=A0if the client reposito=
ry has
data that needs to be kept secret from the server?

The fetch/push attack relates only to #2. =C2=A0If #1, what are the other
risks you are thinking of?

Matt
