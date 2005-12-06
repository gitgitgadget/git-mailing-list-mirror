From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: make gitfakemmap standalone to fix linking error in git.c
Date: Tue, 6 Dec 2005 08:49:09 +0100
Message-ID: <81b0412b0512052349u56cba9d9s98d6c8594c54a398@mail.gmail.com>
References: <81b0412b0512050519k5ed80035x9eb4907f569e0a4b@mail.gmail.com>
	 <81b0412b0512050524w7b632651n93c836fda41a39d@mail.gmail.com>
	 <7vfyp7cuii.fsf@assigned-by-dhcp.cox.net>
	 <20051205213612.GA4443@steel.home>
	 <7vvey39pto.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 08:50:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjXZc-0002ow-3m
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 08:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbVLFHtM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 02:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbVLFHtM
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 02:49:12 -0500
Received: from nproxy.gmail.com ([64.233.182.205]:26662 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751500AbVLFHtL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 6 Dec 2005 02:49:11 -0500
Received: by nproxy.gmail.com with SMTP id x29so98111nfb
        for <git@vger.kernel.org>; Mon, 05 Dec 2005 23:49:09 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cqalcUkX5x9LUeKDzzk7JJR1a0Db2ngAZZgGdNcwLRRJC/d7BjlQPkG0CECbtairP3G6k7+W54kZECwmgMQh26PmiHIxH22cJBRxPVl5Vo1DeBlKHCwwnQaU6adSYFgP4V28QRyCoLxB+CWCf4o4SXM926bRQpapBMyu/UdH+cM=
Received: by 10.48.217.1 with SMTP id p1mr30301nfg;
        Mon, 05 Dec 2005 23:49:09 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Mon, 5 Dec 2005 23:49:09 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvey39pto.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13264>

On 12/5/05, Junio C Hamano <junkio@cox.net> wrote:
> >> > Why does it always happen...
> >> Because you touched you did not absolutely have to ;-).
> >
> > well, git$(X) didn't link...
>
> I meant your change to the "if ()" expression in gitfakemmap().
> Does the change have anything to do with git$X linkage?  I think
> not.

Oh, yes. Sorry. Too much sorries recently :(
