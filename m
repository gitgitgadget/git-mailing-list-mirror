Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA12320179
	for <e@80x24.org>; Mon, 20 Jun 2016 10:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571AbcFTKGl (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 06:06:41 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:56122 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbcFTKGk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 06:06:40 -0400
Received: from tigra.domain007.com ([192.168.2.102])
	by mailhub.007spb.ru (8.14.4/8.14.4/Debian-4) with SMTP id u4UBBF71009537;
	Mon, 30 May 2016 14:11:16 +0300
Date:	Mon, 30 May 2016 14:11:15 +0300
From:	Konstantin Khomoutov <kostix+git@007spb.ru>
To:	matveevma <matveevma@jinr.ru>
Cc:	git@vger.kernel.org
Subject: Re: ssh key
Message-Id: <20160530141115.a6692c0e50abc2a2d2f85190@domain007.com>
In-Reply-To: <5c45dd8c03d2a9e0079796ce6850af9f@jinr.ru>
References: <5c45dd8c03d2a9e0079796ce6850af9f@jinr.ru>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, 28 May 2016 16:47:06 +0300
matveevma <matveevma@jinr.ru> wrote:

> Can i add SSH id_rsa.pub to GIT by shell terminal?

Hi!

First things first: this list has nothing to do neither with Github nor
with shells of any sort.  Please note that Github it not Git, it rather
is a hosting for Git projects, so if you have a Github-specific
question please direct it to Github support channels [2, 3], thanks.

As to the essence of your question, it appears that Github has a rich
RESTful API, so you should be able to register your SSH key using
`curl` or a similar tool using Github webAPI calls described in [1].

1. https://developer.github.com/v3/repos/keys/
2. https://help.github.com/
3. https://github.com/contact
