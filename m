From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git /objects directory created 755 by default?
Date: Thu, 22 Dec 2005 11:11:25 +0100
Message-ID: <81b0412b0512220211o74f7f533j11b8e48311b61ec2@mail.gmail.com>
References: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com>
	 <7vacevgwqr.fsf@assigned-by-dhcp.cox.net>
	 <7vlkyffcxp.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0512211502130.25834@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vek465cev.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0512212317400.18684@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 11:11:37 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpNQ2-0006ed-0k
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 11:11:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbVLVKL1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 05:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbVLVKL1
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 05:11:27 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:56788 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750731AbVLVKL0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 05:11:26 -0500
Received: by nproxy.gmail.com with SMTP id x29so114333nfb
        for <git@vger.kernel.org>; Thu, 22 Dec 2005 02:11:25 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YzsC2kV0im54cA727YPZZXkTJGw5NnAeyVtghuLb19OGCEYhiNQtGxSjVV3048fxaGDJ74IdHy78F8deJLyoctWyV+gQ2WXO70zD1RSE9uALV4zRoC7RCp9QKgcu+ehkEaA137ITqF7hIRsM/sk9rtnUDD0BtvTQFec9F5NaSqg=
Received: by 10.49.68.6 with SMTP id v6mr18719nfk;
        Thu, 22 Dec 2005 02:11:25 -0800 (PST)
Received: by 10.48.247.10 with HTTP; Thu, 22 Dec 2005 02:11:25 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0512212317400.18684@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13939>

On 12/21/05, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > >
> > >     [core]
> > >             umask = 0002
> So, I tend to say: use core.umask only in shared setups (in which you
> should not checkout files unless you know exactly what you are doing).

May be "shell.umask" or "shared.umask" ?
