From: Franck <vagabon.xyz@gmail.com>
Subject: Re: [QUESTION] about .git/info/grafts file
Date: Thu, 19 Jan 2006 18:33:17 +0100
Message-ID: <cda58cb80601190933o4cedde92x@mail.gmail.com>
References: <cda58cb80601170928r252a6e34y@mail.gmail.com>
	 <cda58cb80601170932o6f955469y@mail.gmail.com>
	 <7v8xtdrqwg.fsf@assigned-by-dhcp.cox.net>
	 <cda58cb80601190251v5251c8bdh@mail.gmail.com>
	 <20060119130940.GC28365@pasky.or.cz>
	 <Pine.LNX.4.64.0601190842270.3240@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 19 18:35:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ezdf0-0003yW-0X
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 18:33:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWASRdT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 12:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWASRdT
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 12:33:19 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:56803 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751275AbWASRdS convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2006 12:33:18 -0500
Received: by zproxy.gmail.com with SMTP id 14so260458nzn
        for <git@vger.kernel.org>; Thu, 19 Jan 2006 09:33:18 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JbX+vZrJnCs30ID2CJmf/mBjEJDO/lemCETSuvNR7UsBYnWtptpx8lzNlhqpKMvQ8BI4kloFDKT1b8HnM8hQqmso+JDOdRyefDSJWrNHEfWC/tlJ/Mh/0hzGmd/FmnXWSrlZbrvdtlOkFO1fFDuJdwuHYhOVTX1tBIeFNXkbnz8=
Received: by 10.37.14.13 with SMTP id r13mr685324nzi;
        Thu, 19 Jan 2006 09:33:17 -0800 (PST)
Received: by 10.36.47.7 with HTTP; Thu, 19 Jan 2006 09:33:17 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601190842270.3240@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14917>

2006/1/19, Linus Torvalds <torvalds@osdl.org>:
>  - a full clone takes a long time. Git _could_ fairly easily have an
>    extension to add a date specifier to clone too:
>
>         git clone --since=1.month.ago <source> <dst>
>
>    and just leave any older stuff (you could always fetch it later), but
>    we've just never done it. Maybe we should. It _should_ be pretty simple
>    to do from a conceptual standpoint.
>

that would be great ! something like:

        git clone --since=v2.6.15 <src> <dst>

would be very useful for me. How would it work ? Does it automatically
set up a graft file for me ?

> but "everyday" operations shouldn't slow down from having a long history.

but it's really a pain to run for example git-repack or git-prune commands.

Thanks
--
               Franck
