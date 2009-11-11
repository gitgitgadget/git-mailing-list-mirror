From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: Working on merged branches whilst seeing current master
Date: Wed, 11 Nov 2009 22:57:27 +0100
Message-ID: <20091111215727.GK27518@vidovic>
References: <1257959806206-3987667.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: rhlee <richard@webdezign.co.uk>
X-From: git-owner@vger.kernel.org Wed Nov 11 22:57:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8LCH-0004Yl-5G
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 22:57:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759108AbZKKV53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 16:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759291AbZKKV52
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 16:57:28 -0500
Received: from gv-out-0910.google.com ([216.239.58.191]:2509 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758868AbZKKV52 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 16:57:28 -0500
Received: by gv-out-0910.google.com with SMTP id r4so215543gve.37
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 13:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=6jPXFwSUwzi2Iv0qLkasmIrv8rAe8iCTQIXOKRgBGmA=;
        b=HJ2h9R5mtuc1w07ock0ez34ALbmX5PLdjeMm1KoG8qIdGqUzNZ7MC1TI1mhbD5eN14
         uS6sjCgRel005KP0GB0t2YHbVZMDjkRDky3zRUq5/TpM/ma22LTn38SrzLBp9NM9Op8M
         Jc8FX3/P1MD76LmiaZrvy99fqYL65u7aWQNYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wUmzgHmE0u5VKybzdEiiqLwun0vlAtjkISpb3josgXJoAJHcHCd0bfCiP0+XPlYKIZ
         rQhgeLxdHw09aK6RrG6n4MYq7UGaBzh05JqS4bMnP8YE+TMiobphlmugupDA+VkcFQHW
         pI240Hvm2ilyuRVO48oAmGjVmdFWqQgsYUmx4=
Received: by 10.213.55.70 with SMTP id t6mr7162899ebg.11.1257976650890;
        Wed, 11 Nov 2009 13:57:30 -0800 (PST)
Received: from @ (91-165-129-166.rev.libertysurf.net [91.165.129.166])
        by mx.google.com with ESMTPS id 7sm1495816eyg.41.2009.11.11.13.57.29
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 13:57:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1257959806206-3987667.post@n2.nabble.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132709>

The 11/11/09, rhlee wrote:
> 
> I use branches for features. I have a branch and I merged it into my master
> branch as I thought it was finished. But it turns out I wasn't and so I need
> to work on it again.
> 
> I have made some more changes (branches and merges) on master. So what I
> should do is checkout that branch, work on it committing along the way and
> then merge it again onto my master branch.
> 
> However I though I am working on a feature branch I want to be also working
> from the master branch as reference.

If the feature branch is merged to the mainline, it should really mean
that the feature is ready : the feature branch life stop here. This also
means that if you see that this feature was not as ready as you thought,
you have to restart a _new_ feature branch off of the mainline.

That's why there is the "next" branch in the git releases process. This
way, we can test the feature branches without touching master for some
time.

>                                      Yes I know I probably should not be
> working like this. My branches should be wholly independent. But I doing web
> development not kernel development so there is much less modularity and
> branches/features have a tendency to creep into one another.

This should not be the case. Modularity in the release process and the
development strategy is not tied to "what I am developing". I'm doing
some web development too and have no difficulty around this point.

> Or should I just create a new branch? But if I do this there is no link
> between the old and new branch.

Yes, feature branches have no reason to live after they are merged to
the mainline.

-- 
Nicolas Sebrecht
