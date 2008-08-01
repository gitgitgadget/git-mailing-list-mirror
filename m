From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Monotone workflow compared to Git workflow ( was RE: Git vs
	Monotone)
Date: Thu, 31 Jul 2008 22:50:24 -0400
Message-ID: <20080801025024.GA18529@anvil.corenet.prv>
References: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com> <alpine.LFD.1.10.0807311211260.3277@nehalem.linux-foundation.org> <63BEA5E623E09F4D92233FB12A9F79430238A5EE@emailmn.mqsoftware.com> <alpine.LFD.1.10.0807311253140.3277@nehalem.linux-foundation.org> <alpine.LFD.1.10.0807311426090.3277@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Craig L. Ching" <cching@mqsoftware.com>, sverre@rabbelier.nl,
	Git Mailinglist <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 04:51:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOkjq-0000NX-KG
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 04:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025AbYHACu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 22:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752888AbYHACu3
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 22:50:29 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:32055 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190AbYHACu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 22:50:28 -0400
Received: by an-out-0708.google.com with SMTP id d40so136927and.103
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 19:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Syp/Hl6NRmJc2hklr3IusAfDa/u7lvU5SRVLakTQieM=;
        b=GkML1qyKhornKpLNa9QSKI9zyL/sIhpsG+UZ+xm5ty/aByhF389NT3Tf7aYCsCWqeq
         OvrUAOakyzJ4HaaR/aapisRFoHJi5J27gAFDRG8wZU0TkCudUoCLPVZMtlBGypHKmCq0
         WF2C4fZJtF6o/HVIGhPgviKfS+bUX8khBfEEo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IF7X1zQByhKWL//L6ABGE7zQjHXjuz/ohh9x1X9Bk5r0rMVROqZhJHaBJ6YhDYKmUe
         fKECskMhgZSpaps/Od6Yoe9YR6jCaIR9qKOXGUomaptoU3xwTvakvD47mnJaT3eoVkMr
         bJRHMhX9ZiAUa6LqGFUUerR2rtTaP/k3acD3k=
Received: by 10.100.209.5 with SMTP id h5mr15910545ang.18.1217559027040;
        Thu, 31 Jul 2008 19:50:27 -0700 (PDT)
Received: from mailhub.coreip.homeip.net ( [98.220.164.221])
        by mx.google.com with ESMTPS id b37sm1060054ana.33.2008.07.31.19.50.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 31 Jul 2008 19:50:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0807311426090.3277@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91021>

On Thu, Jul 31, 2008 at 02:40:55PM -0700, Linus Torvalds wrote:
> 
> 
> On Thu, 31 Jul 2008, Linus Torvalds wrote:
> > 
> > Sure, if you want to keep the build tree around, you would probably not 
> > use branches. 
> 
> Side note: it's often faster to recompile, if your project has a good 
> build system.
> 
> For example, for the kernel, I can literally rebuild my whole kernel 
> (which is just what I use on _that_ machine) in about 16 seconds. This is 
> _not_ using ccache or anything else - it's rebuilding the whole tree with 
> -j16.
> 

Is it after make mrproper (wow)? Or is it when your branches are
"recent"? Because for me (and well, I dont have that beefy boxes as you
do) swithing between "for-linus" and "next" that based off a revision in
vicinity of 2.6.xx-rc1 and "work" which tracks the tip of your tree
takes time to rebuild.

-- 
Dmitry
