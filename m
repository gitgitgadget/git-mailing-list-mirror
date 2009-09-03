From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2] status: list unmerged files last
Date: Wed, 2 Sep 2009 18:12:36 -0700
Message-ID: <20090903011234.GA7415@gmail.com>
References: <200909012213.54611.j6t@kdbg.org> <7vy6oy9z9r.fsf@alter.siamese.dyndns.org> <200909012325.45739.j6t@kdbg.org> <7vtyzmxkpr.fsf@alter.siamese.dyndns.org> <20090902011513.GA3874@coredump.intra.peff.net> <7vmy5egefh.fsf@alter.siamese.dyndns.org> <20090902051248.GB12046@coredump.intra.peff.net> <7vljkxdiil.fsf@alter.siamese.dyndns.org> <20090902100730.GA18226@gmail.com> <20090902175908.GA5998@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 03 03:12:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mj0sZ-0004fz-HK
	for gcvg-git-2@lo.gmane.org; Thu, 03 Sep 2009 03:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753969AbZICBMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 21:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753954AbZICBMi
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 21:12:38 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:51043 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753928AbZICBMh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 21:12:37 -0400
Received: by bwz19 with SMTP id 19so1146641bwz.37
        for <git@vger.kernel.org>; Wed, 02 Sep 2009 18:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=B+0Ua4HxA1PNdGnyz1XXo8tO1RiFM5QgqGMkZLmLUCU=;
        b=J+Oq9ARiESZoapfykDTAirhN+vZrou0rQ2AqT6F0eJH21W2Fff+P9/lvz8GxiPGpBx
         XMlQVlMqNSDPA5HcrX4nHzGsYuPZ5NBx/D7R9pmnpiENHlAY97s8fNtBEm34YomfwZf7
         R1dgO2BVBaGPGaG5ariKAtSC673TsgNmjrjnE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Gmu0gGe6gQ6i6AzX25qirbH/pSklBnjTFs9ni621T/nHUGcL732Wv0NeP+Sz67OCd6
         l0AEBnHIUFPWuTrkSKKYvU2HWqG4iCii9QLvRafMFrveHwWjZFd7s/TBag5hKabyrDpz
         ZioNhMa1Heves5ZnFS3XbX3kKVMmVJ8pwyZlI=
Received: by 10.204.8.140 with SMTP id h12mr7268836bkh.204.1251940357611;
        Wed, 02 Sep 2009 18:12:37 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id c28sm959877fka.49.2009.09.02.18.12.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Sep 2009 18:12:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090902175908.GA5998@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127635>

On Wed, Sep 02, 2009 at 01:59:08PM -0400, Jeff King wrote:
> On Wed, Sep 02, 2009 at 03:07:32AM -0700, David Aguilar wrote:
> 
> > I agree with all of this but would also add that we can have
> > our cake and eat it too with respect to wanting to "keep
> > similar things together" and having "unmerged near bottom".
> 
> Well, my point was that the "bottom" is not really cake, but I am not
> sure anyone else agrees.
> 
> > No one has suggested this, so I figured I would.
> > What do you think about this layout?
> > 
> > - untracked
> > - staged
> > - modified
> > - unmerged
> 
> What about the current branch? Alternate author info? Tracking branch
> relationship? Should those be at the top or bottom?
> 
> I dunno. Maybe it is just me being crotchety and hating change, but I
> like the current order (though swapping it below "updated" is fine with
> me).


Nah, you're right.
Being crotchety and hating change is a good thing here.



> If you want to know "what does commit --amend do", then shouldn't you be
> using "git commit --amend --dry-run" (which is what "git status" is now,
> but will not be in v1.7.0)?
> 
> Are there other uses cases for arbitrary tree-ish's?
> 
> > BTW is status -s intended to be something plumbing-like;
> > something we can build upon and expect to be stable?
> > I'm just curious because other commands have a --porcelain
> > option and I wasn't sure if this was the intent.
> 
> We mentioned a --porcelain option in other discussion, but I don't think
> there is a patch. I would be in favor of --porcelain, even if it is
> currently identical to --short, because then it gives us freedom to
> diverge later (and in particular it gives us the freedom to let user
> configuration affect what is shown).
> 
> -Peff

The only use case would be for --amend.
Which is why I asked about --porcelain; really what I want is
something like

	git status --porcelain HEAD^

Rolling a patch to make --porcelain an alias for --short seems
like a good idea.  If we want to support HEAD^ and HEAD^ only
then perhaps an --amend flag is useful.

The real crux of my question was about being able to script
it, which is why commit --dry-run is not enough.

-- 

	David
