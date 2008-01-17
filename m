From: Mike <fromlists@talkingspider.com>
Subject: Re: I don't want the .git directory next to my code.
Date: Thu, 17 Jan 2008 14:12:48 -0500
Message-ID: <478FA8B0.2000205@talkingspider.com>
References: <478D79BD.7060006@talkingspider.com> <86hcheig3n.fsf@blue.stonehenge.com> <478D82FA.2030404@talkingspider.com> <478D95D8.5040806@theory.org> <478E3D8E.1090300@talkingspider.com> <alpine.LFD.1.00.0801161000310.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801161019250.2806@woody.linux-foundation.org> <478EEAC4.2010006@talkingspider.com> <20080117151725.GC2816@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 17 20:13:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFaAz-00077S-QF
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 20:13:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752978AbYAQTMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 14:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753421AbYAQTMw
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 14:12:52 -0500
Received: from relay00.pair.com ([209.68.5.9]:4856 "HELO relay00.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753324AbYAQTMv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 14:12:51 -0500
Received: (qmail 96848 invoked from network); 17 Jan 2008 19:12:49 -0000
Received: from unknown (HELO ?192.168.1.100?) (unknown)
  by unknown with SMTP; 17 Jan 2008 19:12:49 -0000
X-pair-Authenticated: 72.225.213.70
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <20080117151725.GC2816@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70908>



Jeff King wrote:
>   - moving .git away, and using --git-dir or GIT_DIR to specify it
>     manually

Actually, git-dir is sufficient for our needs, thanks.  I haven't been 
able to get my hands on man pages for git until this morning.  (If you 
look near the top of this thread you see that I don't have the git man 
pages because apparently CentOS (and probably RHEL too), doesn't include 
them when you "yum install git").

Linus posted a response about deployment and development being 
separated, so I had to point out why that doesn't work for web apps in 
interpreted languages.

You guys might want to complain to the CentOS (and/or RHEL) maintainers 
to have them put the man pages into the yum rpm. Er or whoever maintains 
that (they maintain that rpm, right? I don't know).

Thanks, Jeff,

mike
