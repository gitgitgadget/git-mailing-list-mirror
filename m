From: David Lang <dlang@digitalinsight.com>
Subject: Re: git and time
Date: Tue, 26 Sep 2006 17:47:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0609261746160.22495@qynat.qvtvafvgr.pbz>
References: <20060926233321.GA17084@coredump.intra.peff.net><20060927002745.
 15344.qmail@web51005.mail.yahoo.com> <BAYC1-PASMTP084ACE9B12C54DABFE8EB9AE1A0@CEZ.ICE>
  <20060926205632.5d487cc9.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Matthew L Foster <mfoster167@yahoo.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 03:01:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSNnV-0002u8-OS
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 03:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWI0BA7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 21:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWI0BA7
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 21:00:59 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:17860 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932109AbWI0BA4
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 21:00:56 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Tue, 26 Sep 2006 18:00:56 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Tue, 26 Sep 2006 18:00:39 -0700
X-X-Sender: dlang@dlang.diginsite.com
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP084ACE9B12C54DABFE8EB9AE1A0@CEZ.ICE>  <20060926205632.5d487cc9.seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27843>

On Tue, 26 Sep 2006, Sean wrote:

>> It's true I don't know much about git, what is the difference between a changeset and a snapshot?
>> Are you saying timestamps should be tracked separately or tracked by an scm system built on top of
>> git? Does/should git care about the when of a snapshot?
>>
>> Perhaps my question is directed more toward gitweb.cgi, it seems to me the timestamp of when a
>> snapshot was merged into this repository should somehow be tracked and that is what gitweb.cgi
>> should default to display. For example, if someone wants to know if security bugfix X was merged
>> into linus' kernel tree they also want to know when that happened, don't they?
>
> You are right that a "Merged Date:" in gitweb would be useful information to
> show for each commit, but it's not straightforward given the design of git.

would it?

remember that a pach could be merged to many trees in any order. which merge 
date do you want to know about?

David Lang
