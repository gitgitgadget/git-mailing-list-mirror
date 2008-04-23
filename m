From: Fedor Sergeev <Fedor.Sergeev@Sun.COM>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 23 Apr 2008 11:47:57 +0400 (Russian Standard Time)
Message-ID: <alpine.WNT.1.10.0804231124270.2728@theodor>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <200804221655.11914.Josef.Weidendorfer@gmx.de>
 <46dff0320804221013m2ff0320am31b7f8beb5f26f1b@mail.gmail.com>
 <200804222007.03439.Josef.Weidendorfer@gmx.de>
 <46dff0320804221859x7641144fua34df89fcc686aa2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 09:50:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoZk2-0005RP-5o
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 09:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbYDWHtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 03:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbYDWHtX
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 03:49:23 -0400
Received: from brmea-mail-1.Sun.COM ([192.18.98.31]:36080 "EHLO
	brmea-mail-1.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbYDWHtW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 03:49:22 -0400
Received: from fe-amer-09.sun.com ([192.18.109.79])
	by brmea-mail-1.sun.com (8.13.6+Sun/8.12.9) with ESMTP id m3N7nLxK026791
	for <git@vger.kernel.org>; Wed, 23 Apr 2008 07:49:21 GMT
Received: from conversion-daemon.mail-amer.sun.com by mail-amer.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0JZR00L01PKFEK00@mail-amer.sun.com>
 (original mail from Fedor.Sergeev@Sun.COM) for git@vger.kernel.org; Wed,
 23 Apr 2008 01:49:21 -0600 (MDT)
Received: from localhost ([92.255.85.22])
 by mail-amer.sun.com (Sun Java System Messaging Server 6.2-8.04 (built Feb 28
 2007)) with ESMTPSA id <0JZR00E8IPPX84D0@mail-amer.sun.com>; Wed,
 23 Apr 2008 01:49:21 -0600 (MDT)
In-reply-to: <46dff0320804221859x7641144fua34df89fcc686aa2@mail.gmail.com>
X-X-Sender: fs77888@mail-amer.sun.com
User-Agent: Alpine 1.10 (WNT 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80195>

On Wed, 23 Apr 2008, Ping Yin wrote:
> On Wed, Apr 23, 2008 at 2:07 AM, Josef Weidendorfer
>>  Hmm... At least, it can be very annoying when git fetches data from repositories
>>  you did not expect, only because submodule URLs change via this
>>  fallback mechanism. Perhaps it is a little far reached, but suppose a project
>>  changes its URL, and the old one becomes occupied by a malicious person.
>>  The problem is that the URL with the now malicious repository is bound in the
>>  history of the project.
>
> It is always bound now without the fallback patch :)
>
>>  For sure, you do not want to fetch from that old repository
>>  by accident, after you did a checkout of an old commit. And there would be no
>>  way to protect other people from this malicious repository other than rewriting
>>  the whole history.
>
> I wonder how the *malicious* repository can hurt us since only the
> commit recorded in commit of the super project will be checked out.

If one manages to hack on repository one can modify it enormous amount of 
ways, including spoofing on SHA (providing wrong contents for it - does 
git verify that when getting a pack?), utilizing bugs in git etc...

I doubt somebody would spend that much of an effort but you know,
you can not be paranoid *enough* :)

regards,
   Fedor.
