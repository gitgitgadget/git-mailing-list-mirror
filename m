From: Junio C Hamano <junkio@cox.net>
Subject: Re: type_size_sort
Date: Tue, 06 Dec 2005 13:46:50 -0800
Message-ID: <7vlkyx2911.fsf@assigned-by-dhcp.cox.net>
References: <118833cc0512061319l3726fdfbs8286e7b3f5ab0713@mail.gmail.com>
	<439604DF.5010603@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 22:50:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjkeG-0006fw-36
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 22:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbVLFVqx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 16:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932644AbVLFVqx
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 16:46:53 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:46722 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932643AbVLFVqw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2005 16:46:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051206214606.OYPZ6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Dec 2005 16:46:06 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <439604DF.5010603@op5.se> (Andreas Ericsson's message of "Tue, 06
	Dec 2005 22:38:39 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13296>

Andreas Ericsson <ae@op5.se> writes:


> It's perfectly correct. If the same list was to be passed to 
> create_sorted_list() twice it will come out exactly the same the second 
> time as it did the first. The only thing to remark on is that the return 
> above could be written as below instead:
>
> 	return a - b;

And I suspect Morten would say the same thing about ptrdiff_t
could be larger than an int.

I personally feel this would not make any practical difference
on sane architectures either way, though..
