From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] Introducing cg-xxdiff for conflict resolution
Date: Sun, 24 Sep 2006 18:02:28 +0100
Message-ID: <46a038f90609241002i1db98ed6n118077089c9e417f@mail.gmail.com>
References: <11546624471356-git-send-email-martin@catalyst.net.nz>
	 <20060924165037.GS20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin@catalyst.net.nz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 19:02:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRXNB-00011C-Ke
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 19:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWIXRCa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 13:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWIXRCa
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 13:02:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:16375 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750762AbWIXRC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Sep 2006 13:02:29 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1348559nfa
        for <git@vger.kernel.org>; Sun, 24 Sep 2006 10:02:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LxFDwH0Oy8MpTbgaqZNd7l4l60IGJBcK6FTL2bgiB0fhs6vRVkCtZWHXWUhagomUmLJuXdgeFKDdJKJjjHBvWzQPX5HVDGoadoTvPAZ1s3MWzU8l8tC7gQi7lOT8fYbWpigJRF9PlLKQnqCJRSATdXacMMHKX+qHN9HbpO2mUaA=
Received: by 10.49.41.18 with SMTP id t18mr485051nfj;
        Sun, 24 Sep 2006 10:02:28 -0700 (PDT)
Received: by 10.49.11.5 with HTTP; Sun, 24 Sep 2006 10:02:28 -0700 (PDT)
To: "Petr Baudis" <pasky@suse.cz>
In-Reply-To: <20060924165037.GS20017@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27677>

On 9/24/06, Petr Baudis <pasky@suse.cz> wrote:
> Hmm, I think this would be generally more useful during the actual merge
> phase - if merge returns error, you fire up
> git-magic-conflict-resolution-driver and have fun.

Well, in many cases the conflict markers are just ok and exactly what
I want. If the two sides of the conflict are clear, the resolution is
usually clear as well. OTOH, it may be a big mess where xxdiff gives
more visual cues as to WTF is going on...

IOW I don't want it to be part of the merge automagically...

> > +. git-sh-setup
>
> Uh-oh. :-)

Is that bad? <blush> I am not doing anything too cogito-specific, and
I just don't know what cg-Xlib will do for me...

> > +git cat-file blob `git rev-parse FETCH_HEAD`:$FILE > $FILE~branch
>
> Cogito does not use FETCH_HEAD.

eeek. you ar right. I mix and match git and cogito as you can see. Not
so smart. I see cg-merge uses merging, merge-base and merging-sym --
I'll rework it using those...

cheers,



martin
