From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] prepare deprecation of git-revert
Date: Sat, 1 Nov 2008 00:24:19 +0100
Message-ID: <20081031232419.GA21997@steel.home>
References: <1225468527-29694-1-git-send-email-madcoder@debian.org> <20081031165003.GA5355@steel.home> <20081031165814.GD627@artemis.corp>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 00:25:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw3N6-0007rb-Jy
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 00:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbYJaXY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 19:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbYJaXY2
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 19:24:28 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:50217 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbYJaXY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 19:24:27 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8BE81pIKr
Received: from tigra.home (Faf6f.f.strato-dslnet.de [195.4.175.111])
	by post.webmailer.de (fruni mo31) (RZmta 17.14)
	with ESMTP id e00231k9VLV6Rv ; Sat, 1 Nov 2008 00:24:25 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 8D1C3277C8;
	Sat,  1 Nov 2008 01:24:24 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id AB04756D27; Sat,  1 Nov 2008 00:24:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081031165814.GD627@artemis.corp>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99674>

Pierre Habouzit, Fri, Oct 31, 2008 17:58:14 +0100:
> On Fri, Oct 31, 2008 at 04:50:03PM +0000, Alex Riesen wrote:
> > Pierre Habouzit, Fri, Oct 31, 2008 16:55:27 +0100:
> > > @@ -439,16 +436,17 @@ static int revert_or_cherry_pick(int argc, const char **argv)
> > >  
> > >  int cmd_revert(int argc, const char **argv, const char *prefix)
> > >  {
> > > +#if 0
> > > +	warning("git revert is deprecated, please use git cherry-pick --revert/-R instead");
> > > +#endif
> > 
> > "git revert" is much shorter to type than "git cherry-pick -R".
> > How about renaming "cherry-pick" into something short, like "pick"?
> 
> Do you really use git revert _that_ often ? I don't. And cherry-pick is
> a really usual name for the tool.

Have it 5 times in my bash history of 20k lines. 4 recent, one relatively old.

> FWIW the basic idea is to deprecate revert in a (not so ?) long time,
> and leave git revert unimplemented for ever so that people that would
> like it to be 'git checkout HEAD --' alias it to that, and the ones that
> want to keep the current behaviour alias it to 'git cherry-pick -R'

Well, I kind of got used to it. And it makes sense (as does -R by
cherry-pick, I have to admit). I have no other argument against the
change.
