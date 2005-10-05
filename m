From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix symbolic ref validation
Date: Wed, 05 Oct 2005 09:54:43 -0700
Message-ID: <7vk6grykdo.fsf@assigned-by-dhcp.cox.net>
References: <433B3B10.5050407@zytor.com> <20051005131631.GA9442@diku.dk>
	<Pine.LNX.4.63.0510051556320.14244@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051005155212.GA16391@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 05 18:57:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENCY1-0005fG-I0
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 18:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbVJEQzM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 12:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbVJEQzL
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 12:55:11 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:35572 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1030247AbVJEQzK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2005 12:55:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051005165435.QZYQ29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 5 Oct 2005 12:54:35 -0400
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <20051005155212.GA16391@diku.dk> (Jonas Fonseca's message of
	"Wed, 5 Oct 2005 17:52:12 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9721>

Jonas Fonseca <fonseca@diku.dk> writes:

> Yes, used rsync when I cloned. Seems validate_symref() was buggy. 
>
>> The other errors could also stem from the fact that quite a few places 
>> expect HEAD to be a symlink.
>
> git-reset still error out ...
>
> ---
>
> Use the correct buffer when validating 'ref: refs/...'
>
> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
>
> ---
> diff --git a/refs.c b/refs.c

Thanks.

One request, not just to Jonas.  Please do not use '^---$' to
separate the introductory discussion and the real commit log
message.

Linus style (recently the kernel list had a thread on this as
well) is to have the commit log upfront with signoff, three-dash
line, optional discussion and diffstat, and then diff.

I do not mind seeing discussion upfront personally [*1*], but
the thing is the tool treats everything after the first '^---$' 
something to be fed to patch, and does not treat it as the
commit log message.


[Footnote]

*1* ...but remember, Linus does.
