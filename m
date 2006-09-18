From: Timothy Shimmin <tes@sgi.com>
Subject: Re: git pull a subtree, embedded trees
Date: Mon, 18 Sep 2006 15:57:12 +1000
Message-ID: <450E3538.4010209@sgi.com>
References: <4508020F.2050604@sgi.com> <20060913150028.GB29608@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 18 07:56:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPC7Z-0007vr-Dd
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 07:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965437AbWIRF4j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 01:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965438AbWIRF4i
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 01:56:38 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:167 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965437AbWIRF4i (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Sep 2006 01:56:38 -0400
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with SMTP id k8I8W9Xx021060;
	Mon, 18 Sep 2006 01:32:11 -0700
Received: from [134.14.55.141] (boing.melbourne.sgi.com [134.14.55.141]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id PAA04844; Mon, 18 Sep 2006 15:56:30 +1000
User-Agent: Thunderbird 1.5.0.7 (Macintosh/20060909)
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060913150028.GB29608@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27229>

Hi Shawn,

Shawn Pearce wrote:
> Tim Shimmin <tes@sgi.com> wrote:
>> I've written a simple small program to dump out the index
>> entries (cache entries).
> 
> `git-ls-files --stage` also dumps a number of those details, though
> it doesn't dump every available field.
> 
Thanks, that's handy.
However, when going through the core-tutorial (copying repository section)
and populating the index from the .git objects using git-read-tree,
it was nice to see all the stat fields using my program.
These fields were empty at that stage, of course, (it was nice to see it)
until I had populated the workarea using git-checkout-index.
But generally, git-ls-files --stage would be fine.

>> I just want to see what is exactly stored in the .git
>> binary files and how they change when I do various git
>> operations.
> 
> You may want to review some of the material in
> Documentation/core-tutorial.txt and Documentation/technical.
> These documents try to describe some of the formats but reviewing
> them now it looks like there's still some additional information
> that could be written down.
> 
Thanks. I've been going through the core-tutorial.
It's great.

Cheers,
Tim.
