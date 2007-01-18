From: Yann Dirson <ydirson@altern.org>
Subject: Re: Rebasing stgit stacks
Date: Thu, 18 Jan 2007 20:42:23 +0100
Message-ID: <20070118194208.GJ9761@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070109224125.GF17093@nan92-1-81-57-214-146.fbx.proxad.net> <8b65902a0701150526j5a954529xf45b2d0348a77573@mail.gmail.com> <20070115202412.GE9761@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701151446l45eff9dbgcae718c1461d0725@mail.gmail.com> <20070115233958.GF9761@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701161442t6b93e0d6nd88364600f2809ee@mail.gmail.com> <20070116231735.GF7029@nan92-1-81-57-214-146.fbx.proxad.net> <eojn5c$v9u$1@sea.gmane.org> <20070117205301.GH9761@nan92-1-81-57-214-146.fbx.proxad.net> <tnxmz4gv8sj.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 20:43:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7dAM-0002OX-De
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 20:43:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbXARTm6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 14:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbXARTm6
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 14:42:58 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:43252 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932428AbXARTm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 14:42:58 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 400A243A66;
	Thu, 18 Jan 2007 20:42:56 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 895CB1F073; Thu, 18 Jan 2007 20:42:23 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <tnxmz4gv8sj.fsf@arm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37133>

On Thu, Jan 18, 2007 at 12:06:20PM +0000, Catalin Marinas wrote:
> Yann Dirson <ydirson@altern.org> wrote:
> > On Wed, Jan 17, 2007 at 12:30:18AM +0100, Jakub Narebski wrote:
> >> I'm all for calling this command "stg rebase".
> >
> > After all, my current implementation as "pull --to" mostly bypasses
> > the fetch, so it probably makes sense to use a new command.
> >
> > However, "stg rebase <target>" does not sound right.  I'm not very
> > happy with "stg rebaseto <target>" (or rebase-to) either.
> 
> I think something 'stg rebase <newbase>' sounds OK.

It's just that it sounds more natural to me to give as instruction "do
rebase (current stack) to that point" than "do rebase that point",
which "rebase <newbase>" would seem to imply.

Best reagards,
-- 
Yann.
