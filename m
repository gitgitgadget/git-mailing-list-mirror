From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Moved files and merges
Date: Mon, 05 Sep 2005 11:43:00 -0700
Message-ID: <431C91B4.6040609@zytor.com>
References: <4318E754.9000703@zytor.com>	<7vek87djat.fsf@assigned-by-dhcp.cox.net>	<7vek867e29.fsf@assigned-by-dhcp.cox.net>	<7vy86erntu.fsf@assigned-by-dhcp.cox.net>	<20050903190500.GB8379@mars.ravnborg.org>	<7voe7arlqk.fsf@assigned-by-dhcp.cox.net>	<20050903220355.GA1895@mars.ravnborg.org>	<7v64thl248.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.63.0509041329340.23242@iabervon.org>	<7vvf1gejjf.fsf@assigned-by-dhcp.cox.net> <431C6167.4070703@zytor.com> <7v4q8z5pqv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 20:45:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECLwc-0007g2-2H
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 20:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbVIESn2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 14:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbVIESn1
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 14:43:27 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:5018 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S932399AbVIESn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2005 14:43:26 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j85Ih0Jv032067
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 5 Sep 2005 11:43:01 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q8z5pqv.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8109>

Junio C Hamano wrote:
> 
> But previous argument by Linus made in a distant (in git
> timescale) past is now ingrained in my brain: "the additional
> metadata" recorded at the commit time can only help us what we
> envisioned in the past when the tool to record that metadata was
> written.  If we try to "track" by contents, we can do at least
> the same (diff -M being able to tell renames is an example that
> we can get away without having a UUID) and possibly better,
> depending on how much effort we are willing to spend "drilling
> down" when we actually need to know what happened at merge
> time.  What I found most important in that argument by Linus is
> that the "drilling down" algorithm can improve over time while
> "the additional metadata" specification is cast in stone when a
> commit is made.
> 

... unless the "additional metadata" is merely a cache, derived from the 
contents.  The advantage, of course, is that you can produce data that 
is more expensive that way.  On the other hand, if you don't need it, 
it's pointless.

	-hpa
