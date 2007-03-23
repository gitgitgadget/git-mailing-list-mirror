From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: emacs and git...
Date: Fri, 23 Mar 2007 10:54:51 +0100
Message-ID: <38b2ab8a0703230254x585ff89fp3e425b08cac56900@mail.gmail.com>
References: <38b2ab8a0703220753s67809e87l76ffc57adb725898@mail.gmail.com>
	 <86lkhpmftt.fsf@blue.stonehenge.com>
	 <38b2ab8a0703230029h7f3faa95u1e2ccb6a9ee4be5e@mail.gmail.com>
	 <864poch0xl.fsf@blue.stonehenge.com>
	 <38b2ab8a0703230132j64cf0b94x7c210593f3f31387@mail.gmail.com>
	 <7vtzwcqqf9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 23 10:55:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUgUC-0005sw-6w
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 10:55:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422762AbXCWJyy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 05:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422757AbXCWJyy
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 05:54:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:63651 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422762AbXCWJyx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 05:54:53 -0400
Received: by ug-out-1314.google.com with SMTP id 44so972354uga
        for <git@vger.kernel.org>; Fri, 23 Mar 2007 02:54:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C8hgBaRM9gDP9PQazrspYOPQzg5Yx/PMEYSEZ2UX6di8MpZuAy8SfD97eWDVsS8iQ0IMa23SSQSeGkU6RrGDDD0byCEJ6YxSf20/HEWZekKMObFbmxhRV4C+6daviNE1qmuj5CkIj+Mc2pUICQyZ03woAt0L/Ijnta540xyX9Jg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=csBqQZb9EvqvI6VGdlwy6kBr6RJfSz/LKQO499pt7qQQFmQqph8aCu+KM96nHaur3qVSLR5ElEuqzCxIZpeJkaNhuIvuBXt8Cg50H1rqktfRv9+AoYNsRI7pH1vk5DMtou5eKEIVzoPX5v9CSwaWvQsWS+CACGVG0YYT/JsDZ5E=
Received: by 10.115.76.1 with SMTP id d1mr1108195wal.1174643691115;
        Fri, 23 Mar 2007 02:54:51 -0700 (PDT)
Received: by 10.114.38.12 with HTTP; Fri, 23 Mar 2007 02:54:51 -0700 (PDT)
In-Reply-To: <7vtzwcqqf9.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42921>

On 3/23/07, Junio C Hamano <junkio@cox.net> wrote:
> "Francis Moreau" <francis.moro@gmail.com> writes:
>
> > Can't git make 'cat' the default pager when run on a dumb terminal ?
>
> IIRC, `more` works on a dumb terminal.
>

yes it does although the behaviour is a bit weird. Not all screen is used.

> But using PAGER=cat is a longstanding and widely used trick
> among Emacs old timers, predating the EDITOR=emacsclient, which
> is even nicer.  I would highly recommend it.  These two
> environment variables make running *everything* in compilation
> mode (or shell buffer) so much nicer than otherwise.
>

I think I'm going to give a try PAGER=more and EDITOR=emacsclient
config with shell buffer and see if it can fit well my git usage.

I tried to use term mode but it's pretty annoying to switch between
'line' and 'char' mode all the time.

BTW Junio, just out of curiosity, do you use shell or term mode ?
-- 
Francis
