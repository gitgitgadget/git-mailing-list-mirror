From: Matthew L Foster <mfoster167@yahoo.com>
Subject: Re: git and time
Date: Tue, 26 Sep 2006 17:27:45 -0700 (PDT)
Message-ID: <20060927002745.15344.qmail@web51005.mail.yahoo.com>
References: <20060926233321.GA17084@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 02:28:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSNHF-0002DM-MN
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 02:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWI0A1u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 20:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWI0A1u
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 20:27:50 -0400
Received: from web51005.mail.yahoo.com ([206.190.38.136]:58260 "HELO
	web51005.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750808AbWI0A1t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 20:27:49 -0400
Received: (qmail 15346 invoked by uid 60001); 27 Sep 2006 00:27:45 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ztg+li+XOi3/1Iqs8E8jrdPI+sZ+pEiXe36OHQgdZB2seOZOPcmRaKm3aEqVD1G4fkE5I/1Bf0E8/pNsGDaBWhqiNxMPd706TL8d6pEtyW6M6kbefMjO6lvIsf7FhAsSisVDKxEa96I73hoOPMDFSSQpgS7TIqYKHVQkqZzSyfM=  ;
Received: from [207.172.80.85] by web51005.mail.yahoo.com via HTTP; Tue, 26 Sep 2006 17:27:45 PDT
To: Jeff King <peff@peff.net>
In-Reply-To: <20060926233321.GA17084@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27841>

> Keep in mind that git doesn't really CARE about timestamps to do most
> operations; it operates on the graph created by parentage. Think of the
> timestamps more as comments; when a commit is created, we comment who
> did it and when, both accordinging to their local information.
> 
> -Peff
> 
> PS Nit: Git doesn't work with changesets, it works with snapshots,
> building a directed graph of snapshots. Maybe that is the source of your
> confusion

It's true I don't know much about git, what is the difference between a changeset and a snapshot?
Are you saying timestamps should be tracked separately or tracked by an scm system built on top of
git? Does/should git care about the when of a snapshot?

Perhaps my question is directed more toward gitweb.cgi, it seems to me the timestamp of when a
snapshot was merged into this repository should somehow be tracked and that is what gitweb.cgi
should default to display. For example, if someone wants to know if security bugfix X was merged
into linus' kernel tree they also want to know when that happened, don't they? 

-Matt


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
