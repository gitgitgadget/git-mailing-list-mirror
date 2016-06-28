Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BA4F1FF40
	for <e@80x24.org>; Tue, 28 Jun 2016 11:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343AbcF1L3s (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 07:29:48 -0400
Received: from li209-253.members.linode.com ([173.255.199.253]:53144 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752050AbcF1L3r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 07:29:47 -0400
Received: from 206-55-177-216.fttp.usinternet.com ([206.55.177.216] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.86)
	(envelope-from <greened@obbligato.org>)
	id 1bHqfz-0001LX-5N; Tue, 28 Jun 2016 05:55:31 -0500
From:	greened@obbligato.org (David A. Greene)
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, sunshine@sunshineco.com,
	davidw@realtimegenomics.com
Subject: Re: [PATCH v5 1/1] contrib/subtree: Add a test for subtree rebase that loses commits
References: <CAPig+cS6ouc+kdJaz10M2AApPoDODDcgDX9Azz8ih=4zxxD2zg@mail.gmail.com>
	<3eb25268597083cdb10303e3d5790302e719a803.1453172369.git.greened@obbligato.org>
	<xmqqsi1tbh68.fsf@gitster.mtv.corp.google.com>
	<87wpr4ubzo.fsf@waller.obbligato.org>
	<xmqqpotummqn.fsf@gitster.mtv.corp.google.com>
Date:	Tue, 28 Jun 2016 05:55:30 -0500
In-Reply-To: <xmqqpotummqn.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 12 Apr 2016 16:27:28 -0700")
Message-ID: <871t3heg65.fsf@waller.obbligato.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Filter-Spam-Score:  ()
X-Filter-Spam-Report: 
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> greened@obbligato.org (David A. Greene) writes:
>
>>> I also notice that files_subtree/master4 does not appear in any of
>>> the verification in the three tests that use the history being
>>> prepared here, i.e. if master4 is silently dropped while master5 is
>>> kept, such a bug won't be caught by them.
>>
>> Ah, good catch.  I should add a test for that.
>>
>> Let me do a re-roll of this since I think you bring up some excellent
>> points.  Might be a few days due to work obbligations.
>
> A friendly ping to see if I missed anything that happened after this
> message...

Just sent it.  I guess it took more than a few days... :)

                   -David
