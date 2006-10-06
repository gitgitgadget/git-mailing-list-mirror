From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: perhaps time to remove git_blame from gitweb, and git-annotate?
Date: Fri, 6 Oct 2006 10:52:34 -0700 (PDT)
Message-ID: <20061006175234.41182.qmail@web31810.mail.mud.yahoo.com>
References: <Pine.LNX.4.63.0610061505360.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Luben Tuikov <ltuikov@yahoo.com>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>,
	Ryan Anderson <ryan@michonline.com>,
	Martin Langhoff <martin@catalyst.net.nz>,
	Martyn Smith <martyn@catalyst.net.nz>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Oct 06 19:52:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVtsG-00045D-DI
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 19:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422779AbWJFRwg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 13:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWJFRwg
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 13:52:36 -0400
Received: from web31810.mail.mud.yahoo.com ([68.142.207.73]:50835 "HELO
	web31810.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751471AbWJFRwf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 13:52:35 -0400
Received: (qmail 41184 invoked by uid 60001); 6 Oct 2006 17:52:34 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=wDpKY5VKpVgtQzT4wacS8BHuLWFoze/NU/EubZ4eO4PlLRzSH1Qe5GrC4G69ftg565w5Q8WWshUTbSI0UhZ5aGAZfql8YJwxCZ6IhkRr9pUHOYwvHrfVF3t2lhWthq9tfMkcS0UPabSSNXHRfy4ELte3HRKNQZDY/fuMcgXn9BU=  ;
Received: from [64.215.88.90] by web31810.mail.mud.yahoo.com via HTTP; Fri, 06 Oct 2006 10:52:34 PDT
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.63.0610061505360.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28422>

--- Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> On Thu, 5 Oct 2006, Junio C Hamano wrote:
> 
> > Do people have reason to favor annotate over blame?  To keep
> > existing people's scripts working I think we should add a small
> > amount of code to blame.c to default to compatibility mode when
> > the command is called as git-annotate at least for a while, but
> > other than that I do not see much issue against scheduling for
> > annotate's removal.
> 
> +1. Although I would leave git-annotate in git, if only to meet 
> expectations of new git users.

I agree with Junio's assessment of the situation.

   Luben
