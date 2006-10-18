From: Charles Duffy <cduffy@spamcop.net>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 18:31:32 -0500
Message-ID: <eh6dgr$pu8$1@sea.gmane.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>	<45349162.90001@op5.se>	<453536AE.6060601@utoronto.ca>	<200610172301.27101.jnareb@gmail.com>	<45354AD0.1020107@utoronto.ca>	<BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE>	<45355CBB.80108@utoronto.ca>	<BAYC1-PASMTP01369CD694D75CB61ACCC7AE0E0@CEZ.ICE>	<eh64tk$rug$2@sea.gmane.org> <BAYC1-PASMTP069C473B2E79389E5BFC92AE0F0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com
X-From: git-owner@vger.kernel.org Thu Oct 19 01:32:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaKtE-00058u-D5
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 01:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbWJRXbz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 19:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbWJRXbz
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 19:31:55 -0400
Received: from main.gmane.org ([80.91.229.2]:17829 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751553AbWJRXby (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 19:31:54 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GaKt0-00056y-Ht
	for git@vger.kernel.org; Thu, 19 Oct 2006 01:31:46 +0200
Received: from user-12lmn28.cable.mindspring.com ([69.91.92.72])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Oct 2006 01:31:46 +0200
Received: from cduffy by user-12lmn28.cable.mindspring.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Oct 2006 01:31:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: user-12lmn28.cable.mindspring.com
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
In-Reply-To: <BAYC1-PASMTP069C473B2E79389E5BFC92AE0F0@CEZ.ICE>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29298>

Sean wrote:
> You'll need a better example than that.  Git has supported a version
> of Cygwin-compatible symlink support on Windows for quite some time.
> And no plugins were needed.

The win32-compatible symlink support is not, in and of itself, the point.

The point is that core, pervasive functionality can be modified at 
runtime, with no recompilation or installation of tools not included in 
the bzr package itself, simply by dropping a directory into place. This 
means that folks who don't have the skillset to merge three branches 
together (say, upstream plus two different trees adding extra 
functionality) and run a build can still install a few plugins to 
enhance their copy of bzr (which was installed by their IT staff, or a 
shiny click-through idiot-friendly Windows installer, etc).

And yes, there are people like that who are part of bzr's target 
audience. Think (of the lower end of the set of) DBAs, QA folk and such.


Granted, I'm speaking with my IT hat on here rather than my developer 
hat -- but plugins are a pretty clear usability win.
