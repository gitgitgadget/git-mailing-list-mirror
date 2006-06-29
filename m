From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] move get_merge_bases() to core lib; use it in merge-recursive
Date: Thu, 29 Jun 2006 16:13:21 +0200
Message-ID: <81b0412b0606290713y41b2e1dblbec3cd962f109f05@mail.gmail.com>
References: <81b0412b0606270848v2253209aw52466de632ab25c1@mail.gmail.com>
	 <Pine.LNX.4.63.0606271830210.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20060627223249.GA8177@steel.home>
	 <Pine.LNX.4.63.0606291517010.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>,
	"Fredrik Kuivinen" <freku045@student.liu.se>,
	"Linus Torvalds" <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Jun 29 16:13:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvxGs-0002Rq-Cz
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 16:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWF2ONY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 10:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWF2ONY
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 10:13:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:16980 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750753AbWF2ONX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 10:13:23 -0400
Received: by ug-out-1314.google.com with SMTP id a2so349066ugf
        for <git@vger.kernel.org>; Thu, 29 Jun 2006 07:13:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=quacvIgqMRG5teoqFKC07dJypLosAtWwZ2625ytgeeo1mcqb6CGJvjHT20jyWwDM6geyGcyP0FKGw9ygeEGmOOS+zPfkl+E+JXKkr7siYp8JwR1nibUzyIz2AXpx3/54mhAaKkJu0mK9A3A6cwUF4CRVOFFHTSV6Zq058GjN5qw=
Received: by 10.78.151.15 with SMTP id y15mr974781hud;
        Thu, 29 Jun 2006 07:13:21 -0700 (PDT)
Received: by 10.78.37.7 with HTTP; Thu, 29 Jun 2006 07:13:21 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606291517010.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22866>

On 6/29/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> most of this patch is just a "sub-file rename", i.e. moving code
> literally (sue me, SCO!) from merge-base.c to commit.c.
>

Aah, thanks! Will try it later today.
