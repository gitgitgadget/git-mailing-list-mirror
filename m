From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/5] Rework diff options
Date: Fri, 23 Jun 2006 19:51:09 -0700
Message-ID: <7vac835krm.fsf@assigned-by-dhcp.cox.net>
References: <20060624011538.9bb179e7.tihirvon@gmail.com>
	<Pine.LNX.4.63.0606240024460.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vodwj8n9s.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0606240201580.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Timo Hirvonen <tihirvon@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 04:51:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtyEt-0008Vn-8Q
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 04:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933207AbWFXCvM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 22:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933206AbWFXCvM
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 22:51:12 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:1998 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S933207AbWFXCvL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 22:51:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060624025110.KTPD8537.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Jun 2006 22:51:10 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606240201580.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 24 Jun 2006 02:04:44 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22481>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 23 Jun 2006, Junio C Hamano wrote:
>
>> I personally feel that the benefit of being able to make sure you 
>> covered everything outweighs the size of initial diff.
>
> IMHO the difficulty of finding bugs is proportional to the square of the 
> diff size, while the number of people willing to review it is proportional 
> to its square root. So, if it is not difficult (which it is not at all in 
> this case), I politely ask to cut the patch size down.

Yeah, your "renaming in private while you are making sure but
rename them back" suggestion actually would work in this case.
