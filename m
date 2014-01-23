From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 08/23] ewah: compressed bitmap implementation
Date: Thu, 23 Jan 2014 12:18:18 -0800
Message-ID: <20140123201818.GY18964@google.com>
References: <20131221135651.GA20818@sigill.intra.peff.net>
 <20131221135953.GH21145@sigill.intra.peff.net>
 <20140123020536.GP18964@google.com>
 <20140123183320.GA22995@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 23 21:18:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6QjQ-0007ZV-1L
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 21:18:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867AbaAWUS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 15:18:27 -0500
Received: from mail-bk0-f50.google.com ([209.85.214.50]:39504 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753875AbaAWUSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 15:18:25 -0500
Received: by mail-bk0-f50.google.com with SMTP id w16so626127bkz.23
        for <git@vger.kernel.org>; Thu, 23 Jan 2014 12:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=TxV0asvBFiAnRtcudIY2CfCDQrUw9E8bj9DREG+ge2k=;
        b=Peu5KwJpd9xjoP8GOw0R6C9gToPF9txiZby910M1/jG1L4RHD2qiL/sQ7ODxQBm5hF
         dnYHyfa/6oh62MS2O0CNP3vZMnGSHnUS2anyfy1IuncZi/OZtOnw69ZJl5V9VxwHC1gA
         VNAlwoKNYlM7Ltq1TluYRGzt2cpUTd7Kt4Yqp8B0PicJVjzuynbgEsrk+efXoCV5843k
         5rnuPEZtd/+ZRr5IubvYbb/BqSRB89FZqNnBsiojNqVVzfUF5B/ZFIUfcqm30DKpex5W
         W+f6dlQAFvMi00wUMcUZuScM5lAq6t3aGXym2nf+2JOrVhKiKL3squopxGtNX5MOpKzZ
         YYiA==
X-Received: by 10.205.17.70 with SMTP id qb6mr1706579bkb.97.1390508303788;
        Thu, 23 Jan 2014 12:18:23 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id lr9sm177691bkb.2.2014.01.23.12.18.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 23 Jan 2014 12:18:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140123183320.GA22995@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240944>

Jeff King wrote:

>   [1/2]: compat: move unaligned helpers to bswap.h
>   [2/2]: ewah: support platforms that require aligned reads

After setting NEEDS_ALIGNED_ACCESS,
Tested-by: Jonathan Nieder <jrnieder@gmail.com> # ARMv5
