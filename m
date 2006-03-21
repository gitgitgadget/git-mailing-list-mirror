From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Don't use merge labels in the ed scripts
Date: Tue, 21 Mar 2006 22:48:18 +0100
Message-ID: <20060321214818.GY19263@pasky.or.cz>
References: <20060321205414.8301.97041.stgit@dv.roinet.com> <20060321205956.GX19263@pasky.or.cz> <1142977465.8712.4.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 21 22:48:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLohq-00036e-Ug
	for gcvg-git@gmane.org; Tue, 21 Mar 2006 22:47:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbWCUVr4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Mar 2006 16:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWCUVr4
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Mar 2006 16:47:56 -0500
Received: from w241.dkm.cz ([62.24.88.241]:46817 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751438AbWCUVrz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Mar 2006 16:47:55 -0500
Received: (qmail 31066 invoked by uid 2001); 21 Mar 2006 22:48:18 +0100
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1142977465.8712.4.camel@dv>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17792>

  Hi,

Dear diary, on Tue, Mar 21, 2006 at 10:44:25PM CET, I got a letter
where Pavel Roskin <proski@gnu.org> said that...
> On Tue, 2006-03-21 at 21:59 +0100, Petr Baudis wrote:
> > Dear diary, on Tue, Mar 21, 2006 at 09:54:14PM CET, I got a letter
> > where Pavel Roskin <proski@gnu.org> said that...
> > > From: Pavel Roskin <proski@gnu.org>
> > > 
> > > Merge labels keep changing, and they are not required to identify
> > > specific lines uniquely for the test purposes.
> > > 
> > > Signed-off-by: Pavel Roskin <proski@gnu.org>
> > 
> > Well, I sincerely hope that they won't change again. ;-)
> 
> Actually, it would be nice to never expose labels starting with
> ".merge_file_" - cogito should provide more meaningful labels instead.

  we shouldn't ever expose them, though. If we do, that's a bug.

> If you prefer, I'll submit a minimal patch to 0017-alice-bob-fixup.ed
> instead.  Once ".merge_file_" is gone, the "tutorial" testsuite would
> check that such labels never appear again.

  Curious, it contains the old-style label yet does not fail here now.
Unfortunately I have no time to play with it now. :-( A patch will be
most welcome.

  Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
