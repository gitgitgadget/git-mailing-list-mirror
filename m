From: Peter Baumann <peter.baumann@gmail.com>
Subject: Re: Am I doing something wrong?
Date: Wed, 21 Dec 2005 19:37:49 +0100
Message-ID: <802d21790512211037q4ffc5816u@mail.gmail.com>
References: <86k6dyxuke.fsf@blue.stonehenge.com>
	 <7v3bkmcp83.fsf@assigned-by-dhcp.cox.net>
	 <864q52xrm6.fsf@blue.stonehenge.com>
	 <7vmziub9yw.fsf@assigned-by-dhcp.cox.net>
	 <86zmmuwbzh.fsf@blue.stonehenge.com>
	 <7vhd92b90w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 19:42:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ep8r5-00005F-OU
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 19:38:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbVLUShx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 13:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbVLUShx
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 13:37:53 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:17049 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751156AbVLUShw convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 13:37:52 -0500
Received: by zproxy.gmail.com with SMTP id 14so238511nzn
        for <git@vger.kernel.org>; Wed, 21 Dec 2005 10:37:51 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hctiQWU5CifC4tbwp2+CVCRqkc4utkqfJIbgHo4LrkAkXnmr5Ub+J8l8RrQld965YVKvnJ4oft5SXmOYZMp2FasD2isqXu0qj5/lvJ6KFMRHUIq3BZDbz/BKXC9xSKHPoiPXwCiLrgz6koOH0459VpKWkQPpR9dUWh4HyGl2LJo=
Received: by 10.64.203.4 with SMTP id a4mr635747qbg;
        Wed, 21 Dec 2005 10:37:49 -0800 (PST)
Received: by 10.64.21.6 with HTTP; Wed, 21 Dec 2005 10:37:49 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhd92b90w.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13890>

2005/12/21, Junio C Hamano <junkio@cox.net>:
> merlyn@stonehenge.com (Randal L. Schwartz) writes:
>
> >>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:
> >
> > Junio> I said I tried cloning from scratch and fetching into an old one
> > Junio> over HTTP and succeeded, did I not?  So it does not seem to be
> > Junio> the case either.
> >
> > Cloning from scratch probably worked differently than starting
> > from wherever I was.
>
> Yup, that's why I tried both.
>
> > ... However, I'm very clear on the symptoms... trying to start
> > from wherever I had last updated, to update to the current release,
> > failed when sucking from HTTP, but worked when sucking from GIT.
>
> I do not doubt you got a failure.  I just couldn't reproduce it
> easily by fetching into a copy of a stale repository.  Earlier I
> was suspecting mirroring lags (my successful trial was done
> within the last hour) but I do not think that is the case
> because your failure was also way after the mirroring should
> have happened.
>
> Will dig a bit more when able.
>

Sorry , but I have seen this too. I deleted my git directory and
cloned it again and it worked, but the original pull didn't work.
(Same error as above.) I'll look if I can find a backup of my old git
directory and look if there is the same error for you to reproduce. If
I can find something, I'll get back to you.

Peter Baumann
