From: Nico Williams <nico@cryptonector.com>
Subject: Re: How safe are signed git tags? Only as safe as SHA-1 or somehow safer?
Date: Mon, 24 Nov 2014 12:14:34 -0600
Message-ID: <CAK3OfOgko5Fb5FMGCKw3+12fAzMVEHuUriaiBNGi8nb28bNTQA@mail.gmail.com>
References: <5468C33E.2080108@whonix.org>
	<20141117212657.GC15880@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 24 19:14:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xsy9p-0005v3-2n
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 19:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579AbaKXSOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 13:14:37 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:47572 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753170AbaKXSOg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 13:14:36 -0500
Received: from homiemail-a55.g.dreamhost.com (sub4.mail.dreamhost.com [69.163.253.135])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 5018A8762C
	for <git@vger.kernel.org>; Mon, 24 Nov 2014 10:14:36 -0800 (PST)
Received: from homiemail-a55.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a55.g.dreamhost.com (Postfix) with ESMTP id E2C70E0B
	for <git@vger.kernel.org>; Mon, 24 Nov 2014 10:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=
	mime-version:in-reply-to:references:date:message-id:subject:from
	:to:content-type; s=cryptonector.com; bh=lEplofg9+OrnJ2NlDixQz7u
	q5Vk=; b=AzT4HpxVbRmwQkyt/YIZ67W8ftWsDJp/sI16ZQaZUwe2lvWxduJvn6H
	22Ci2YRtmpA3ymHvxE6B40ek8QQ1pXGaVLahioYPSOW5+bQVwFRofPSfKZhdxzr/
	LYSTSIKxYpzKakpRNVy/lBt4GgjpTgYviMreFnJ+p2J4RgM8TtZg=
Received: from mail-wg0-f48.google.com (mail-wg0-f48.google.com [74.125.82.48])
	(using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a55.g.dreamhost.com (Postfix) with ESMTPSA id B8096E10
	for <git@vger.kernel.org>; Mon, 24 Nov 2014 10:14:35 -0800 (PST)
Received: by mail-wg0-f48.google.com with SMTP id y19so13025713wgg.7
        for <git@vger.kernel.org>; Mon, 24 Nov 2014 10:14:34 -0800 (PST)
X-Received: by 10.195.11.68 with SMTP id eg4mr35377118wjd.18.1416852874882;
 Mon, 24 Nov 2014 10:14:34 -0800 (PST)
Received: by 10.216.32.136 with HTTP; Mon, 24 Nov 2014 10:14:34 -0800 (PST)
In-Reply-To: <20141117212657.GC15880@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260135>

Is there a plan for upgrading to a better hash function in the future?
 (E.g., should it become an urgent need.)

What are the roadblocks to adoption of a replacement hash function?
Just documenting this would go a long way towards making it possible
to upgrade some day.

Thanks,

Nico
--
