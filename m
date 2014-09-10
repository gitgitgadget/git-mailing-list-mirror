From: Gerry Reno <greno@verizon.net>
Subject: Re: git 2.1.0: make fails
Date: Wed, 10 Sep 2014 08:39:41 -0400
Message-ID: <5410468D.7000204@verizon.net>
References: <540F643A.60207@verizon.net> <20140909224201.GE14029@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 10 15:40:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRi80-0008RE-46
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 15:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbaIJNkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 09:40:01 -0400
Received: from vms173019pub.verizon.net ([206.46.173.19]:11343 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970AbaIJNkA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 09:40:00 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Sep 2014 09:40:00 EDT
Received: from renog13-lin01.localdomain ([unknown] [71.122.175.81])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0NBO0032LR65EA50@vms173019.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 10 Sep 2014 07:39:41 -0500 (CDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625
 Thunderbird/17.0.7
In-reply-to: <20140909224201.GE14029@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256738>

On 09/09/2014 06:42 PM, Jeff King wrote:
> On Tue, Sep 09, 2014 at 04:34:02PM -0400, Gerry Reno wrote:
>
>> Downloaded the git-2.1.0.tar.gz  tarball.
>>
>> Cannot build git 2.1.0:
> Weird. It works fine for me on Debian unstable. What platform are you on?
>
>>     cc  -g -O2 -Wall -I. -DHAVE_ALLOCA_H  -DHAVE_PATHS_H -DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME
>>     -DSHA1_HEADER='<openssl/sha.h>'  -DNO_STRLCPY -DNO_MKSTEMPS -DSHELL_PATH='"/bin/sh"' -o git-credential-store  
>>     credential-store.o libgit.a xdiff/lib.a  -lz  -lcrypto -lpthread -lrt
>>     collect2: ld returned 1 exit status
>>     make: *** [git-credential-store] Error 1
> So the linker failed, but it didn't actually tell us why. That's not
> much to go on. Are you sure there was no other output on stderr?
>
> I assume the reason it broke on git-credential-store is just because it
> is the first thing we try to link. What does:
>
>   make V=1 prefix=/usr/local git
>
> output? Does it successfully link "git"?
>
> -Peff
>

I downloaded git-2.0.4.tar.gz and it builds and links fine.

I wiped out the 2.1.0 installation so cannot test anything more.
