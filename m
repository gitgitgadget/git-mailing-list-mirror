From: david@lang.hm
Subject: Re: how to track multiple upstreams in one repository
Date: Sun, 18 Jan 2009 19:58:17 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0901181957070.20741@asgard.lang.hm>
References: <alpine.DEB.1.10.0901181855400.20741@asgard.lang.hm> <20090119021426.GA21999@shion.is.fushizen.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Bryan Donlan <bdonlan@fushizen.net>
X-From: git-owner@vger.kernel.org Mon Jan 19 03:56:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOkJX-0008EL-CT
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 03:56:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758265AbZASCzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 21:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758147AbZASCzE
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 21:55:04 -0500
Received: from mail.lang.hm ([64.81.33.126]:40868 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757985AbZASCzA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 21:55:00 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n0J2svGP015866;
	Sun, 18 Jan 2009 18:54:57 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20090119021426.GA21999@shion.is.fushizen.net>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106307>

On Sun, 18 Jan 2009, Bryan Donlan wrote:

> On Sun, Jan 18, 2009 at 06:58:06PM -0800, david@lang.hm wrote:
>> for linux I want to track both the linus tree and the -stable tree.
>> Ideally I want to be able to do a checkout of tags from either tree from
>> the same directory (along with diffs between items in both trees, etc)
>>
>> I have found documentation on how to clone from each of them, but I
>> haven't found any simple documentation on how to work with both of them.
>
> After cloning from one:
> git remote add remotename git://...
> git fetch remotename
>
> You will now have the other repository fetched into your local
> repository; tags from both will be replicated to your local tags.

thanks, given the nature of git I figured it was something really simple, 
but I just wasn't able to find it.

I've forwarded this to the kernel.org webmaster to update the 'how to 
follow linux development' page

David Lang
