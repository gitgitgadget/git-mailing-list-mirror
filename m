From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [ANNOUNCE] GIT 1.5.3
Date: Mon, 03 Sep 2007 08:46:51 +0100
Message-ID: <46DBBBEB.6010701@zytor.com>
References: <7vodglr32i.fsf@gitster.siamese.dyndns.org>	<46DA5F33.2020005@zytor.com>	<85odgltrtj.fsf@lola.goethe.zz>	<46DA88EF.7080103@zytor.com> <20070902133803.1b46f599.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Mon Sep 03 09:48:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS6fB-0002XR-1W
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 09:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287AbXICHrb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 03:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752076AbXICHrb
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 03:47:31 -0400
Received: from terminus.zytor.com ([198.137.202.10]:32879 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbXICHra (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 03:47:30 -0400
Received: from titan.hos.anvin.org ([217.206.93.210])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.8) with ESMTP id l837lJMJ005652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 3 Sep 2007 00:47:22 -0700
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <20070902133803.1b46f599.seanlkml@sympatico.ca>
X-Virus-Scanned: ClamAV 0.88.7/4134/Sun Sep  2 22:21:40 2007 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57434>

Sean wrote:
> On Sun, 02 Sep 2007 10:57:03 +0100
> "H. Peter Anvin" <hpa@zytor.com> wrote:
> 
>>  From the looks of it, there is still a git-p4, it just moved to contrib 
>> and uses fast-import, so removing its rpm package was probably broken in 
>> the first place.
> 
> Hi Peter,
> 
> Items in contrib aren't officially supported, so it doesn't sound like
> a good idea to offer installs for them.  Of course, it might be a good
> idea to promote git-p4 up out of contrib and add it to the spec file.

Well, the old one was out of contrib, too.  Maybe it should never have 
been packaged up, but it was...

> As things stand now, do you get an error when trying to upgrade Git via
> yum?   I'd have thought things would upgrade fine but leave the old git-p4
> rpm hanging around.  Either way, the obsoletes line mentioned by David
> sounds like the right solution.

Yes, it gets an error, because all the git RPMs are tied together by 
explicit version number and so can only be upgraded as a group.

> As an aside, when I sent the patch removing git-p4import from the spec
> file I mentioned that I had no way to test it and asked for testers.
> Git needs a spec file maintainer so that issues like this can be caught
> before release.  Without a maintainer, it should probably be demoted
> to contrib itself.

Well, git on kernel.org (and many other places) critically depends on 
rpms being available.

	-hpa
