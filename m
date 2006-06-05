From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [RFC] git commit --branch
Date: Mon, 05 Jun 2006 13:22:15 -0500
Message-ID: <1149531734.23938.22.camel@cashmere.sps.mot.com>
References: <20060529202851.GE14325@admingilde.org>
	 <7vr72b27x9.fsf@assigned-by-dhcp.cox.net>
	 <20060530210551.GI14325@admingilde.org>
	 <7vd5dvyvkq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Martin Waitz <tali@admingilde.org>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 05 20:27:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnJnD-0000dn-JI
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 20:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWFES1E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 14:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWFES1E
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 14:27:04 -0400
Received: from [192.88.158.103] ([192.88.158.103]:38806 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1750744AbWFES1C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jun 2006 14:27:02 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id k55Ige54004876;
	Mon, 5 Jun 2006 11:42:40 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k55IPwXx002581;
	Mon, 5 Jun 2006 13:25:59 -0500 (CDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5dvyvkq.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21327>

On Tue, 2006-05-30 at 17:52, Junio C Hamano wrote:
> Martin Waitz <tali@admingilde.org> writes:
> 
> >> And your approach is to backport the fix to its original topic
> >> and then re-pull the topic onto the test branch.
> >
> > yes. I was doing this after working on gitweb a bit.
> > In order to test gitweb, I need some local adaptations.
> 
> Funny you mention this.  I had exactly the same arrangement for
> hacking on gitweb.  One "localconf" branch to tell it where the
> repositories are, "origin" to track upstream, "master" to use
> for deployment, and other topic branches.

We all do. :-)

BTW, did you (anyone?) see my patch to help the local
configuration issue some?  It basically separates out the
config bits into a separate hash table in a separate file that
can be updated quite independently without even modifying
the original gitweb.cgi.  That allows the gitweb.cgi 
proper to be slammed down and updated much more readily.

    http://marc.theaimsgroup.com/?l=git&m=114308224922372&w=2

jdl
