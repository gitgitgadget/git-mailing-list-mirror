From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 19:53:02 +0100
Message-ID: <451AC88E.1060104@shadowen.org>
References: <20060927180147.33024.qmail@web51009.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 27 20:54:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSeXL-0003fr-VX
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 20:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965156AbWI0Sxh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 14:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965158AbWI0Sxg
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 14:53:36 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:5640 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S965156AbWI0Sxf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 14:53:35 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1GSeWg-0000uY-SB; Wed, 27 Sep 2006 19:52:59 +0100
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
To: Matthew L Foster <mfoster167@yahoo.com>
In-Reply-To: <20060927180147.33024.qmail@web51009.mail.yahoo.com>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27920>

Matthew L Foster wrote:
>> Because git doesn't care about timestamps. It stores them as comments 
>> (albeit auto-formatted comments) and relies on the dependency chain to 
>> provide history.
> 
> Ok, the word "history" in the context of git primarily means the order of changes not the when?
> Would it be a conceptual or technical issue for git to directly track the local time of
> merges/changesets?

It is tracking the local times of each change as it is added to the
dependancy chain.  This chain then moves about between repositories
carrying its stamp with it.  When we merge a set of changes into a trunk
such as Linus does that merge will be stamped by him saying when he
merged it.  So there is plenty of time stuff in there.

Of course none of it tells you when the kernel you are running has it
in.  The only way to know that is to know when the thing was released,
under what version#, and what version you are running.

Now when we make a signed tag, doen't that make a new object too and I
assume that has a tagged date in it.  That time might really actually
mean something and a fix's relation ship to those tags might also mean
something.

-apw
