From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Teach "approxidate" about weekday syntax
Date: Fri, 18 Nov 2005 14:40:57 +1300
Message-ID: <46a038f90511171740x756b0336ib8b8937ee3a2af03@mail.gmail.com>
References: <Pine.LNX.4.64.0511171223110.13959@g5.osdl.org>
	 <7v1x1eubpr.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0511171505080.13959@g5.osdl.org>
	 <Pine.LNX.4.63.0511180030260.18775@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 02:49:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcvM9-0001tM-W7
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 02:48:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbVKRBr7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 20:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbVKRBr7
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 20:47:59 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:20008 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932280AbVKRBr6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 20:47:58 -0500
Received: by zproxy.gmail.com with SMTP id x7so77470nzc
        for <git@vger.kernel.org>; Thu, 17 Nov 2005 17:47:58 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UWT3f1MZgMZ1QK/4mU3e4/Xf9rgOnGUsNwsI3jggfvcABlPXofTM/cZLTFcf0/a0ebYHyvZzNijO7/q7TLFeXYZneEdJl7BaLtVL3oeBDGmCOR9Fmufg6+Ytw6sWEgArPX5cluCtVC+LM8sM7c3AN+zQl3mHRu7v6PeL/r105So=
Received: by 10.64.250.1 with SMTP id x1mr2479412qbh;
        Thu, 17 Nov 2005 17:40:58 -0800 (PST)
Received: by 10.64.241.15 with HTTP; Thu, 17 Nov 2005 17:40:57 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511180030260.18775@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12183>

On 11/18/05, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Thu, 17 Nov 2005, Linus Torvalds wrote:
> > Seriously, I can't imagine what else we'd want.
> An error when there's a chance the result is unexpected?

That'd be even harder to define -- I'd rather have it spit out what it
interpreted so that porcelains can display it to the user. The user
can tell at a glance if the parser is off -- for it will be off by a
mile.


m
