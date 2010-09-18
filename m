From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 2/2] mergetool-lib: add a three-way diff view for vim/gvim
Date: Sat, 18 Sep 2010 00:34:30 -0700
Message-ID: <20100918073428.GA9850@gmail.com>
References: <1284517303-17244-1-git-send-email-dpmcgee@gmail.com>
 <1284517303-17244-2-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>,
	Charles Bailey <charles@hashpling.org>
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 18 09:33:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Owrvd-0006HF-3G
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 09:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754772Ab0IRHdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 03:33:37 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:49087 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105Ab0IRHdg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 03:33:36 -0400
Received: by pxi10 with SMTP id 10so768475pxi.19
        for <git@vger.kernel.org>; Sat, 18 Sep 2010 00:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=WpWg5MGGU2dOEWlRUdlpPPu7uS6nFQOKqQphQnvKD5U=;
        b=wRuQHrf/tbKalz8i2xrwHnAtp3C5YLD6wAoG9FmsbtSGYFD5j+ehLPtviRvuuSxzjo
         R4i7vr/aJPwgMU76JjicBDcoulm/z/JnBsWl3PVGYalgvjmzDeWWY2dUKnMAb8kKVZOR
         29Jyg4ZX9GQvN1XymG56rk/OnWmdO942hz3ks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ue/b6Ai96VbD7jo0DhHlIoNUSAwPFoB20PnU1bkHN7ntljelgnJGb68V7JH9KA6C5J
         pXP1Gz/GLIOIwMhW9+Li3zeu0tu4CoDeqzoVpbirMjHzryBI7olVbhx42hXvsGqS+mMi
         N3TE6R2ATI+x2CXk2D4sX8FvKxDLCPjdsHl1A=
Received: by 10.142.12.16 with SMTP id 16mr5193522wfl.41.1284795216319;
        Sat, 18 Sep 2010 00:33:36 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id o16sm227861wfh.7.2010.09.18.00.33.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Sep 2010 00:33:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1284517303-17244-2-git-send-email-dpmcgee@gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156434>

On Tue, Sep 14, 2010 at 09:21:43PM -0500, Dan McGee wrote:
> When the base version is available, use a three-way, four panel view by
> default. This shows the (local, base, remote) revisions up top and the
> merged result by itself in the lower pane. All revisions will still scroll
> together by default, and the cursor still defaults to the merged result edit
> pane.
> 
> Signed-off-by: Dan McGee <dpmcgee@gmail.com>
> ---
> 
> Vim was one of the few diff commands to not support a three-way merge showing
> the base revision, so this is a stab at resolving that shortfall. The biggest
> objection I can see to this is making the interface a bit more cumbersome and
> bloated.
> 
> An example screenshot of what this produces:
> http://www.toofishes.net/media/extra/vim_three_way.png
> 
> -Dan


Patch 1/2 of this series looks good to me.

Is it worth keeping the old behavior and calling this new
mode "vimdiff3" or something along those lines?

I'm not a vimdiff user so I'm not be the best person to
judge the merits of this change.  I like what it's trying
to accomplish, though.  Are there any vimdiff users
with strong feelings either way?

-- 

		David
