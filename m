From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: Build fixes for another obscure Unix
Date: Fri, 14 Dec 2012 08:54:40 +0100
Message-ID: <kaem06$3go$1@ger.gmane.org>
References: <CAEvUa7nn9M5np3wD=Z1152K4pwNGhSKkC=rS9U=yc=UcaOxMCw@mail.gmail.com><871B6C10EBEFE342A772D1159D13208539FF9088@umechphg.easf.csd.disa.mil> <CAEvUa7nNNYREAsxc==tfg+e1XNZFbDVOpGXE6z-7+SfbqNrp6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 08:55:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjQ7F-0008J3-RK
	for gcvg-git-2@plane.gmane.org; Fri, 14 Dec 2012 08:55:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754007Ab2LNHzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2012 02:55:10 -0500
Received: from plane.gmane.org ([80.91.229.3]:37437 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753491Ab2LNHzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2012 02:55:09 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TjQ74-000895-Lx
	for git@vger.kernel.org; Fri, 14 Dec 2012 08:55:18 +0100
Received: from dsdf-4db522c0.pool.mediaways.net ([77.181.34.192])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Dec 2012 08:55:18 +0100
Received: from jojo by dsdf-4db522c0.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Dec 2012 08:55:18 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4db522c0.pool.mediaways.net
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211488>

David Michael wrote:
> Hi,
>
> On Thu, Dec 13, 2012 at 12:18 PM, Pyeron, Jason J CTR (US)
> <jason.j.pyeron.ctr@mail.mil> wrote:
>>> Would there be any interest in applying such individual
>>> compatibility fixes for this system, even if a full port doesn't
>>> reach completion?
>>
>> What are the down sides? Can your changes be shown to not impact
>> builds on other systems?
>
> I've pushed a handful of small compatibility patches to GitHub[1]
> which are enough to successfully compile the project.  The default
> values of the new variables should make them unnoticeable to other
> systems.
>
> Are there any concerns with this type of change?  If they would be
> acceptable, I can try sending the first four of those patches to the
> list properly.  (I expect the last two may be tweaked as I continue
> working with the port.)
>
> I do have a concern with strings.h, though.  That file will be
> included for most people who run ./configure, when it wasn't before.
> Do you think it's worth making a more detailed test to see if
> strcasecmp is still undefined after string.h is included, rather than
> just testing for the header's existence?
>
> Thanks.
>
> David
>
> [1] https://github.com/dm0-/git/commits

For what's it worth: I ACK your HP-NonStop patch (as you can see by my 
comment in git-compat-util.h I was thinking along the same line)
https://github.com/dm0-/git/commit/933d72a5cfdc63fa9c3c68afa2f4899d9c3f791e
together with its prerequisit
https://github.com/dm0-/git/commit/301032c6488aeabb94ccc81bfb6d65ff2c23b924

ACKed by: Joachim Schmitz <jojo@schmitz-digital.de> 
