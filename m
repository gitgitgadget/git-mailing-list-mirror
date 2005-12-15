From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Now what: multiple HEAD refs
Date: Thu, 15 Dec 2005 15:54:27 +0100
Message-ID: <81b0412b0512150654o49e1edacu67b88df6347736d2@mail.gmail.com>
References: <81b0412b0512150105p5bacd6a1j938824ae2ab96858@mail.gmail.com>
	 <7v8xumr9mw.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0512150216w295a5943ma66522befe381529@mail.gmail.com>
	 <7vlkymph4f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 15:58:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmuV7-0001bd-Kh
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 15:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbVLOOya (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 09:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbVLOOya
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 09:54:30 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:36751 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750765AbVLOOy3 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 09:54:29 -0500
Received: by nproxy.gmail.com with SMTP id x29so127559nfb
        for <git@vger.kernel.org>; Thu, 15 Dec 2005 06:54:28 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q5F/ysqCPydk1oA8SgwD6Ksk8jy5wZswezvsgv1x34c0qAU9CVj/THYKFDyGdbHhZ2pmCZ+2pA50GTVQnQdhgqfOnn66uFjwHS0bDrQKDDopNM+CGtEgBjtvaS7Wg2c1zc5qOX1rGVXkuCxR37fJlQkol4BQdLUPUGXvYrycY3I=
Received: by 10.48.235.1 with SMTP id i1mr90689nfh;
        Thu, 15 Dec 2005 06:54:28 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Thu, 15 Dec 2005 06:54:27 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkymph4f.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13696>

On 12/15/05, Junio C Hamano <junkio@cox.net> wrote:
> >> >
> >> > $ git pull . ref1 HEAD (notice the space!)
> >>
> >> If you were too used to git merge, you would have wrote
> >> HEAD before ref1, so that does not sound plausible ;-).
> >
> > no, that I have remembered. What I constantly forget is the
> > space-vs-colon difference.
>
> That statement sounds as if "git pull . ref1:HEAD" makes some
> sense and you typed it without colon by mistake.  But it does

exactly.

> not make any sense to me; I am puzzled ... what are you trying
> to achieve with "git pull . ref1:HEAD"?

merge branch ref1 into current. Is that not a correct refspec?
