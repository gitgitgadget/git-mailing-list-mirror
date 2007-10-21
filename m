From: david@lang.hm
Subject: Re: .gittattributes handling has deficiencies
Date: Sun, 21 Oct 2007 10:09:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0710211007430.4818@asgard>
References: <1192956535617-git-send-email-prohaska@zib.de>
 <Pine.LNX.4.64.0710210204580.4818@asgard> <B61AE1A9-E983-4ACE-BF71-8FDC113A4F34@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Oct 21 19:04:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjeE2-0006WW-UA
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 19:04:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbXJUREF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 13:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751607AbXJUREE
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 13:04:04 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:57457
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbXJURED (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 13:04:03 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l9LH40gF032444;
	Sun, 21 Oct 2007 10:04:01 -0700
X-X-Sender: dlang@asgard
In-Reply-To: <B61AE1A9-E983-4ACE-BF71-8FDC113A4F34@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61904>

On Sun, 21 Oct 2007, Steffen Prohaska wrote:

> On Oct 21, 2007, at 11:19 AM, david@lang.hm wrote:
>
>>> But this is really hard to solve. We would need to compare
>>> attributes before and after for _all_ files that have attributes
>>> in one of the two commits and check if they changed. If so, we
>>> need to do a fresh checkout according to the new attributes.
>> 
>> if you know that you will get the new .gitattributes if it changes, setup a 
>> post-checkout hook to checkout everything if it has changed. it's far from 
>> ideal, but it should be a good, safe, first approximation.
>
>
> That's not good enough. I'll stop using .gitattributes. I
> need to teach >40 devs how to use git on Windows. I only use
> features that work flawlessly. .gitattributes doesn't. It bit
> me twice now.

why would checking everything out if .gitattributes has changed not work? 
I can see why _not_ doing so would cause problems, and I freely 
acknowledge that this approach imposes a performance hit by checking 
everything out twice, but I don't see how it would not be reliable.

David Lang

> Luckily, core.autocrlf works if you set it before the first
> checkout and never change it. This seems sufficient for me if
> all files that have mixed line endings are fixed right away.
>
> 	Steffen
