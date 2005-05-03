From: Kevin Smith <yarcs@qualitycode.com>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Mon, 02 May 2005 20:24:04 -0400
Message-ID: <4276C4A4.6020103@qualitycode.com>
References: <200505022106.OAA28850@emf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 02:19:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSl72-0002IY-D5
	for gcvg-git@gmane.org; Tue, 03 May 2005 02:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVECAYR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 20:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVECAYR
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 20:24:17 -0400
Received: from deuterium.rootr.net ([203.194.209.160]:45666 "EHLO
	vulcan.rootr.net") by vger.kernel.org with ESMTP id S261246AbVECAYO
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 2 May 2005 20:24:14 -0400
Received: from [10.10.10.20] (147-49.35-65.tampabay.res.rr.com [65.35.49.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vulcan.rootr.net (Postfix) with ESMTP id D8E4E3C0A
	for <git@vger.kernel.org>; Tue,  3 May 2005 00:24:06 +0000 (UTC)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
In-Reply-To: <200505022106.OAA28850@emf.net>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Tom Lord wrote:
> More bluntly, given just a (1),(3) pair, Bob is extending his vulnerability
> to include a reliance on Alice's patch-computing tools.   If Alice were
> known to be signing a (1),(2) pair which she had reviewed in detail,
> then Bob's vulnerability stays at just his local patch-handling tools
> and his general trust of Alice.

I'm no expert, but it seems the opposite argument could be made as well.
By signing (1)(3), I am asserting that (3) is, in fact, what I intended
the end result to be. If I instead sign (1)(2), then it is possible that
your patching tools might end up producing something other than (3).

Personally, I still like the self-contained nature of signing (1)(2),
but I haven't yet heard a security argument in its favor.

Kevin
