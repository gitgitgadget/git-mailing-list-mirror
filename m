From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: What's in git.git (Sep 2008, #01; Sat, 06)
Date: Sun, 7 Sep 2008 11:45:20 -0600
Message-ID: <alpine.LNX.1.10.0809071139060.6003@suse104.zenez.com>
References: <7vtzcso58c.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.10.0809070812350.6003@suse104.zenez.com> <7v3akbopzb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 07 19:46:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcOLG-00088p-A1
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 19:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754281AbYIGRpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 13:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754236AbYIGRpX
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 13:45:23 -0400
Received: from suse104.zenez.com ([198.60.105.164]:20202 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003AbYIGRpX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 13:45:23 -0400
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id 3F0A7A7C24C; Sun,  7 Sep 2008 11:45:20 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id 8774EA7C249;
	Sun,  7 Sep 2008 11:45:20 -0600 (MDT)
In-Reply-To: <7v3akbopzb.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95158>

On Sun, 7 Sep 2008, Junio C Hamano wrote:
> Boyd Lynn Gerber <gerberb@zenez.com> writes:
>> On Sat, 6 Sep 2008, Junio C Hamano wrote:
>>> Quite a many minor fixes appeared on 'maint'.  1.6.0.2 needs to happen
>>> soon.  Any favorite fixes (not feature enhancements) not on the list here?
>>
>> I would really like to see this graduate to master before 1.6.0.2
>>
>> * jc/setlinebuf-setvbuf (Wed Sep 3 20:33:29 2008 -0700) 1 commit
>>  + daemon.c: avoid setlinebuf()
>
> I do not think the setlinebuf() change affected 'maint' to begin with; it
> was part of the series to clean-up daemon and to make maximum simultanous
> number of connections configurable.  Are you having trouble building and/
> or running 1.6.0.1 on your box?

No, it does not work.  I have the git-shell problems, that I reported 
earlier with all the missing/undefined symbols.  Same problems with 1.6.0 
release.  That is why I was hoping to have a master that would be released 
that is clean and able to build.  I am currently running on all my systems 
the master with this commit.  It is the only way for me to run any git 
1.6.x.x on any of the 12 platforms.  I have been getting master and then 
adding this to compile.  I have it running on 4 platforms daily doing an 
pull and rebuilding git.  I have testing now working on 2 platforms on 
next.

Thanks,

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
