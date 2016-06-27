Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4711D2018A
	for <e@80x24.org>; Mon, 27 Jun 2016 16:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961AbcF0Qx6 (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 12:53:58 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:53428 "EHLO
	homiemail-a19.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751831AbcF0Qx5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2016 12:53:57 -0400
Received: from homiemail-a19.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a19.g.dreamhost.com (Postfix) with ESMTP id AACDC604069;
	Mon, 27 Jun 2016 09:53:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=subject:to
	:references:cc:from:message-id:date:mime-version:in-reply-to
	:content-type:content-transfer-encoding; s=novalis.org; bh=TWzoT
	2VJ8VEs3dzueB3TeHl5OrY=; b=Bcf90fmuxGff5ilkIUiI9Uoi7ZlXVeQ8FzAD+
	nzn+ULr5NVWEQvAeRDWD74fFQUSuI2TQCjwKJcoojfrzky45I0JeWdEAIYqdEmbt
	pXFMhEewBGv1Y4ckh8bV7ElzAYACBHIh6Dvj4qN39+em5ZZ2WbR7NJR0g7AYOv7W
	f8zOuI=
Received: from [10.0.1.180] (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: novalis@novalis.org)
	by homiemail-a19.g.dreamhost.com (Postfix) with ESMTPSA id 04A8B604061;
	Mon, 27 Jun 2016 09:53:50 -0700 (PDT)
Subject: Re: [PATCH v13 04/20] index-helper: new daemon for caching index and
 related stuff
To:	Keith McGuigan <kamggg@gmail.com>, git@vger.kernel.org,
	pclouds@gmail.com
References: <1466914464-10358-1-git-send-email-novalis@novalis.org>
 <1466914464-10358-4-git-send-email-novalis@novalis.org>
 <CAFUO74nENapwVsM3CUst9AHqy5LcKTFBCnJxGXPk8E952t+X5Q@mail.gmail.com>
Cc:	David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>
From:	David Turner <novalis@novalis.org>
Message-ID: <57715A1D.3030705@novalis.org>
Date:	Mon, 27 Jun 2016 12:53:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <CAFUO74nENapwVsM3CUst9AHqy5LcKTFBCnJxGXPk8E952t+X5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 06/27/2016 08:58 AM, Keith McGuigan wrote:
>
> If 'indexhelper.exitafter' is set to 0, then loop is called with
> idle_in_seconds == 0.  It gets converted to -1, but then
> 'idle_in_seconds * 1000' is passed to poll(), so poll gets an argument
> of -1000, which it EINVALs on.

Silly OS X!

Will squash when I re-roll thanks.



