From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: git-svn: failure to clone logcheck's repo
Date: Fri, 13 Jul 2007 11:47:10 +0200
Message-ID: <20070713094710.GB18199@xp.machine.xx>
References: <20070713093622.GA21001@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 13 11:52:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9HpK-0002ih-0t
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 11:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933003AbXGMJwi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 05:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761997AbXGMJwi
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 05:52:38 -0400
Received: from matlock.hofmann.stw.uni-erlangen.de ([131.188.24.35]:33442 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759867AbXGMJwh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jul 2007 05:52:37 -0400
Received: (qmail 26701 invoked by uid 0); 13 Jul 2007 09:45:55 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 13 Jul 2007 09:45:55 -0000
Mail-Followup-To: git discussion list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070713093622.GA21001@lapse.madduck.net>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52376>

On Fri, Jul 13, 2007 at 11:36:22AM +0200, martin f krafft wrote:
> Hi list,
> 
> I am trying to access the logcheck repository with git-svn. Even
> though I can happily clone the trunk:
> 
>   git-svn clone svn://svn.debian.org/svn/logcheck/logcheck/trunk git
> 
> as soon as I try to clone the entire thing with tags and branches:
> 
>   git-svn clone -T trunk -t tags -b branches
>     svn://svn.debian.org/svn/logcheck/logcheck git
> 
> it barfs:
> 
>   Initialized empty Git repository in .git/
>   Using higher level of URL: svn://svn.debian.org/svn/logcheck/logcheck => svn://svn.debian.org/svn/logcheck
>   r19 = 95d0625b6c62935cfd3e44ec7dca5b6f6b05ab44 (trunk)
>   [...]
>   r20 = a3e5240dcc4d064b46273584800d3ae7a1e21330 (trunk)
>   Found possible branch point: svn://svn.debian.org/svn/logcheck/logcheck/trunk => svn://svn.debian.org/svn/logcheck/logcheck/branches/VENDOR, 20
>   Found branch parent: (VENDOR) a3e5240dcc4d064b46273584800d3ae7a1e21330
>   Following parent with do_switch
>   Successfully followed parent
>   r21 = 0ffcb70923d77c1d24019362e1ed1cd18d05f235 (VENDOR)
>   Malformed network data: Malformed network data at /usr/local/bin/git-svn line 1029
> 
> I think I'll be fine with *not* preserving logcheck's history when
> I move it to git, but thought best to let you know since this may be
> a bug in git-svn.
> 

This is a known problem. If I remember correctly,it is save to just
resume the import with git-svn fetch, and nothing bad should happen.

Just search the list archive for more info (sorry, I don't have a
reference to the thread)

-Peter
