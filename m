From: david@lang.hm
Subject: Re: On Tabs and Spaces
Date: Wed, 17 Oct 2007 20:03:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0710172002020.10276@asgard.lang.hm>
References: <3awb7zw6.fsf@blue.sea.net> <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
 <1192565900.6430.16.camel@athena> <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org>
 <20071017015109.303760cc@localhost.localdomain>
 <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org>
 <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com>
 <alpine.LFD.0.999.0710170849590.26902@woody.linux-foundation.org>
 <20071018003256.GA5062@coredump.intra.peff.net>
 <alpine.LFD.0.999.0710171753020.26902@woody.linux-foundation.org>
 <20071018024553.GA5186@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Luke Lu <git@vicaya.com>,
	Christer Weinigel <christer@weinigel.se>,
	Tom Tobin <korpios@korpios.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 18 04:59:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiLbl-0002TQ-1J
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 04:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760052AbXJRC7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 22:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760248AbXJRC7Z
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 22:59:25 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:51717
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760052AbXJRC7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 22:59:24 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l9I2x3C3017495;
	Wed, 17 Oct 2007 19:59:03 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20071018024553.GA5186@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61453>

On Wed, 17 Oct 2007, Jeff King wrote:

> On Wed, Oct 17, 2007 at 05:59:27PM -0700, Linus Torvalds wrote:
>
>> It happens. We do de-spacification in the kernel occasionally when it is
>> an annoyance. Usually it shows up in patches, though - exactly because
>> code which adds spaces instead of tabs won't line up correctly in the
>> diff.
>
> You have made this claim several times, and I really don't understand
> it. If I have 8 spaces, then a diff line will have either " ", "+", or
> "-" followed by 8 spaces. If I use a hard tab, then the tab will end up
> only taking up 7 spaces because of the nature of tabs.
>
> This might matter if I'm comparing non-diff code to diff code. But in a
> diff, _everything_ is indented by exactly one space, so it all lines up.
> Is there something I'm missing?

if the code uses a tab and the patch uses 8 spaces the two will not line 
up in the diff becouse in the diff output the tab is 'only 7 spaces;

useing one or the other isn't the problem, it's the mixing of the two.

David Lang
