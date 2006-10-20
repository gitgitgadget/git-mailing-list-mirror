From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 16:12:13 +0200
Message-ID: <200610201612.14417.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <200610201517.26702.jnareb@gmail.com> <20061020133630.GH20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: James Henstridge <james@jamesh.id.au>,
	bazaar-ng@lists.canonical.com, Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 16:12:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gav6e-0004UG-6x
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 16:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbWJTOMN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 10:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751712AbWJTOMN
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 10:12:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:15823 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751710AbWJTOMN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 10:12:13 -0400
Received: by ug-out-1314.google.com with SMTP id z34so629562ugc
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 07:12:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=IqYxHb5/Mw/qxPM84SQ4AheYVkrFjFamWnK34Yq0gWn93Ra41Z9hFKgSUeSJ4ZzWpraHAJgaiEDnd8fNyPXBXDx7+//6ZvUzPGIjtg6kA5Ic7wQKN/JWIvXz/MIrnAX4hF6gczaDptwx8Eq0kNU9jjAc3ZeAiRWnkeaWAXMwdp4=
Received: by 10.67.21.11 with SMTP id y11mr1939803ugi;
        Fri, 20 Oct 2006 07:12:11 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id o24sm1273912ugd.2006.10.20.07.12.10;
        Fri, 20 Oct 2006 07:12:10 -0700 (PDT)
To: Petr Baudis <pasky@suse.cz>
User-Agent: KMail/1.9.3
In-Reply-To: <20061020133630.GH20017@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29471>

Petr Baudis wrote:
> Dear diary, on Fri, Oct 20, 2006 at 03:17:26PM CEST, I got a letter
> where Jakub Narebski <jnareb@gmail.com> said that...

>> But you can also clone _whole_ repository, _all_ published branches with
>> 
>>    $ cg clone git://git.kernel.org/pub/scm/git/git.git
> 
> Nope, cg clone will in this case clone the master branch (or whatever
> the remote HEAD points at). cg clone -a is planned but not implemented
> yet. Very soon now, hopefully. :-)

That's probably because Cogito still uses obsolete branches/


$ git clone git://git.kernel.org/pub/scm/git/git.git

clones _whole_ repository, all the branches and tags, and saves information
about the branches it cloned, and URL to repository in remotes/ file.
 
>> In GIT to work on some repository you don't (like from what I understand
>> in Bazaar-NG) "checkout" some branch (which would automatically copy some
>> data in case of "heavy checkout" or just save some pointer to repository
>> in "lightweight checkout" case). You clone whole repository; well you can
>> select which branches to clone. "Checkout" in GIT terminology means to
>> populate working area with given version (and change in repository which
>> branch is current, usually).
> 
> You don't need to, you can switch your working tree between various
> branches.  I think Linus said he does that (or was it Junio?), and I do that
> as well, as well as many others.

I should have said: bring working area to state given by some revision
(instead of "populate working area").

-- 
Jakub Narebski
Poland
