From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] Restore expected list order for --merge-order switch
Date: Wed, 6 Jul 2005 09:21:50 +1000
Message-ID: <2cfc403205070516216b911160@mail.gmail.com>
References: <20050705010619.13581.qmail@blackcubes.dyndns.org>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Wed Jul 06 01:24:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpwmK-0006oA-ON
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 01:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVGEXXM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jul 2005 19:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbVGEXXL
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jul 2005 19:23:11 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:39801 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262012AbVGEXVu convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Jul 2005 19:21:50 -0400
Received: by rproxy.gmail.com with SMTP id i8so969427rne
        for <git@vger.kernel.org>; Tue, 05 Jul 2005 16:21:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R+jVdCMIQKj/25PPE974DaEsJQMgBfbbIaKA3ZKyLxMMOZkUJTDOTkuJfrGUVuHyxGOfaj7iiqEGGDIq2ZxMgwfq9FJVHtgkHS9NBq4bCgcu1KRABaMWi2rKESKehGfQSXpEi8BJ9xmjfsRdtsqifNoCAagBqFABGxp14Y08Yxk=
Received: by 10.38.65.5 with SMTP id n5mr4397973rna;
        Tue, 05 Jul 2005 16:21:50 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Tue, 5 Jul 2005 16:21:50 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <20050705010619.13581.qmail@blackcubes.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

G'day Linus,

Is there some reason why this didn't get applied?

jon.

On 7/5/05, Jon Seymour <jon.seymour@gmail.com> wrote:
> 
> A recent change to rev-list altered the order in which start points
> are presented to the merge-order sort algorithm. This caused
> breaks in the t/t6001 unit tests.
> 
> This change restores the order in which start points are presented to the
> the merge-order sort algorithm (but leaves the order unchanged from
> the immediately preceding behaviour for non --merge-order sorts).
> 
> The order in which arguments are presented to the merge-order
> sort algorithm is significant, since left-most arguments
> are expected to sort last so as to be consistent with
> how left-most parents sort.
> 
> Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
