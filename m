From: Martin Fick <mfick@codeaurora.org>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Thu, 24 May 2012 18:17:45 -0600
Organization: CAF
Message-ID: <201205241817.46034.mfick@codeaurora.org>
References: <4FB9F92D.8000305@alum.mit.edu> <20120521174525.GA22643@sigill.intra.peff.net> <20120521221417.GA22664@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 25 02:17:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXiE5-0006Wc-1M
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 02:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757535Ab2EYARs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 20:17:48 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:57813 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229Ab2EYARr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 20:17:47 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6721"; a="192217663"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 24 May 2012 17:17:47 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 008A110004A9;
	Thu, 24 May 2012 17:17:47 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32.49+drm33.21-mfick7; KDE/4.4.5; x86_64; ; )
In-Reply-To: <20120521221417.GA22664@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198453>

On Monday, May 21, 2012 04:14:17 pm Jeff King wrote:
> On Mon, May 21, 2012 at 01:45:25PM -0400, Jeff King wrote:
> Martin, let me know if this improves things for your
> many-ref cases (and if you are still seeing slowness in
> your repos with many refs, let me know which operations
> cause it).

Peff,

I have not been ignoring you, I am sorry that I have not 
replied yet.  Unfortunately, I am having a very hard time 
getting conclusive tests with my large repo.  I making
plenty of mistakes in what I think I am testing I believe,
but also I am having a hard time getting reproducible 
results so far.  And some tests take quite a while, so it is 
not always obvious what I might be doing wrong.

I will let you know more when I figure out what I am doing 
wrong, but please know that I have been doing a lot of 
testing and plan to post some results eventually.

Were your tests mostly warm cache tests?

-Martin

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
