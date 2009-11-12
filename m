From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: Locally manage user/branch setting files without pushing them
	remotely
Date: Thu, 12 Nov 2009 10:31:46 +0100
Message-ID: <20091112093146.GB25398@vidovic>
References: <9accb4400911110401g5c44d011u50cafcfe736a2ec6@mail.gmail.com> <20091111192449.GH27518@vidovic> <9accb4400911120118t3257a1n6f2a05abb1008c8@mail.gmail.com> <20091112092909.GA25398@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniele Segato <daniele.bilug@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Thu Nov 12 10:32:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8W2U-0008F2-Gs
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 10:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbZKLJbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 04:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751911AbZKLJbo
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 04:31:44 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:48821 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbZKLJbo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 04:31:44 -0500
Received: by mail-fx0-f221.google.com with SMTP id 21so1985613fxm.21
        for <git@vger.kernel.org>; Thu, 12 Nov 2009 01:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=9iz3ws9+rYcrm5NAJ9zAQkTHsTPBf7KAavjFozW4Q+Q=;
        b=craycLAeskFfvK5nFUceax1aSRVi0SzH6WdVdmaOT1qrcV/PCq5JMy9kxLegraQjhq
         5dSYodubPxmckX9rKTLRwYvMxmICKCuD3cfnMd57Sh9tsJTL5bEk5lUq78DGUo4FiPMA
         4ukvfYrCQBHS07N2QRgkmrSczN6tyt6rE12ak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UVIQgeAfK+qijAOhw3GfDdBdnpASogQ2gNLO8gTUK1r+ADaOZfY5ug4eiZw9DnJmtZ
         3S/chQP/7uMrMFysnOCv3HzWDYf2PVCYS0hKHgColwlXXBSQ9SC42hkuNeyJ+rFQWWdw
         IcIURb7Z2BQfqePv00g16msd3kQ9wB/jN+J/A=
Received: by 10.204.20.82 with SMTP id e18mr2833457bkb.168.1258018309370;
        Thu, 12 Nov 2009 01:31:49 -0800 (PST)
Received: from @ (91-165-129-166.rev.libertysurf.net [91.165.129.166])
        by mx.google.com with ESMTPS id 14sm789093bwz.13.2009.11.12.01.31.48
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 12 Nov 2009 01:31:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <9accb4400911120129h54609846jac9eb3b6cb07b792@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132752>

The 12/11/09, Daniele Segato wrote:
> On Wed, Nov 11, 2009 at 8:24 PM, Nicolas Sebrecht <nicolas.s.dev@gmx.fr> wrote:
> > The 11/11/09, Daniele Segato wrote:
> >
> > If you want to track changes of settings in a per-production-repo basis,
> > you should do it _out_ of your main development repository. The latter
> > should have a publishable template instead (eg. "user = user_login",
> > "password = set_your_password").
> 
> you are probably right but even if I place this files outside my
> repository I still have to modify them manually..

I don't understand. You'll still have to manually these files regardless
_how_ they are tracked.

> it's the same of having them into the repo but in .gitignore

When I say, "out of the main development repository", I don't think "out
of the directory of the repository" but "out of the tracking git system".

I think you should look at 'git subtree' or 'git submodule' to track the
setting files out of the _main_ repository and _inside_ the main
development directory.

> we are customizing a third party product and I can't change the way it
> is build up.
> 
> I don't think that this situation is so uncommon anyway.

Yeah, it doesn't help to be unable to do everything we want! But I'm
pretty sure git can do something very convenient in your case.

-- 
Nicolas Sebrecht
