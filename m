From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: Re: [PATCH][RFC] Add git-archive-tree
Date: Tue, 5 Sep 2006 13:43:16 +0200
Message-ID: <cda58cb80609050443j26f2af21q6f75b2b4042c7b15@mail.gmail.com>
References: <44F977C0.4060901@lsrfire.ath.cx> <44F982BD.1050509@lsrfire.ath.cx>
	 <cda58cb80609021313p5156a14du4895e53387dd24dc@mail.gmail.com>
	 <44FC6EDE.4010300@lsrfire.ath.cx>
	 <7vy7szmm1u.fsf@assigned-by-dhcp.cox.net>
	 <44FCA272.7040907@lsrfire.ath.cx>
	 <7vwt8jl1dv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Rene Scharfe" <rene.scharfe@lsrfire.ath.cx>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 05 13:43:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKZKs-0007Ac-1h
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 13:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWIELnT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 07:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWIELnT
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 07:43:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:11946 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751280AbWIELnR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Sep 2006 07:43:17 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1908942ugc
        for <git@vger.kernel.org>; Tue, 05 Sep 2006 04:43:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TVQ1mAWLV3+MsifNhjHDhJzvfFk/Q8Oe2kd9vE7wZEsDqMkuNkzOYVCqgHtHBeilyYlwN/KfcgaIBc2qOBAcMiQ1dteYLoT0gHYvcq483lyGQ23+fU2xamEN4tyHfp9WncrPUx4G5i08EfkfOQlZD/98KPJJhuQe3A8L8/Uybfs=
Received: by 10.67.101.8 with SMTP id d8mr3553731ugm;
        Tue, 05 Sep 2006 04:43:16 -0700 (PDT)
Received: by 10.67.95.4 with HTTP; Tue, 5 Sep 2006 04:43:16 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vwt8jl1dv.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26471>

2006/9/5, Junio C Hamano <junkio@cox.net>:
> Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>
> > Junio C Hamano schrieb:
> >...
> > Well, this is just _one_ of the positions I've taken on this topic, I
> > have to admit.  Franck then convinced me that merging downloader and
> > archiver into one command is nice for users (less commands to remember,
> > keeps existing --remote option) even if it doesn't make sense
> > technically, because their implementations have nothing in common.
>
> Ah, I was not following the thread closely and I agree with you
> and Franck now in that smaller number of commands the better.
> (IOW, download-archive in my 3-item list is not needed in the
> end user UI and can be implemented as "git-archive-tree
> --remote=<repo>).
>

OK, I'm sending what I've been able to do so far. It has been done
before you sent some feedbacks one day ago, so please forgive me if,
for the moment, I called "git-archive" instead of "git-archive-tree"
or if I missed some of your points; I'll change that.

I'm sending 2 patches, which are sent to get some comments. They're
not for inclusion in anyways.

The pathspec area has been pick up from Rene's initial patch. I have
not enough git's internal knowledge to improve it. But I'll be glad to
look at this later (if you have any clues for starting point BTW).

-- 
               Franck
