From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 6/9] streaming_write_entry: propagate streaming errors
Date: Mon, 25 Mar 2013 16:29:47 -0700
Message-ID: <20130325232947.GJ1414@google.com>
References: <20130325201427.GA15798@sigill.intra.peff.net>
 <20130325202216.GF16019@sigill.intra.peff.net>
 <20130325213934.GE1414@google.com>
 <20130325214936.GA22419@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 26 00:30:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKGqQ-0006Io-3v
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 00:30:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759043Ab3CYX3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 19:29:55 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33775 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759031Ab3CYX3w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 19:29:52 -0400
Received: by mail-pa0-f53.google.com with SMTP id bh4so1055935pad.26
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 16:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=FicjrXScrUTISMsKxf85XtrfSZfAlx3uEwBVhHZ/hsI=;
        b=iNZHwjz56frJ4mMGcV1UMQ2gLyC61r/ONLtBLvBEz7Fp77KT70C4GpNXnJkNyY8Gc+
         c2RtB2wsPpfTN767/IQVliQQJKpODdi7t5geZz3A2AX7JPKy2bd1u6RJZNfAYplezmhm
         y+MHkPscLTy185qF1jNV1SewTJ2Tw1e/JYb0IFl/EXqbk5irpr+gUx8pEhL9/uRvLmeY
         WDjN6IavKya90yqFT+NookbX8pvz4ak0MwiGhys1oRBBVxhKa6Lrgn//n/PGhZQJfuAZ
         dvVBC8hWCr/o+DFoCCZ7Tw7bF2J9fipqSrfMkGU9C7Mbqb1IL4iBtOz/3L37aZ3w3wPR
         vFPQ==
X-Received: by 10.66.157.36 with SMTP id wj4mr9076727pab.88.1364254192532;
        Mon, 25 Mar 2013 16:29:52 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id u9sm16505263paf.22.2013.03.25.16.29.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 Mar 2013 16:29:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130325214936.GA22419@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219118>

Jeff King wrote:

> Both fixed in my re-roll.

Thanks!  This and the rest of the patches up to and including patch 8
look good to me.

I haven't decided what to think about patch 9 yet, but I suspect it
would be good, too.  In the long term I suspect "git clone
--worktree-only <repo>" (or some other standard interface for
git-new-workdir functionality) is a better way to provide a convenient
lightweight same-machine clone anyway.

Jonathan
