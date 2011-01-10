From: John Wyzer <john.wyzer@gmx.de>
Subject: Re: Resumable clone/Gittorrent (again) - stable packs?
Date: Mon, 10 Jan 2011 17:39:31 +0100
Message-ID: <4D2B3643.2070106@gmx.de>
References: <AANLkTikv+L5Da7A5VM7BAgnue=m0O_-nHmHchJzfGxJa@mail.gmail.com> <AANLkTinc12H01Us1mkKieZo75hwjgTCZth_wFvRNscMq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 10 17:40:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcKms-0007FV-8s
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 17:40:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426Ab1AJQj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jan 2011 11:39:59 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:35288 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752096Ab1AJQj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jan 2011 11:39:58 -0500
Received: (qmail invoked by alias); 10 Jan 2011 16:39:56 -0000
Received: from 200.106.113.82.net.de.o2.com (EHLO [10.75.15.25]) [82.113.106.200]
  by mail.gmx.net (mp035) with SMTP; 10 Jan 2011 17:39:56 +0100
X-Authenticated: #53368487
X-Provags-ID: V01U2FsdGVkX19pAe5R6yZpfSDu7ElYYG2D66c11zJrYPvUlGHoCp
	xYAz0Yt4tn7Zlp
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1b3pre) Gecko/20081207 Mnenhy/0.7.6.0
In-Reply-To: <AANLkTinc12H01Us1mkKieZo75hwjgTCZth_wFvRNscMq@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164878>

On 06/01/11 18:05, Shawn Pearce wrote:
> On Wed, Jan 5, 2011 at 18:29, Zenaan Harkness<zen@freedbms.net>  wrote:
>> Bittorrent requires some stability around torrent files.
>>
>> Can packs be generated deterministically?
>

I hope that I don't get something technically wrong (did not read any 
code, only skimmed the docs) and that this question is not redundant:

Why not provide an alternative mode for the git:// protocoll that 
instead of retrieving a big packaged blob breaks this down to the 
smallest atomic objects from the repository? Those are not changing and 
should be able to survive partial transfers.
While this might not be as efficient network traffic-wise it would 
provide a solution for those behind breaking connections.
