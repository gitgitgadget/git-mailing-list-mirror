From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] bash completion: Hide more plumbing commands
Date: Tue, 26 Aug 2008 10:43:02 -0700 (PDT)
Message-ID: <m3tzd7r7tr.fsf@localhost.localdomain>
References: <20080826171012.GO10360@machine.or.cz>
	<20080826171144.21328.82727.stgit@localhost>
	<20080826172410.GJ26523@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	gitster@pobox.com, andi@firstfloor.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 19:44:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY2aR-0008Hx-Of
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 19:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756496AbYHZRnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 13:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754877AbYHZRnG
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 13:43:06 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:61827 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093AbYHZRnF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 13:43:05 -0400
Received: by ey-out-2122.google.com with SMTP id 6so337767eyi.37
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 10:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=wM1pZZDPKtdZYPQ+TryRy8QBlXNdtfyYQ66/95yZxoc=;
        b=H1b2DsjqvBftpzmj0cJuxw5xsOrtvQExY7yLTDWBd6ET4zc1MZGrh2b/2Gs07mOJJp
         C6rLO+tXf+7xOe306dVKTiRBklkJJAUgSCv9x6d7OmNAhE1Y4wEy1NJaVm2PjXOAF2WH
         rWohf0T8efoFoWXUj77Nw+s0OIOb1M4UEcJuc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=n0EBUFTyqUZaf+SV7d0xlTrhNo2ix24sU0qli2JhG1fZ2+AvqbVVXTMJ1r6VQp3e7x
         OfSkbAIBA+nyCLBBv+oFOXiFlfkzOtgnB/PJGGLfiaNz38WjjWH3HqJ3gsu0hVbX2edh
         8TcUMrt4nshOP5ICKEcGHBx5Q/6pGC04k9EO8=
Received: by 10.210.124.8 with SMTP id w8mr8707974ebc.194.1219772583506;
        Tue, 26 Aug 2008 10:43:03 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.254.77])
        by mx.google.com with ESMTPS id z37sm5585795ikz.6.2008.08.26.10.43.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 Aug 2008 10:43:02 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m7QHgxA5005587;
	Tue, 26 Aug 2008 19:43:00 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m7QHgudn005584;
	Tue, 26 Aug 2008 19:42:56 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080826172410.GJ26523@spearce.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93783>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Petr Baudis <pasky@suse.cz> wrote:
> > git <tab><tab> still shows way too many commands, some of them
> > are clearly plumbing. This patch hides the plumbing commands
> > liberally (that is, in special cases, users still might want to
> > call one of the hidden commands, a *normal* workflow should never
> > involve these, though - and if it does, we have a UI problem anyway).
> > 
> > Signed-off-by: Petr Baudis <pasky@suse.cz>
> 
> Acked-by: Shawn O. Pearce <spearce@spearce.org>
> 
> Though I use git ls-remote at least once every other day to see
> what branches are available on my egit/spearce.git fork.  Its ok,
> I guess I can type a few extra characters...

One would think that one can use "git remote show <remote>" instead of
"git ls-remote <remote>", but I'm not sure if it does show also
_untracked_ remote branches.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
