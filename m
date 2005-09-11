From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] Omit patches that have already been merged from format-patch output.
Date: Mon, 12 Sep 2005 09:10:45 +1200
Message-ID: <46a038f905091114106e6e7943@mail.gmail.com>
References: <46a038f905091101529e045af@mail.gmail.com>
	 <7voe6zqr9y.fsf@assigned-by-dhcp.cox.net>
Reply-To: martin.langhoff@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 23:12:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEZ6A-00049j-JH
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 23:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbVIKVKr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 17:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbVIKVKr
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 17:10:47 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:25259 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750901AbVIKVKq convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 17:10:46 -0400
Received: by rproxy.gmail.com with SMTP id i8so279822rne
        for <git@vger.kernel.org>; Sun, 11 Sep 2005 14:10:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CAnndfi3APl2U5PNPigXvFOn0kyO0LJKd7Vp3EeB2D5gaNAvsg5Xh8LNYV2f5Ww3cnbbABz33U/PKZ307krzeveHGVeeSAuB3vHecSlXZAS/LCCodL8Is1bEOPqRz8m0WQvrNILnGiyrMWW5okUVG9tb0ZxmZeqtz93gbtzCmxM=
Received: by 10.38.101.51 with SMTP id y51mr230309rnb;
        Sun, 11 Sep 2005 14:10:45 -0700 (PDT)
Received: by 10.38.101.53 with HTTP; Sun, 11 Sep 2005 14:10:45 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe6zqr9y.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8333>

On 9/12/05, Junio C Hamano <junkio@cox.net> wrote:
> This switches the logic to pick which commits to include in the output
> from git-rev-list to git-cherry; as a side effect, 'format-patch ^up mine'
> would stop working, although up..mine would continue to work.

Also -- forgot to say thanks for this. I'm interested in porting this
to cg-log as an option.

BTW, anyone heard of Baudis lately?

cheers,


martin
