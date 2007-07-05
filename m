From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] git init: activate rerere by default
Date: Thu, 5 Jul 2007 15:10:01 +0200
Message-ID: <81b0412b0707050610mddaf5c0w724b747fe10ed6f9@mail.gmail.com>
References: <Pine.LNX.4.64.0707051312260.9789@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 05 15:10:12 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6R64-0002qO-7N
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 15:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759124AbXGENKF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 09:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759065AbXGENKF
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 09:10:05 -0400
Received: from ik-out-1112.google.com ([66.249.90.176]:4975 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757339AbXGENKE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 09:10:04 -0400
Received: by ik-out-1112.google.com with SMTP id b32so1845735ika
        for <git@vger.kernel.org>; Thu, 05 Jul 2007 06:10:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LrpssX8EORwOZV2S6W8LWL/8DyTFsRC7jCjQhZb6PFqrWNqmB+CspbtJAtq2QW2921bivpYdpkPc4Y8Vp7RfNff6GpkRbtc3y5Rt7e6Ket7JV9whM4bbF46NBm+n/hjGMqwac9YpxI/rTlGYMgkLST+RTYtYTmw6AZdoxSYN3yA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Or+B8iGEZUzSfC6PtPw1cON1h3pQXpmItG10/1fvuhydr7tw76b+TUKCQvxsE+ncljDe0rcZ2mNm0FJ7gFZ4V3KBK6of8K1CAXkbLSaoYQDm4oCdFWJOg3SBjimDAXbruV2kFW+Y/jtbgvKDX1tNi+FZwkTIuMnL9FpcsHvvopM=
Received: by 10.78.21.7 with SMTP id 7mr4684539huu.1183641001629;
        Thu, 05 Jul 2007 06:10:01 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Thu, 5 Jul 2007 06:10:01 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707051312260.9789@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51673>

On 7/5/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> We have a working implementation of rerere since long ago, and we even
> make sure that it works as expected in a test case.  It is also a very
> useful feature, so why not turn it on for the benefit of users who are
> not even aware of it? This patch does that.

Maybe just create in template directory?
