From: Casey Dahlin <cdahlin@redhat.com>
Subject: Re: [PATCH] logging branch deletion to help recovering from mistakes
Date: Tue, 7 Dec 2010 13:26:09 -0500
Message-ID: <20101207182608.GV355@fearengine.rdu.redhat.com>
References: <7vlj42siu5.fsf@alter.siamese.dyndns.org>
 <20101207162358.GT355@fearengine.rdu.redhat.com>
 <20101207174520.GB21483@burratino>
 <20101207175418.GU355@fearengine.rdu.redhat.com>
 <20101207180236.GC21483@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Casey Dahlin <cdahlin@redhat.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 19:26:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ2FI-0006nX-55
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 19:26:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467Ab0LGS0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 13:26:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57091 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753443Ab0LGS0a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 13:26:30 -0500
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id oB7IQBec027411
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 7 Dec 2010 13:26:11 -0500
Received: from fearengine.rdu.redhat.com (dhcp243-150.rdu.redhat.com [10.11.243.150])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id oB7IQ9gw007238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 7 Dec 2010 13:26:10 -0500
Content-Disposition: inline
In-Reply-To: <20101207180236.GC21483@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163106>

On Tue, Dec 07, 2010 at 12:02:36PM -0600, Jonathan Nieder wrote:
> Casey Dahlin wrote:
> > On Tue, Dec 07, 2010 at 11:45:20AM -0600, Jonathan Nieder wrote:
> >> Casey Dahlin wrote:
> 
> >>> Could commits made onto a detached head also show up here? Or is that
> >>> better thwarted with another mechanism?
> >>
> >> I think that's better thwarted with the HEAD reflog:
> >> 
> >> 	$ git log -g HEAD
> >
> > I was more worried about changes that were made onto a detached head,
> > and then the head was reattached, leaving the new commits dangling.
> 
> But isn't that exactly what a detached HEAD is for?  If one wants
> the experiments one does on detached HEAD to be kept around "just
> in case", wouldn't it make more sense to give them a (branch) name so
> they can be separated from one another?
> 

An experienced git user who's paying attention to what he's doing would
do things that way, but detached heads and what happens to commits
thereupon are one of those concepts that tends to puzzle newbies, so
making it harder to make mistakes with them is probably a good idea.

Even still, there's always going to be those "Oh, I actually wanted to
keep some of that" moments, and that's what I'm talking about preparing
for.

--CJD
