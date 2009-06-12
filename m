From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: [bug] git cannot find "git pull"?
Date: Thu, 11 Jun 2009 23:52:18 -0700
Message-ID: <4A31FB22.7030500@eaglescrag.net>
References: <4A319CE1.6040201@garzik.org>	<20090612011737.GB5076@inocybe.localdomain>	<7v7hzidvcj.fsf@alter.siamese.dyndns.org>	<20090612031853.GC5076@inocybe.localdomain> <7viqj2c9rs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Todd Zullinger <tmz@pobox.com>, Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 08:53:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF0e0-0006KN-OU
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 08:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753689AbZFLGxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 02:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753040AbZFLGxf
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 02:53:35 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:55103 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbZFLGxe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 02:53:34 -0400
Received: from voot-cruiser.eaglescrag.net (173-19-86-210.client.mchsi.com [173.19.86.210])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id n5C6qNSH013071
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 11 Jun 2009 23:52:24 -0700
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <7viqj2c9rs.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
X-Virus-Scanned: ClamAV 0.88.7/9458/Thu Jun 11 17:47:06 2009 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.1.1 (shards.monkeyblade.net [198.137.202.13]); Thu, 11 Jun 2009 23:52:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121392>

Junio C Hamano wrote:
> Todd Zullinger <tmz@pobox.com> writes:
> 
>> Chris has been busy with other things for a while.  I started helping
>> with git package maintenance only in the last 6 months or so.  Over
>> time, the spec file we have has drifted a bit from what is in git.git,
>> though not terribly so.  I need to spend some time and look at what,
>> if any, changes in the Fedora spec file would be good candidates for
>> submitting to git.git.  I have been primarily concerned with making
>> things work cleanly on Fedora and RHEL/CentOS though, so some of the
>> changes may not be as generic as they ought to be if they are to be
>> included in git.git.
> 
> I use the one in git.git only to cut the Fedora 9 packages for consumption
> by k.org people.  I do not know what their upgrade plans are, but last
> time they upgraded from FC 5 to Fedora 9 I had to scramble around and find
> an i386 box to produce binaries (the machine available to me at k.org is
> amd64).  Perhaps I should start preparing Fedora 11 environment now it is
> finally released, but before that I need to procure a new development box
> to host it in a vm, as the current box that is the primary integration
> machine for git and that hosts the Fedora 9 i386 vm has got too tight and
> I've been limping along; it does not have enough room to host another vm
> (and it is not even hardware vm capable)...

The general idea is when we aren't getting security updates for our 
current install base, that is when we (k.org) will make the move to upgrade.

That said, since 11 just came out I'm going to have to start considering 
and working on an upgrade plan, but I wouldn't expect that to be getting 
to a point where it would affect you for a few months yet, and I would 
hate to upgrade to Fedora 11 before it's had a chance to settle and stew.

- John 'Warthog9' Hawley
