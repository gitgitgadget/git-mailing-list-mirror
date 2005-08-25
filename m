From: Tony Luck <tony.luck@gmail.com>
Subject: Re: baffled again
Date: Wed, 24 Aug 2005 22:58:23 -0700
Message-ID: <12c511ca05082422584e6b1bfb@mail.gmail.com>
References: <200508232256.j7NMuR1q027892@agluck-lia64.sc.intel.com>
	 <7vek8jhk7y.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0508241140290.3317@g5.osdl.org>
	 <Pine.LNX.4.58.0508241152240.3317@g5.osdl.org>
	 <7vzmr63deq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, tony.luck@intel.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 07:58:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8Akt-0002hn-MH
	for gcvg-git@gmane.org; Thu, 25 Aug 2005 07:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbVHYF6Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Aug 2005 01:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbVHYF6Z
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Aug 2005 01:58:25 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:43365 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964850AbVHYF6Y convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2005 01:58:24 -0400
Received: by zproxy.gmail.com with SMTP id i11so161055nzh
        for <git@vger.kernel.org>; Wed, 24 Aug 2005 22:58:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e4281vzpXRbqZteELr/58pI6eQOyqSs4mJc3yOugAACo8dMeXdRrem43qWV1KGk2tBKSYU2jFjPQtG+TPVxy3EG7pu9WuzJFqxQ1kyHtW08oGzlozIFRcPLBBQIE44WsH/pV5MJOZXmsMGvwcrDhm+og4uPbyPgDVTuPv/IfpAU=
Received: by 10.36.55.10 with SMTP id d10mr40243nza;
        Wed, 24 Aug 2005 22:58:23 -0700 (PDT)
Received: by 10.36.57.3 with HTTP; Wed, 24 Aug 2005 22:58:23 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmr63deq.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7746>

>  * Even if it does always choose the nicer choice of the two,
>    Tony was lucky (no pun intended).  Rather, we were lucky that
>    Tony was observant.  A careless merger may well have easily
>    missed this mismerge (from the human point of view).

Actually I can't take credit here. This was a case of the "many-eyes" of
open source working at its finest ... someone e-mailed me and told me
that I should have backed out the old patch before applying the new one.
While typing the e-mail to say that I already had in the release branch,
I found the problem that it had been "lost" in the merge into the test branch.

But this is a good reminder that merging is not a precise science, and
there is more than one plausible merge in many situations ... and while
GIT will pick the one that you want far more often than not, there is
the possibility that it will surprise you.  Maybe there should be a note
to this effect in the tutorial.  Git is not magic, nor is it imbued with
DWIM technology.

-Tony
