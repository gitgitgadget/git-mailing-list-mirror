From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: GPF in index-pack
Date: Sun, 6 Aug 2006 00:16:51 -0400
Message-ID: <9e4733910608052116u4d58908cj654ea94716b546e6@mail.gmail.com>
References: <9e4733910608051805j1192d910hf55393f1dbe1e472@mail.gmail.com>
	 <9e4733910608051944v5af7e552wd6909b9773dd516e@mail.gmail.com>
	 <20060806024858.GC20565@spearce.org>
	 <9e4733910608051958h6144add7td46de70dd8b45a5e@mail.gmail.com>
	 <20060806033222.GD20565@spearce.org>
	 <9e4733910608052100t463e6fb8gba54e4afde1ab19a@mail.gmail.com>
	 <20060806040848.GF20565@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 06 06:16:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9a4O-0003dW-6E
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 06:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbWHFEQx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Aug 2006 00:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbWHFEQx
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Aug 2006 00:16:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:15843 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751528AbWHFEQw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Aug 2006 00:16:52 -0400
Received: by nf-out-0910.google.com with SMTP id p46so72564nfa
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 21:16:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s4Rx3/yZDtttZ9BtBqL2fEHI0qCj4is4suAIE4WV+a4Yh+CtIuR69ReiChje6xBgCt2Ds6Yhqjlpo4fgnW0bSp81Fiw13vZ1ecghJLnXi7d5RdAzV4JbPxlRioGC3t0ouxk50ICM6BrJF1Ex/PypynP3CF2uOXEg7tzYkkc5qdY=
Received: by 10.78.175.14 with SMTP id x14mr2043363hue;
        Sat, 05 Aug 2006 21:16:51 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Sat, 5 Aug 2006 21:16:50 -0700 (PDT)
To: "Shawn Pearce" <spearce@spearce.org>
In-Reply-To: <20060806040848.GF20565@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24962>

On 8/6/06, Shawn Pearce <spearce@spearce.org> wrote:
> > When I put index-pack in gdb at the seg fault, resolve_delta had
> > recursed more than 20,000 times. I stopped looking after that.
>
> Ouch.  I'm not familiar with this code, but looking at right now its
> also not entirely obviously what its recursing for.  Plus dinner
> is trying to be burned on the grill, so my attention is on that
> more than on GIT.  :-)

It has recursed 131,000 times before running out of memory. Something
must be wrong in the resolve_delta() logic.

-- 
Jon Smirl
jonsmirl@gmail.com
