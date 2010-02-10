From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: RFC: git sync
Date: Wed, 10 Feb 2010 01:52:51 -0800 (PST)
Message-ID: <m3wryl8lkp.fsf@localhost.localdomain>
References: <20100210032720.GA5205@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Larry D'Anna" <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Wed Feb 10 10:53:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf9Fo-0004v7-A0
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 10:53:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604Ab0BJJw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 04:52:56 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:40984 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218Ab0BJJwz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 04:52:55 -0500
Received: by fxm20 with SMTP id 20so997117fxm.21
        for <git@vger.kernel.org>; Wed, 10 Feb 2010 01:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=e7t4pr/YOQ4aVeGEP44yQxx962bDvqC+oKcewXB/xJM=;
        b=XPjDn52N9aBla9UHBEccukcsD8xurKdNzzttIO2EmF6eFA6BkXkPb/XSVwcJfF5gBK
         ezBOP1YsPQfc/wxkFUdMWp1FplA5JbdT0ZraWHmHY6Evpbf5LX4v77xsjgdFp4zHzqom
         TIExRmSmVFEMj0hH+TNQngu2I/nSNW3aGJbPI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=tJkhpF9zund5RFSlpE2SaYULbCiFOKjkJXuzf7QoSZYgyMfmlRCmHDwfnpW8SClNKE
         0v8FVxYLosR8YjdmViizXojK62bBzEQPKd1Oul3T/nNRKO8JBDuMz4Ss8uJ/6yOuxZyj
         54GhYMSmOW6FKpa4m1aw19SAIFMFQNCdv+jEA=
Received: by 10.87.76.6 with SMTP id d6mr2498637fgl.71.1265795573091;
        Wed, 10 Feb 2010 01:52:53 -0800 (PST)
Received: from localhost.localdomain (abvh24.neoplus.adsl.tpnet.pl [83.8.205.24])
        by mx.google.com with ESMTPS id d6sm8603183fga.19.2010.02.10.01.52.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Feb 2010 01:52:51 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o1A9qNdV006776;
	Wed, 10 Feb 2010 10:52:34 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o1A9q7jX006772;
	Wed, 10 Feb 2010 10:52:07 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100210032720.GA5205@cthulhu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139501>

Larry D'Anna <larry@elder-gods.org> writes:

> So say you have a project with a bunch of branches.  You have two main computers
> you work on: a laptop and a workstation, and you keep an authoritative copy on a
> server somewhere.  When you sit down at your laptop to work on your project, the
> first thing you want to do is make sure that whatever you've got locally is
> up-to-date with the repo on the server.  So you run: 
> 
> git push origin :
> 
> Then if it says anything isn't a fast-forward, you use some combination of git
> pull, git checkout, or git fetch to get all you branches up to date, then
> possibly you run the push again to push merges back to the server.
> 
> How about instead we add a new command called "git sync" that does all that for
> you?  So if you say 
> 
> git sync origin : 

[...]
> What do you all think?  If you like the idea, I'll do it as a builtin.
> Otherwise I'll just hack up a perl script for myself.

Why not use the recpie from GitFaq:
"How would I use "git push" to sync out of a host that I cannot pull from?"
http://git.wiki.kernel.org/index.php/GitFaq#How_would_I_use_.22git_push.22_to_sync_out_of_a_host_that_I_cannot_pull_from.3F

-- 
Jakub Narebski
Poland
ShadeHawk on #git
