From: Petr Baudis <pasky@suse.cz>
Subject: Re: Strange merge conflicts against earlier merge.
Date: Fri, 11 Nov 2005 12:35:46 +0100
Message-ID: <20051111113546.GP30496@pasky.or.cz>
References: <46a038f90511091638k726d605r170717539225a712@mail.gmail.com> <20051110102043.GQ30496@pasky.or.cz> <46a038f90511102040n3e251252rce54117c51ce0429@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 11 12:36:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaXCB-00014D-TI
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 12:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbVKKLft (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 06:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbVKKLft
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 06:35:49 -0500
Received: from w241.dkm.cz ([62.24.88.241]:445 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750745AbVKKLfs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 06:35:48 -0500
Received: (qmail 29384 invoked by uid 2001); 11 Nov 2005 12:35:46 +0100
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90511102040n3e251252rce54117c51ce0429@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11588>

Dear diary, on Fri, Nov 11, 2005 at 05:40:05AM CET, I got a letter
where Martin Langhoff <martin.langhoff@gmail.com> said that...
> On 11/10/05, Petr Baudis <pasky@suse.cz> wrote:
> > > For an example, clone
> > > http://locke.catalyst.net.nz/git/moodle.git#mdl-artena-tairawhiti and
> > > register also the
> > > http://locke.catalyst.net.nz/git/moodle.git#mdl-local branch. Create
> > > two heads:
> >
> > Could you please run git-update-server-info over there?
> 
> Should be fixed now...

I still have trouble cloning:

$ cg-clone http://locke.catalyst.net.nz/git/moodle.git#mdl-artena-tairawhiti
defaulting to local storage area
warning: templates not found /home/xpasky/share/git-core/templates/
12:13:31 URL:http://locke.catalyst.net.nz/git/moodle.git/refs/heads/mdl-artena-tairawhiti [41/41] -> ".git/refs/heads/.origin-fetching" [1]
progress: 3 objects, 860 bytes
Getting alternates list
progress: 4 objects, 1934 bytes
Getting pack list
progress: 19 objects, 12532 bytes
error: The requested URL returned error: 404
error: Unable to find 214e6374d49e6d014f0ba6f159d585a3fe468909 under
http://locke.catalyst.net.nz/git/moodle.git/

Cannot obtain needed commit 214e6374d49e6d014f0ba6f159d585a3fe468909
while processing commit 6d32aa8241387e58ffd0e18862114add0d20d686.
cg-fetch: objects fetch failed
cg-clone: fetch failed


PS: Do I understand it right that git-clone can't clone just a single
head?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
