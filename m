From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: Re: git commit broken ?
Date: Mon, 10 Apr 2006 10:24:01 +0200
Message-ID: <cda58cb80604100124k165307c3td84be984e607c6ae@mail.gmail.com>
References: <cda58cb80604100102p92e5258qf33a128f75f1b088@mail.gmail.com>
	 <7vhd51alti.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 10 10:24:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSrh6-00073k-6Z
	for gcvg-git@gmane.org; Mon, 10 Apr 2006 10:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWDJIYR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Apr 2006 04:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWDJIYR
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Apr 2006 04:24:17 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:47964 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751085AbWDJIYR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Apr 2006 04:24:17 -0400
Received: by zproxy.gmail.com with SMTP id o37so799661nzf
        for <git@vger.kernel.org>; Mon, 10 Apr 2006 01:24:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hPoa8+rAuO3khRHfus8by6TX4AiDJ7T3Tu7l6vwJg5vrWhKg0Ee4fVA35cXpOlDdNimJBPRl1RKfKZfQjXGaNBj+a/mZbAzsHy2n9mYhU36PR0nz/zyrG7ryTT9021zJZzLXF0Kan3Yb+jNNxF3xgPORgdV86GEX+cC8IzDWVTs=
Received: by 10.36.31.17 with SMTP id e17mr3371426nze;
        Mon, 10 Apr 2006 01:24:16 -0700 (PDT)
Received: by 10.36.50.4 with HTTP; Mon, 10 Apr 2006 01:24:01 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vhd51alti.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18587>

2006/4/10, Junio C Hamano <junkio@cox.net>:
> "Franck Bui-Huu" <vagabon.xyz@gmail.com> writes:
>
> > It seems that "git commit -a -c ORIG_HEAD" command do not work as
> > expected.
> >
> >       $ git commit -a -c ORIG_HEAD
> >       $ git status
> >       nothing to commit
> >
> > So it seems that c has been commmited this time...Is it the expected
> > behaviour ?
>
> You said "git commit -a" to tell it to commit all your changes
> in your working tree, using "-c ORIG_HEAD" which means "take the
> commit log message and authorship information from that commit".
>
> So I do not understand what else, other than both a and c
> getting committed (hence subsequent "git status" to report
> "nothing to commit'), you are expecting...

oops, I forgot that switch, sorry for the noise.

Thanks
--
               Franck
