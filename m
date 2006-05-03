From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] Git wiki
Date: Thu, 4 May 2006 01:05:02 +0200
Message-ID: <20060503230502.GM27631@pasky.or.cz>
References: <4d8e3fd30605030213r625ce87fw5cbee554f1c20fbd@mail.gmail.com> <Pine.LNX.4.64.0605030934220.28543@localhost.localdomain> <20060503142957.GA9056@spearce.org> <4458C5D7.8010501@op5.se> <Pine.LNX.4.64.0605030817580.4086@g5.osdl.org> <20060503164732.GB9820@thunk.org> <Pine.LNX.4.64.0605030958370.4086@g5.osdl.org> <20060503223932.GA28081@mars.ravnborg.org> <20060503224645.GR27689@pasky.or.cz> <20060503225056.GT4226@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 04 01:04:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbQOL-0004A1-11
	for gcvg-git@gmane.org; Thu, 04 May 2006 01:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWECXEG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 19:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWECXEG
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 19:04:06 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63459 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751020AbWECXEF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 19:04:05 -0400
Received: (qmail 28677 invoked by uid 2001); 4 May 2006 01:05:02 +0200
To: Joel Becker <Joel.Becker@oracle.com>
Content-Disposition: inline
In-Reply-To: <20060503225056.GT4226@ca-server1.us.oracle.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19531>

Dear diary, on Thu, May 04, 2006 at 12:50:56AM CEST, I got a letter
where Joel Becker <Joel.Becker@oracle.com> said that...
> On Thu, May 04, 2006 at 12:46:45AM +0200, Petr Baudis wrote:
> > I think git ls-files isn't used directly very frequently. OTOH, you
> > don't use cg-log or git log and cg-status/git status? :) Also, most
> > people will pull.
> 
> 	I use git ls-files, becuase it's the only way I know how to
> blow away dirty state that added files.  I ran into this just yesterday,
> actually.  git checkout -f won't remove files that are unknown.
> 
>     $ git ls-files -o | xargs rm -rf

You can use cg-clean, and I think Git has got git-clean added recently.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
