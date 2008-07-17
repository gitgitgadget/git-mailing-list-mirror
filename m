From: Eric Blake <ebb9@byu.net>
Subject: Re: [PATCH] gitk - work around stderr redirection on Cygwin
Date: Wed, 16 Jul 2008 21:55:39 -0600
Message-ID: <487EC2BB.5050503@byu.net>
References: <1213462668-424-1-git-send-email-mlevedahl@gmail.com> <487A6780.7030500@gmail.com> <7vfxqdqxh7.fsf@gitster.siamese.dyndns.org> <487A7949.9050800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, paulus@samba.org,
	git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 06:02:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJKgu-0002M6-Pz
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 06:02:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbYGQEBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 00:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbYGQEBE
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 00:01:04 -0400
Received: from qmta10.westchester.pa.mail.comcast.net ([76.96.62.17]:54520
	"EHLO QMTA10.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750749AbYGQEBD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jul 2008 00:01:03 -0400
X-Greylist: delayed 331 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Jul 2008 00:01:03 EDT
Received: from OMTA01.westchester.pa.mail.comcast.net ([76.96.62.11])
	by QMTA10.westchester.pa.mail.comcast.net with comcast
	id qoe41Z00J0EZKEL5ArvCl9; Thu, 17 Jul 2008 03:55:12 +0000
Received: from [192.168.0.101] ([67.166.125.73])
	by OMTA01.westchester.pa.mail.comcast.net with comcast
	id qrvV1Z0051b8C2B3MrvW6f; Thu, 17 Jul 2008 03:55:30 +0000
X-Authority-Analysis: v=1.0 c=1 a=UWQKEY4vnqcA:10 a=VBO98226iYoA:10
 a=LYtJsjGHvCJbuDAVTooA:9 a=y1y7SWNqdzh__eUe2NUA:9
 a=GuAOy6ycRwfEJROfgteorTPhdBQA:4 a=eDFNAWYWrCwA:10 a=oLyKKK6XQo0A:10
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <487A7949.9050800@gmail.com>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88802>

According to Mark Levedahl on 7/13/2008 3:53 PM:
>>>    
>>>> Cygwin is *still* shipping with antiquated Tcl 8.4.1
>>>>       
>>> Ping. This bug is in 1.5.6.x, and thus also in the current Cygwin git
>>> release: as a result, several gitk context menu items cause
>>> errors. (Let me know if I should resend the patch).

> I certainly have this patch in my tree so the folks I supply git to who 
> use Cygwin have this patch. The question of whether to maintain this out 
> of tree for the official Cygwin release is up to Eric.

Could you point me to the patch?  I need to roll the Cygwin git release of
1.5.6.3 anyway (in part because cygwin has upgraded from perl 5.8 to
5.10).  This sounds like something worth me including as a vendor patch,
if it does not get folded into the main repo.

-- 
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
