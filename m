From: Sasha Khapyorsky <sashak@voltaire.com>
Subject: Re: [PATCH] git-svnimport.perl: copying directory from original SVN place
Date: Fri, 20 Oct 2006 02:31:30 +0200
Message-ID: <20061020003130.GG24676@sashak.voltaire.com>
References: <20061008213118.GA1367@sashak.voltaire.com> <20061020002219.GF24676@sashak.voltaire.com> <7vmz7rrg1a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Fri Oct 20 02:25:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaiCx-0000k6-Qn
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 02:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946754AbWJTAZx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 20:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946755AbWJTAZx
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 20:25:53 -0400
Received: from taurus.voltaire.com ([193.47.165.240]:45089 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1946754AbWJTAZw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 20:25:52 -0400
Received: from sashak ([172.25.5.107]) by taurus.voltaire.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 20 Oct 2006 02:25:50 +0200
Received: by sashak (sSMTP sendmail emulation); Fri, 20 Oct 2006 02:31:30 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmz7rrg1a.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 20 Oct 2006 00:25:50.0696 (UTC) FILETIME=[4BD1AE80:01C6F3DE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29395>

On 17:23 Thu 19 Oct     , Junio C Hamano wrote:
> Sasha Khapyorsky <sashak@voltaire.com> writes:
> 
> > Hi guys,
> >
> > On 23:31 Sun 08 Oct     , Sasha Khapyorsky wrote:
> >> 
> >> When copying whole directory, if source directory is not in already
> >> imported tree, try to get it from original SVN location. This happens
> >> when source directory is not matched by provided 'trunk' and/or
> >> 'tags/branches' templates or when it is not part of specified SVN
> >> sub-project.
> >
> > Any news with it?
> 
> I've pushed it out in "master" after 1.4.3, to see if anybody
> cares about git-svnimport would scream.  If we do not hear from
> anybody about breakage that would be a good sign, otherwise we
> would get a fix so that is good as well ;-).

Cool. Thanks.

Sasha
