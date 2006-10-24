From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Make git-branch a builtin
Date: Tue, 24 Oct 2006 13:39:24 +0200
Message-ID: <20061024113924.GC20017@pasky.or.cz>
References: <11616396262982-git-send-email-hjemli@gmail.com> <20061023215506.GB8344@spearce.org> <7vfydewqbb.fsf@assigned-by-dhcp.cox.net> <20061024054408.GA9724@spearce.org> <7vy7r6qkmg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 13:39:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcKcz-0002RD-EU
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 13:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030337AbWJXLj0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 07:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbWJXLj0
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 07:39:26 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56494 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030337AbWJXLj0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 07:39:26 -0400
Received: (qmail 21904 invoked by uid 2001); 24 Oct 2006 13:39:24 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy7r6qkmg.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29968>

Dear diary, on Tue, Oct 24, 2006 at 08:43:35AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Shawn Pearce <spearce@spearce.org> writes:
> 
> >> > Wouldn't it make more sense to just include the full SHA1 of the
> >> > file we are deleting rather than the entire 131 line negative diff?
> >> 
> >> How would you do "git apply -R" on something like that?
> >
> > Uh, you have the full SHA1 in the index line.  So you just have to
> > reattach that blob to the named path...  pretty simple actually.
> 
> Bzzzt; wrong answer.
> 
> Think of a future when you can shallowly clone near the tip of
> git repository that does not have shell-script git-branch.sh
> anymore.  You cannot expect to already have the preimage of the
> patch in such a case.  You would still want to be able to revert
> the change with "git apply -R".

Hmm, how is this argument not applying to binary diffs you can't revert
either?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
