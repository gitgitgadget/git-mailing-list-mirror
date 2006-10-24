From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Fix bad usage of mkpath in builtin-branch.sh
Date: Tue, 24 Oct 2006 13:38:06 +0200
Message-ID: <20061024113806.GB20017@pasky.or.cz>
References: <1161655176461-git-send-email-hjemli@gmail.com> <7vlkn6qkh2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 13:38:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcKbm-0002BT-Ki
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 13:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030315AbWJXLiJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 07:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbWJXLiJ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 07:38:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:34501 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030315AbWJXLiI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 07:38:08 -0400
Received: (qmail 21829 invoked by uid 2001); 24 Oct 2006 13:38:06 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vlkn6qkh2.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29967>

Dear diary, on Tue, Oct 24, 2006 at 08:46:49AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Lars Hjemli <hjemli@gmail.com> writes:
> 
> > When checking if a branch start point referred to a commit-object,
> > the result of mkpath() was used as argument to get_sha1(), which
> > didn't work out as planned.
> >
> > Now it's xstrdup'd first.
> >
> > Signed-off-by: Lars Hjemli <hjemli@gmail.com>
> > ---
> >  builtin-branch.c |    5 ++++-
> >  1 files changed, 4 insertions(+), 1 deletions(-)
> >
> > diff --git a/builtin-branch.c b/builtin-branch.c
> > index ffc2db0..f86bf68 100755
> 
> I've already fixed up this perm-mode breakage (and other
> breakages, possibly) so when I am done with these patches
> tonight please resync with me.

I have made my fair share of inadverent mode changes as well (I don't
even know how that *happenned*), and I don't seem to be alone; since
this is something you are doing only rarely anyway, perhaps we should
try to make mode changes more visible?

	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@ WARNING: FILE MODE HAS CHANGED!!!!111 pERHAPS A MISTAKE? @
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

;-))

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
