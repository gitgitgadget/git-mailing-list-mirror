From: Motiejus =?utf-8?Q?Jak=C5=A1tys?= <desired.mta@gmail.com>
Subject: Re: What Features Do I loose With git-svn?
Date: Fri, 29 Apr 2011 18:16:29 +0100
Message-ID: <20110429171629.GA3394@jakstys.lt>
References: <1304096029355-6317576.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: ryanzec <basire@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 19:16:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFrJ2-0003cQ-L5
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 19:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759849Ab1D2RQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 13:16:34 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54476 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756810Ab1D2RQd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 13:16:33 -0400
Received: by wya21 with SMTP id 21so2989099wya.19
        for <git@vger.kernel.org>; Fri, 29 Apr 2011 10:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=8nNvwlLFjbTGTiv4G/zYyuIIYGRkAHzPUYobOFnOdeY=;
        b=xZ6fCo81VFimWedfWNhcFVhp3I7Ns4k1rrSg7fZnlUMP8JU9q3kaqGgtXsQV44jc48
         tuUa/RpuOGG34OduoC9ZdWazh114blikazQU6fIwru57uh9MMgwB2dL7lVhpJEk+5VFm
         wdTsYei7Xc+mSFodjSADjr/pARkCO90AkyfiY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=H/7QMDGDPMdfNp26r7MxAc4GgnfVqjXgZWSqS+ft4RhhN0cV5c2Z/Tpw435GttTNAt
         ShJR5BQt6lZleRpY3rkP1NQND0UUUDzv4UH1RKNx37N6GWA29sX8ziX21bKQsDLXr7cU
         QIK/ma+fZKa3cClv5LTJlFYymPzscfupzxgL8=
Received: by 10.216.142.165 with SMTP id i37mr5223481wej.106.1304097392764;
        Fri, 29 Apr 2011 10:16:32 -0700 (PDT)
Received: from localhost ([109.246.247.245])
        by mx.google.com with ESMTPS id n52sm1464850wer.24.2011.04.29.10.16.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Apr 2011 10:16:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1304096029355-6317576.post@n2.nabble.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172475>

On Fri, Apr 29, 2011 at 09:53:49AM -0700, ryanzec wrote:
> I want to use git for a project I am working on however because the project
> is going to possibility have a lot of binary content in size and number of
> files (game project), it is probably going to be hard to convince my team to
> make the switch since I have no real solution besides just use git for the
> code and svn for the binary data.  I am hoping git-svn will do the trick for
> me.  The question is are they any features I loose (like cherry picking) or
> anything that I have to look out for (does updating from svn cause merging
> issues just like working all in SVN does).  Right now the only things I know
> to look out for is:
> 
> <ul>
> <li>Instead of git pull/push I have to use the git-svn equivalents</li>
> <li>If I have changes that are not in the index and I need to pull the
> latest code form SVN, I have to stash first, update from svn, and then apply
> the stash back.</li>
> </ul>
This list does not support HTML. Thankfully. :)

> 
> Any other things I have to look out for?  I am mainly concerned that using
> git-svn will re-introduce the merge issues of SVN the git is great at doing.--
I never tried merging of "SVN" branches. What I used to do is check-out
my local branch from tip of master (svn upstream), work on it. Before
"merging" changes upstream I rebased on top of upstream again, got a
fast-forward, and pushed to SVN.

If you used git-svn, why would you "merge"? As it does not support
"reverting" (at least I'm unaware of it), it's quite unnecessary IMHO
(put your merge commits upstream).

Motiejus
