From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Tue, 09 Jan 2007 17:24:10 -0800
Message-ID: <7vwt3vfzd1.fsf@assigned-by-dhcp.cox.net>
References: <87odphgfzz.wl%cworth@cworth.org>
	<7vbql9ydd7.fsf@assigned-by-dhcp.cox.net>
	<20070108131735.GA2647@coredump.intra.peff.net>
	<7vzm8tt5kf.fsf@assigned-by-dhcp.cox.net>
	<20070109142130.GA10633@coredump.intra.peff.net>
	<7virffkick.fsf@assigned-by-dhcp.cox.net>
	<20070109213117.GB25012@fieldses.org>
	<87zm8ryiyz.wl%cworth@cworth.org> <20070109234421.GD30023@spearce.org>
	<eo1bqu$hji$1@sea.gmane.org> <20070110003433.GH30023@spearce.org>
	<Pine.LNX.4.64.0701092014390.4964@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 02:24:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4SCO-0006VD-4u
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 02:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624AbXAJBYM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 20:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932627AbXAJBYM
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 20:24:12 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:42716 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932624AbXAJBYL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 20:24:11 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070110012410.TIGJ16632.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Tue, 9 Jan 2007 20:24:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9DPL1W0051kojtg0000000; Tue, 09 Jan 2007 20:23:20 -0500
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0701092014390.4964@xanadu.home> (Nicolas Pitre's
	message of "Tue, 09 Jan 2007 20:15:58 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36463>

Nicolas Pitre <nico@cam.org> writes:

>> Unfortunately .git/logs/HEAD wouldn't be created by default as its
>> not under refs/heads or refs/remotes.  Though it could be made to be
>> on by default, in which case it would only log changes while HEAD
>> is detached.  If HEAD is attached to a branch then .git/logs/HEAD
>> wouldn't be appended to (or even created), while the branch's own
>> log is still appended to.
>
> Is this worth the trouble and complexity?  After all detached heads are 
> not meant to be used for serious development.

I agree.
