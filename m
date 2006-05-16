From: Santi <sbejar@gmail.com>
Subject: Re: Merge with local conflicts in new files
Date: Wed, 17 May 2006 01:11:29 +0200
Message-ID: <8aa486160605161611p4c9ddbc0v@mail.gmail.com>
References: <8aa486160605161500m1dd8428cj@mail.gmail.com>
	 <7v1wut61aj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 01:11:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fg8hU-00009f-Mb
	for gcvg-git@gmane.org; Wed, 17 May 2006 01:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWEPXLb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 19:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWEPXLb
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 19:11:31 -0400
Received: from wx-out-0102.google.com ([66.249.82.207]:64596 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932239AbWEPXLa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 May 2006 19:11:30 -0400
Received: by wx-out-0102.google.com with SMTP id s6so66754wxc
        for <git@vger.kernel.org>; Tue, 16 May 2006 16:11:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nUr/ZysmKQUZt5m9lVC2F2775dPzDuHW0+Wk4dTuRH4GJzW+aUZJU2+Nr18kPlWD3hRSAkXmPIpUg8igxAAbQbiNBq+QG/YRxVbGtFkY9wMIL7CMw/mxr1fzGbgCKW9+jNi26SsOzLBihPeE3veYhWkzuaDU18LOtaC/hPg2B+Q=
Received: by 10.70.133.4 with SMTP id g4mr335002wxd;
        Tue, 16 May 2006 16:11:29 -0700 (PDT)
Received: by 10.70.20.2 with HTTP; Tue, 16 May 2006 16:11:29 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v1wut61aj.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20147>

2006/5/17, Junio C Hamano <junkio@cox.net>:
> Santi <sbejar@gmail.com> writes:
>
> >       In the case of:
> >
> > - You merge from a branch with new files
> > - You have these files in the working directory
> > - You do not have these files in the HEAD.
>
> and
>
>  - You have not told git that these files matter.

For me it is the other way, all my files matter but git can do
whatever it wants with the ones it controls.

>
> This is totally untested, but on top of "next" you could do
> something like this, perhaps.

Thanks, it works here.

Santi
