From: Andreas Ericsson <ae@op5.se>
Subject: Re: GIT and SCC
Date: Mon, 17 Nov 2008 08:05:16 +0100
Message-ID: <492117AC.6070200@op5.se>
References: <1225909527.8578.10.camel@terrenisrv1.terrenis.net> <20081105182506.GO15463@spearce.org> <e2b179460811051111y2d6e4c5eq19c8b58b93f942a9@mail.gmail.com> <1225913035.8578.18.camel@terrenisrv1.terrenis.net> <20081105193824.GA9266@mit.edu> <20081116215134.GA4719@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Theodore Tso <tytso@mit.edu>, Martin Terreni <martin@terrenis.net>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Nov 17 08:06:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1yC2-0004Tn-2g
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 08:06:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbYKQHF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 02:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbYKQHF0
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 02:05:26 -0500
Received: from mail.op5.se ([193.201.96.20]:49249 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751404AbYKQHFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 02:05:25 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 466721B80340;
	Mon, 17 Nov 2008 08:00:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YSjaTO3-dPmn; Mon, 17 Nov 2008 08:00:05 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.22])
	by mail.op5.se (Postfix) with ESMTP id 70DDE1B80050;
	Mon, 17 Nov 2008 08:00:04 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081116215134.GA4719@efreet.light.src>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101196>

Jan Hudec wrote:
> On Wed, Nov 05, 2008 at 14:38:25 -0500, Theodore Tso wrote:
>> On Wed, Nov 05, 2008 at 09:23:55PM +0200, Martin Terreni wrote:
>>> http://en.wikipedia.org/wiki/SCC_compliant
>>>
>>> It is probably not much, but this is what I could find in a minute. many
>>> VC system have a SCC complaint API (apart of the native). This protocol
>>> was created by M$ is used by many systems so they are not bound to a
>>> specific VC tool.
>> It's a closed-source, undocumented API that you can only get access to
>> by signing a Microsoft NDA.   From the WinMerge API:
>>
>> 	SCC API is closed API (no public documentation available) some
>> 	IDE's (e.g. Visual Studio) use. There apparently have couple
>> 	of reverse-engineered free implementations for SCC API. Status
>> 	of those are unknown.
>>
>> 	WARNING: Be very sure you are not submitting any code behing
>> 	NDA for WinMerge. WinMerge is Open Source so it is not legal
>> 	to do. And what is worse it would prevent anybody reading that
>> 	code working with SCC (and perhaps also VCS) support.
>>
> 
> I don't really know what this interface is about, but:
>  - For VS6 and newer, source control plugin can be implemented by creating
>    a dll exporting particular set of controls. This is documented in help
>    files that come with VS2005 SDK which is freely downloadable from M$ web,
>    so I don't think that would be under NDA.
>  - For VS2003 and newer (ie. the .NET based versions), plugins can be
>    implemented for almost anything, including source control, by creating
>    .net assembly exporting classes that implement some particular interfaces.
>    These interfaces are documented in the abovementioned SDK, so again no NDA
>    needed.
> I actually started writing such plugin some months back, but since I can only
> work on it at $work (don't have Windooze at ~, not to mention VS2005 license
> -- the SDK is free to download, but requires full, non-express, studio) and
> since it does not look like I could get them use Git at $work anytime soon,
> I didn't work on it too much. Still I could share the basic skeleton and
> the knowledge I have if somebody wanted to move that somewhere.
> 

I'm interested. Please email me off-list. I'll pass it on to the monodevelop
people and  see what happens. Hopefully they can reuse the same interface so
that mono plugins all of a sudden work everywhere.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
