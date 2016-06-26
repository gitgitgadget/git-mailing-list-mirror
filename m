Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE5A41F744
	for <e@80x24.org>; Sun, 26 Jun 2016 04:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbcFZEIb (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 00:08:31 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:48623 "EHLO
	homiemail-a13.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750940AbcFZEIa (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jun 2016 00:08:30 -0400
Received: from homiemail-a13.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a13.g.dreamhost.com (Postfix) with ESMTP id 030CF334075;
	Sat, 25 Jun 2016 21:08:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=subject:to
	:references:cc:from:message-id:date:mime-version:in-reply-to
	:content-type:content-transfer-encoding; s=novalis.org; bh=r9z2u
	KuMTxHPXdBD2+J+EYKLJO4=; b=Ca/dXxi/0bYzNryK+5kwTtKCy13pOTFAT7t0L
	R9On9amUpNMXq/QLZur2tzrGz4HfipU3kDoFKQm+C9SzdXbOkeIWQedozu+5X58/
	RWIWHCEygt6Fz8It+lAQMYg3MVvtaETvz2F+DH1sW9e1du1yErDP/b9VCRWuUDpZ
	fWkUSI=
Received: from [10.0.1.180] (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: novalis@novalis.org)
	by homiemail-a13.g.dreamhost.com (Postfix) with ESMTPSA id B2C5D33406B;
	Sat, 25 Jun 2016 21:08:29 -0700 (PDT)
Subject: Re: [PATCH v12 00/20] index-helper/watchman
To:	Duy Nguyen <pclouds@gmail.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
 <CACsJy8CKxzpphPB4iST_QzP1BqxYZuPKftyvsovwphysXzGa3A@mail.gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>
From:	David Turner <novalis@novalis.org>
Message-ID: <576F553C.8020107@novalis.org>
Date:	Sun, 26 Jun 2016 00:08:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8CKxzpphPB4iST_QzP1BqxYZuPKftyvsovwphysXzGa3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 06/25/2016 09:28 AM, Duy Nguyen wrote:
> On Thu, May 19, 2016 at 11:45 PM, David Turner <dturner@twopensource.com> wrote:
>> Of course, as soon as I pinged on the previous version, I noticed an issue.
>> ...
>
> A bit off-topic, but you may want to cut a release for libwatchman
> (even 0.1.0 would do) so it can be properly packaged.
>

I've mentioned this to Keith.  Unfortunately, he doesn't seem to have 
write access to the repo yet, but hopefully the Twitter folks will soon 
fix this.
