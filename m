From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: Re: [PATCH 0/3] git-daemon: plug new upload-tar command
Date: Sat, 2 Sep 2006 22:12:53 +0200
Message-ID: <cda58cb80609021312y79456479w649dc078a68ff23c@mail.gmail.com>
References: <11570277231100-git-send-email-vagabon.xyz@gmail.com>
	 <44F72039.3040206@lsrfire.ath.cx>
	 <cda58cb80609020114h1e1ee553saf5aa90df8bc3ba0@mail.gmail.com>
	 <7vfyfa1rvf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Rene Scharfe" <rene.scharfe@lsrfire.ath.cx>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 02 22:13:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJbrf-0000lY-SS
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 22:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbWIBUM4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 16:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbWIBUM4
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 16:12:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:609 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751503AbWIBUMz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 16:12:55 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1221967ugc
        for <git@vger.kernel.org>; Sat, 02 Sep 2006 13:12:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cJjC8p0p1q/oIZ+KaUxs56N+HvIcXtCVpmtM3y5rgRsq9SR1QBa+EiaPk619K/4bh/N1Qol1WrCiTI9cu+AN2sEp96FxvguBWu3/W8sCSfu46hL9+HvdW+h/FnfL9ScQvIlbkTFFobOH7801CVR3bFE56Oqd7gfph4GLIHdfQrc=
Received: by 10.67.101.8 with SMTP id d8mr1921851ugm;
        Sat, 02 Sep 2006 13:12:53 -0700 (PDT)
Received: by 10.67.95.4 with HTTP; Sat, 2 Sep 2006 13:12:53 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vfyfa1rvf.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26353>

2006/9/2, Junio C Hamano <junkio@cox.net>:
> "Franck Bui-Huu" <vagabon.xyz@gmail.com> writes:
>
> >> So if you beat me to it, that would be great.  Or if you have a better
> >> idea, that would be also great. :-)
> >
> > Well I'll try to start something, not sure to have a lot of time
> > though. Please contact me before starting anything, I would be sad to
> > write something for /dev/null again ;)
>
> I do not necessarily think your effort were for /dev/null; for
> example, I was hoping you defend [PATCH 3/3].
>

Well, with a new git-archive-tree command, I thought it would make
sense to put the remote logic there and let the git-tar-tree be a
local command. But Rene has a different approach, please see his new
thread "Add git-archive-tree".

> While it makes sense to make "tar-tree --remote" usable outside
> a git managed repository, I think people expect the connection
> to obey core.gitproxy if the command is run inside a repository
> that has a configuration file.
>

Make sense.

-- 
               Franck

-- 
VGER BF report: U 0.799618
