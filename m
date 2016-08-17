Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E43AF1FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 13:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbcHQNJO (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 09:09:14 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:58555 "EHLO
	homiemail-a22.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750839AbcHQNJN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Aug 2016 09:09:13 -0400
Received: from homiemail-a22.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a22.g.dreamhost.com (Postfix) with ESMTP id 2E034114068;
	Wed, 17 Aug 2016 06:08:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
	:subject:from:to:cc:date:in-reply-to:references:content-type
	:mime-version:content-transfer-encoding; s=novalis.org; bh=3owQa
	Ui7hEnHiQVOiCRlPqSJWSQ=; b=Y6KTVmnYYIHoZL6wIyztuTx077/01f+/pKXih
	etQqx/B69l4EgN5HNM5IfTxZ9ywYm+PT63iEnKJYmLQCVuTl6ZAf+QGRcxetjwIi
	nU/jwsG8kCYak+O7eNSBagXdWJFMrsqAv/FU7WMIpEdgovuJnDN+1Z2qxkrljFRk
	atZM/g=
Received: from [10.0.1.180] (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: novalis@novalis.org)
	by homiemail-a22.g.dreamhost.com (Postfix) with ESMTPSA id A7777114067;
	Wed, 17 Aug 2016 06:08:37 -0700 (PDT)
Message-ID: <1471439316.20273.2.camel@frank>
Subject: Re: What's cooking in git.git (Aug 2016, #06; Sun, 14)
From:	David Turner <novalis@novalis.org>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Date:	Wed, 17 Aug 2016 09:08:36 -0400
In-Reply-To: <CACsJy8BYk1t5cfN_dgc8o3HCi8Rqz9aM_5XFWMUkMTKXu2R7=A@mail.gmail.com>
References: <xmqqmvkfj7dz.fsf@gitster.mtv.corp.google.com>
	 <CACsJy8BYk1t5cfN_dgc8o3HCi8Rqz9aM_5XFWMUkMTKXu2R7=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, 2016-08-17 at 17:49 +0700, Duy Nguyen wrote:
> On Mon, Aug 15, 2016 at 5:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > * dt/index-helper (2016-07-06) 21 commits
> >
> >  A new "index-helper" daemon has been introduced to give newly
> >  spawned Git process a quicker access to the data in the index, and
> >  optionally interface with the watchman daemon to further reduce the
> >  refresh cost.
> >
> >  Not quite ready yet, it seems.
> >  cf. <alpine.DEB.2.20.1607061016330.6426@virtualbox>
> >  cf. <CACsJy8AiER_=5aJ65r+GPCE_nXbrPTAMKJi=FuJgT8zzV2-NFw@mail.gmail.com>
> 
> David I can take back this series if you are busy or no longer interested in it.
> 
> If so, Junio, since I may try some slightly different direction first,
> it may take a while before I resubmit, feel free to drop it if it adds
> work to you.

Unfortunately, I am pretty busy.  So please do feel free to take over.  

