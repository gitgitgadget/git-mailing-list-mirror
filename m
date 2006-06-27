From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH 3/2] format-patch: use clear_commit_marks() instead of some adhocery
Date: Tue, 27 Jun 2006 23:09:28 +1200
Message-ID: <46a038f90606270409t6724b105h6c56d55138fd58c5@mail.gmail.com>
References: <Pine.LNX.4.63.0606250349280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.63.0606261728340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <46a038f90606261520k7df8cb3ci7a4a609644e0be12@mail.gmail.com>
	 <Pine.LNX.4.63.0606270038200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <46a038f90606261550p145b20a6gbe960e0abc16e8a4@mail.gmail.com>
	 <Pine.LNX.4.63.0606270057260.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <44A06A8D.7080202@catalyst.net.nz>
	 <Pine.LNX.4.63.0606271016450.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <46a038f90606270252p2beac88bo3cf7aa8d3845450c@mail.gmail.com>
	 <Pine.LNX.4.63.0606271251440.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>,
	git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Jun 27 13:09:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvBRl-0004iA-B9
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 13:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933385AbWF0LJa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 07:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933396AbWF0LJa
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 07:09:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:61792 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S933385AbWF0LJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 07:09:29 -0400
Received: by ug-out-1314.google.com with SMTP id a2so2521340ugf
        for <git@vger.kernel.org>; Tue, 27 Jun 2006 04:09:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aHTZA7Eewj+7QXjtdk/Q8zDWzjLvDRbBPqcrBzmQKW8Bw558AlWTbTDKCSuIvS8OSo+t51FL5PZMDMw4A2ak20mZuMjnS61ztY4FgOIEFLvzgRHsG6NQ1qatfaakd/HteFyXhhIvlso9SqdC93JUQWbrnnisdEJWiGlSD1sJM1I=
Received: by 10.78.139.5 with SMTP id m5mr2453175hud;
        Tue, 27 Jun 2006 04:09:28 -0700 (PDT)
Received: by 10.78.117.11 with HTTP; Tue, 27 Jun 2006 04:09:28 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606271251440.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22731>

On 6/27/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > It does, but it may be "right" even though it's not realising that
> > some of the patches were cherry picked. git-cherry doesn't either. So
> > that algorythm isn't so hot in this case :-/
>
> What do you mean? Is the patch-id of the cherry-picked different? (If
> there was a conflict which was manually resolved, I think there is no way
> we can detect that that patch was cherry-picked, but if it applied
> cleanly, the patch-id should be equal both in upstream and downstream.)

I'll look more into it tomorrow at work. Knowing the codebase, some of
the patches should be rather obvious, GNU patch recognises them as
'already applied', but they may be slightly different in ways that
break the hashing. Maybe. I'll play with git-cherry to see, I assume
that you've copied the logic from there.

cheers,


martin
