From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] move get_merge_bases() to core lib; use it in merge-recursive
Date: Thu, 29 Jun 2006 16:14:38 +0200
Message-ID: <81b0412b0606290714v66a32976j531e2077ce6c1d77@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Thu Jun 29 16:15:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvxI3-0002k8-0g
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 16:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWF2OOk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 10:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWF2OOk
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 10:14:40 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:6488 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750760AbWF2OOj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 10:14:39 -0400
Received: by ug-out-1314.google.com with SMTP id a2so349809ugf
        for <git@vger.kernel.org>; Thu, 29 Jun 2006 07:14:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lj4WX8CWRFV/6dCBwavecCMGO7aVn4RYhgW7qZBNKpgrjRojdh3SjnElStHhnqNT363GS5OafcuOZDOzk0z6Tu6n9SyswoY3yJyRFLtPFX4bBBwwJCVaTqPigD5eHXB1iHAyWEG+T9lYUxAEFARKIBm7DxA3zeBuqlJDwLFdFSA=
Received: by 10.78.157.15 with SMTP id f15mr973699hue;
        Thu, 29 Jun 2006 07:14:38 -0700 (PDT)
Received: by 10.78.37.7 with HTTP; Thu, 29 Jun 2006 07:14:38 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606291517010.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22867>

On 6/29/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> most of this patch is just a "sub-file rename", i.e. moving code
> literally (sue me, SCO!) from merge-base.c to commit.c.
>

BTW, you probably want to post merge-recursive.c changes separately.
