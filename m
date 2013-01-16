From: David Lang <david@lang.hm>
Subject: Re: Question re. git remote repository
Date: Wed, 16 Jan 2013 12:07:47 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1301161202390.21503@nftneq.ynat.uz>
References: <201301161749.r0GHnGV6007806@smtpb02.one-mail.on.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "'git@vger.kernel.org'" <git@vger.kernel.org>
To: "Lang, David" <David.Lang@uhn.ca>
X-From: git-owner@vger.kernel.org Wed Jan 16 21:16:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvZP2-0000si-Tc
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 21:16:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752791Ab3APUPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 15:15:44 -0500
Received: from mail.lang.hm ([64.81.33.126]:35269 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751363Ab3APUPo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 15:15:44 -0500
X-Greylist: delayed 385 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jan 2013 15:15:44 EST
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id r0GK9CRf026277;
	Wed, 16 Jan 2013 12:09:12 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <201301161749.r0GHnGV6007806@smtpb02.one-mail.on.ca>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213807>

Hi David, now we are going to have some confusion here, two David Langs on the 
list :-)

On Wed, 16 Jan 2013, Lang, David wrote:

> We're just in the process of investigating a versioning tool and are very 
> interesting in git. We have one question we're hoping someone can answer. In 
> regards to the repositories, I think I understand correctly that each 
> developer will have a local repository that they will work from, and that 
> there will also be a remote repository (origin) that will hold the original 
> version of the project.
>
> It appears from the limited reading I've done that the remote repository must 
> be hosted at github.com. Is this the case? Ideally we'd prefer to simply 
> create our remote repository on a drive of one of our local network servers. 
> Is this possible?

Git is peer-to-peer, the 'origin' is just the default to pull from. It can be 
hosted on any machine that you have access to.

A typical case is that you designate one person (or a small group of people) 
to oversee your master repository, and that person decides when and what to pull 
there from the developers.

This gives you a chance to insert code review, tests, etc between what the 
developers produce in their local repository and what you then bless as the 
authoritative 'released' version of the code.

However, this master repository is just a matter of convention, it is possible 
to use any repository as the 'origin', changing it is just a config change away.

David Lang
