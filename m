From: Nasser Grainawi <nasser@codeaurora.org>
Subject: Re: Repacking a repository uses up all available disk space
Date: Sun, 12 Jun 2016 19:43:27 -0600
Message-ID: <C04883EB-2170-47C3-94E7-AE13516FD0C0@codeaurora.org>
References: <20160612212514.GA4584@gmail.com> <20160612213804.GA5428@sigill.intra.peff.net> <20160612215436.GB4584@gmail.com> <20160612221309.GC5428@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 13 03:40:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCGs3-00042f-Dy
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 03:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933103AbcFMBkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jun 2016 21:40:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33196 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933059AbcFMBku convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Jun 2016 21:40:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C748A6141A; Mon, 13 Jun 2016 01:40:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.0
Received: from [192.168.1.27] (c-76-25-249-107.hsd1.co.comcast.net [76.25.249.107])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: nasser@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 4A3C8613E1;
	Mon, 13 Jun 2016 01:40:49 +0000 (UTC)
In-Reply-To: <20160612221309.GC5428@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297148>

On Jun 12, 2016, at 4:13 PM, Jeff King <peff@peff.net> wrote:
> 
>    At GitHub we actually have a patch to `repack` that keeps all
>    objects, reachable or not, in the pack, and use it for all of our
>    automated maintenance. Since we don't drop objects at all, we can't
>    ever have such a race. Aside from some pathological cases, it wastes
>    much less space than you'd expect. We turn the flag off for special
>    cases (e.g., somebody has rewound history and wants to expunge a
>    sensitive object).
> 
>    I'm happy to share the "keep everything" patch if you're interested.

We have the same kind of patch actually (for the same reason), but back on the shell implementation of repack. It'd be great if you could share your modern version.

Nasser

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
