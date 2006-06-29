From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] move get_merge_bases() to core lib; use it in merge-recursive
Date: Thu, 29 Jun 2006 16:12:38 +0200
Message-ID: <81b0412b0606290712h4960ee8et7ea219d4dd6428b4@mail.gmail.com>
References: <81b0412b0606270848v2253209aw52466de632ab25c1@mail.gmail.com>
	 <Pine.LNX.4.63.0606271830210.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20060627223249.GA8177@steel.home>
	 <Pine.LNX.4.63.0606291517010.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.63.0606291519440.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>,
	"Fredrik Kuivinen" <freku045@student.liu.se>,
	"Linus Torvalds" <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Jun 29 16:12:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvxG7-0002G0-Iw
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 16:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWF2OMl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 10:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWF2OMk
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 10:12:40 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:65105 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750747AbWF2OMk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 10:12:40 -0400
Received: by ug-out-1314.google.com with SMTP id a2so348661ugf
        for <git@vger.kernel.org>; Thu, 29 Jun 2006 07:12:39 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TE+OD5QINkUmSPIvGQHmEedT18xFisBfPiO8ToceeU+ZQIUJa+C1vPhRG2zi7IfGaEWszHRRN8tdz8s7PYgLoOH0UL68dwr1R+2WLIufLsDFuZpCc1IT+blx1ezUxeBfOf3Nshu5Oql5nY9656hGhgG6mn2zwYlT4lX7LYrtirw=
Received: by 10.78.159.7 with SMTP id h7mr964374hue;
        Thu, 29 Jun 2006 07:12:38 -0700 (PDT)
Received: by 10.78.37.7 with HTTP; Thu, 29 Jun 2006 07:12:38 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606291519440.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22865>

On 6/29/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Aargh! Of course this is [PATCH 2/2]. BTW, no signoff, since the whole
> merge-recursive is not mergeable yet (passes the tests, but we have a
> small way to go).

How did you get it to pass the tests? Maybe you still have git-merge-recursive
as default merge strategy?
