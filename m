From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Convention for help in git commands?
Date: Wed, 26 Oct 2005 09:24:48 +1300
Message-ID: <46a038f90510251324s50911b88pb5eabb304644bcad@mail.gmail.com>
References: <200510251508.43552.Josef.Weidendorfer@gmx.de>
	 <7vfyqpe87x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 22:27:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUVLp-0005OF-5u
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 22:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbVJYUYu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 16:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbVJYUYt
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 16:24:49 -0400
Received: from xproxy.gmail.com ([66.249.82.203]:48815 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932348AbVJYUYt convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 16:24:49 -0400
Received: by xproxy.gmail.com with SMTP id t7so492353wxc
        for <git@vger.kernel.org>; Tue, 25 Oct 2005 13:24:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EESdYZ2lJ4hyBm70lxLhHSEKLNicIEMDbB+y/9icC98tiUbM1Y/P2SWVvsW7o/mFP44L2pp3AEPWK40eUjZCTswVM4NJ6SMWWII+I4pLV2PRrY6jn3tm+0AFH6gSBFatWnP5yPPZ4oFYqHImYF0v9Qkh/1aq7dT4Y2rPK7jHr/A=
Received: by 10.64.210.13 with SMTP id i13mr85772qbg;
        Tue, 25 Oct 2005 13:24:48 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Tue, 25 Oct 2005 13:24:48 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyqpe87x.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10613>

On 10/26/05, Junio C Hamano <junkio@cox.net> wrote:
> > * For commands which need at least one argument, the usage
> > is also printed, if the command is run without argument
>
> This is slightly debatable.  I'd rather see it error out for one
> thing, and we might want to do a sane default given no arguments
> later.

This could lead to subtle bugs when git is used by porcelains. If
there are going to be changes in default behaviours, let's have them
soon-ish ;-)

cheers,


martin
