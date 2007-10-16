From: Eli Zaretskii <eliz@gnu.org>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 09:04:00 -0400
Message-ID: <E1Ihm5Y-0005kT-AU@fencepost.gnu.org>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org>
 <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
 <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site>
 <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site>
 <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
 <Pine.LNX.4.64.0710151859590.7638@iabervon.org> <uodezisvg.fsf@gnu.org>
 <471448D0.6080200@op5.se> <E1Ihfrl-0007w1-3I@fencepost.gnu.org>
 <Pine.LNX.4.64.0710161324490.25221@racer.site> <Pine.LNX.4.64.0710161335500.8571@ds9.cixit.se>
Reply-To: Eli Zaretskii <eliz@gnu.org>
Cc: Johannes.Schindelin@gmx.de, ae@op5.se, barkalow@iabervon.org,
	raa.lkml@gmail.com, tsuna@lrde.epita.fr, git@vger.kernel.org
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Oct 16 15:04:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihm5v-0001nF-Ah
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 15:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760194AbXJPNEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 09:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760286AbXJPNEE
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 09:04:04 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:39009 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760182AbXJPNEB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 09:04:01 -0400
Received: from eliz by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <eliz@gnu.org>)
	id 1Ihm5Y-0005kT-AU; Tue, 16 Oct 2007 09:04:00 -0400
In-reply-to: <Pine.LNX.4.64.0710161335500.8571@ds9.cixit.se> (message from
	Peter Karlsson on Tue, 16 Oct 2007 13:38:59 +0100 (CET))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61159>

> Date: Tue, 16 Oct 2007 13:38:59 +0100 (CET)
> From: Peter Karlsson <peter@softwolves.pp.se>
> cc: Eli Zaretskii <eliz@gnu.org>, Andreas Ericsson <ae@op5.se>,
>    barkalow@iabervon.org, raa.lkml@gmail.com, tsuna@lrde.epita.fr,
>    git@vger.kernel.org
> 
> If you create a file name with only capital letters, I believe Explorer
> and the file browser will display the name with an initial capital, and
> the rest lowercase, or in all lowercase.

That's true, but the names are only displayed like that, what's on
disk is not changed in any way.

> IIRC, this is because such a
> file is saved with only an MS-DOS name and no LFN entry, and those have
> special rules to avoid them being displayed in all-uppercase.

I don't think this true anymore in modern versions of Windows, but I
might be mistaken.  In any case, the reason for the Explorer behavior
is immaterial for us, what matters is that file names on disk preserve
the lettercase of the program that created them, at least AFAIK.
