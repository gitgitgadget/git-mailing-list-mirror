From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: What's in git.git (Sep 2008, #01; Sat, 06)
Date: Sun, 7 Sep 2008 17:25:00 -0600
Message-ID: <alpine.LNX.1.10.0809071723090.25543@suse104.zenez.com>
References: <7vtzcso58c.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.10.0809070812350.6003@suse104.zenez.com> <7v3akbopzb.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.10.0809071139060.6003@suse104.zenez.com> <7vd4jfn5hx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 01:26:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcTe7-0005rc-5q
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 01:26:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbYIGXZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 19:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbYIGXZE
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 19:25:04 -0400
Received: from suse104.zenez.com ([198.60.105.164]:12087 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbYIGXZC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 19:25:02 -0400
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id D7279A7C291; Sun,  7 Sep 2008 17:25:00 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id CB914A7C28E;
	Sun,  7 Sep 2008 17:25:00 -0600 (MDT)
In-Reply-To: <7vd4jfn5hx.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95191>

On Sun, 7 Sep 2008, Junio C Hamano wrote:
> Boyd Lynn Gerber <gerberb@zenez.com> writes:
>> On Sun, 7 Sep 2008, Junio C Hamano wrote:
>>> Boyd Lynn Gerber <gerberb@zenez.com> writes:
>>>> On Sat, 6 Sep 2008, Junio C Hamano wrote:
>>>>> Quite a many minor fixes appeared on 'maint'.  1.6.0.2 needs to happen
>>>>> soon.  Any favorite fixes (not feature enhancements) not on the list here?
>>>>
>>>> I would really like to see this graduate to master before 1.6.0.2
>>>>
>>>> * jc/setlinebuf-setvbuf (Wed Sep 3 20:33:29 2008 -0700) 1 commit
>>>>  + daemon.c: avoid setlinebuf()
>>>
>>> I do not think the setlinebuf() change affected 'maint' to begin with; it
>>> was part of the series to clean-up daemon and to make maximum simultanous
>>> number of connections configurable.  Are you having trouble building and/
>>> or running 1.6.0.1 on your box?
>>
>> No, it does not work.  I have the git-shell problems,...
>
> Then it does not have anything to do with the setlinebuf-setvbuf topic at
> all, does it?
>
> I think we already have 6ffaecc (shell: do not play duplicated definition
> games to shrink the executable, 2008-08-19), which was cherry-picked from
> 4cfc24a (shell: do not play duplicated definition games to shrink the
> executable, 2008-08-19) on 'master'.  Do you still have problem building
> 'maint' on your boxes?

No, maint does build.  I just thought your were going to release 1.6.0.2 
from master.  I think the next commit for set-linebug-setvbug needs to be 
in it for release.

Thanks,

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
