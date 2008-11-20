From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Allow help/--help/-h to be run outside of a TopGit repo
Date: Thu, 20 Nov 2008 16:08:32 +0100
Message-ID: <20081120150832.GI10491@machine.or.cz>
References: <1227181594-15123-1-git-send-email-madduck@debian.org> <20081120142702.GG10491@machine.or.cz> <20081120145511.GD29789@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: martin f krafft <madduck@debian.org>
X-From: git-owner@vger.kernel.org Thu Nov 20 16:12:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3BAD-0007Eg-07
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 16:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755239AbYKTPIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 10:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755259AbYKTPId
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 10:08:33 -0500
Received: from w241.dkm.cz ([62.24.88.241]:33177 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755007AbYKTPId (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 10:08:33 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 2C84B3939836; Thu, 20 Nov 2008 16:08:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081120145511.GD29789@piper.oerlikon.madduck.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101448>

On Thu, Nov 20, 2008 at 03:55:11PM +0100, martin f krafft wrote:
> also sprach Petr Baudis <pasky@suse.cz> [2008.11.20.1527 +0100]:
> > Why is this so complicated? Can't you just do_help from
> > should_do_help()?
> 
> Yes, I could, but that would be in conflict with my understanding of
> the Law of Demeter.

What is that?

> > The overall semantics seems strange anyway, though - it seems that
> > 'tg mail --help -r' will try to show help for '-r' instead of
> > 'mail'.
> 
> True, but then we are parsing command lines. Would you be opposed to
> a getopt (POSIX) approach to normalising/parsing the command line?

No. :-)

				Petr "Pasky" Baudis
