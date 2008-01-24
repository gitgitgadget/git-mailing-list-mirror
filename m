From: JM Ibanez <jm@orangeandbronze.com>
Subject: Re: Stripping 'git-svn-id' from commit messages, and switching to svn.noMetadata
Date: Thu, 24 Jan 2008 16:44:41 +0800
Organization: Orange & Bronze Software Labs, Ltd. Co.
Message-ID: <87wspzobnq.fsf@adler.orangeandbronze.com>
References: <877ii0p89b.fsf@adler.orangeandbronze.com>
	<4797D6C6.207@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Jan 24 09:45:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHxiC-00073B-1T
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 09:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875AbYAXIo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 03:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752454AbYAXIo6
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 03:44:58 -0500
Received: from nz-out-0506.google.com ([64.233.162.233]:48066 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663AbYAXIo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 03:44:57 -0500
Received: by nz-out-0506.google.com with SMTP id s18so108464nze.1
        for <git@vger.kernel.org>; Thu, 24 Jan 2008 00:44:54 -0800 (PST)
Received: by 10.142.99.21 with SMTP id w21mr133947wfb.55.1201164293686;
        Thu, 24 Jan 2008 00:44:53 -0800 (PST)
Received: from adler.orangeandbronze.com ( [61.28.150.66])
        by mx.google.com with ESMTPS id i15sm903420wxd.17.2008.01.24.00.44.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Jan 2008 00:44:53 -0800 (PST)
Jabber-ID: jmibanez@gmail.com
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAMFBMVEUBAQEPDw8aGhoiIiIy
 MjJGRkZaWlp0dHScnJy+vr7R0dHb29vn5+fx8fH29vb///+JzcfYAAAAAWJLR0QAiAUdSAAAAAlw
 SFlzAAAewgAAHsIBbtB1PgAAAi5JREFUOMul1E9o01AYAPAvUQ87JV+3gcemrYi32q7oQRC7gtWD
 OLs6jx5svQhDCk0GggeHTaWgt/ZF5gRlkHZePCg0lTE8SWvnUXHU3QRxyYYryrCpr4PlT81OeyE5
 fD/y5b0v73vQP2DA4aBcWvMEQjJvPKAiF66nhSsrw9CNFnOIo3PyMKRj6cmoEJt/sOiGrhBHFpnx
 qdScG64FAODEWCJ9ddoFOyhQGJ3wx6eCj51wOoDAABNmghHfrAP+BC4gD8AzvI8Nn3HAr0xUQJoL
 WIbng+dtmB58AXiajd7MfQu6ftgfNCFrvbENdpwC4j5sWXFm73HMSrVqxfdmMG7Be2BxIpGYDIIw
 mPSYPSuYEUVRKmTjg2ViyIYtpSITeuUEnkdfzFGSWr1aJwoppwLI+C46QFWVOlluatrbCJ5MOqCp
 1bTyrUsfO8bn1MK3NRt8Txsv8Wi+pOumpLUcAMebD7NK651h/LintlZsyEaUQkjStI7595XaWrQg
 BDhyF2Ck1NNN42tz1gIBjswMinGj0zfM9RZn/yiAyzcp3NH7Rr/93YZtZM69pmV6plMxNhzrSLEL
 XxCZtkHjq5wDfkvt9Rd4qm2YfZNzbp/eB13/ebth0Ew9N6ib+uYSrYhufnJv0eTyUvpRodrobHBu
 2CGiRHJniw0YboOKmE1hUnzODcNuRVJIPgP/txohspoPcx49SHfDPOfRnLtyUfZ79nmt+oTzhCKB
 A04GONwh8w9J0EXBeLkUcQAAAABJRU5ErkJggg==
In-Reply-To: <4797D6C6.207@vilain.net> (Sam Vilain's message of "Thu\, 24 Jan 2008 13\:07\:34 +1300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71607>

Sam Vilain <sam@vilain.net> writes:

> JM Ibanez wrote:
>> Hi,
>> 
>> I've been trying to convert an existing git-svn clone to noMetadata
>> (i.e. get rid of git-svn-id in the commit messages), primarily because
>> I've been using it to track two SVN repos which were originally just a
>> single repo-- they have the same UUID but are located on different
>> machines, and have branched significantly, so content-wise are no longer
>> the same repo.
>> 
>> Because the two repos have a single line of commits which they share, it
>> would be best if I could store that history in my git repo (as I need to
>> use it for merging between the two trees). Graphically, my current
>> history looks something like this:
>> 
>> 
>>     A -- B -- C -- D -- E -- a -- b -- c
>> 
>>     A'-- B'-- C'-- D'-- E'-- x -- y -- z
>> 
>> where, in reality, this should be represented as:
>> 
>>     A -- B -- C -- D -- E -- a -- b -- c
>>                          \
>>                           +- x -- y -- z
>
> Stop.
>
> Use a graft.  in .git/info/grafts, put (expanding to the full SHA1s):

Actually, I forgot to mention that I already have grafts between the two
to track merges I performed previously. So, in fact, the history looks
like something this:

     A -- B -- C -- D -- E -- a -- b -- c -- d -- e -- f -- m3
                         \         \          \             /
                          \         \          \   /-------+
     A'-- B'-- C'-- D'-- E'-- x -- y -- m1-- z -- m2


where x, m1, m2, and m3 are squashed merge commits + grafts.

After git filter-branch with a graft of x to E, I get x having two
parents as what is needed *but* because the parent IDs are part of the
commit object, I now get x' y', etc, something like this:



     A -- B -- C -- D -- E -- a -- b -- c -- ...
                         |         |
                         |         |
                         |         +--- m1'- z'-- m2' -- ...
                         \         \
                          \         \
                           -- x -- y -- m1-- z -- ...


sort of. In any case, I get duplicate commits of m1, z, etc. after the
primary graft point. Is this expected?

-- 
JM Ibanez
Software Architect
Orange & Bronze Software Labs, Ltd. Co.

jm@orangeandbronze.com
http://software.orangeandbronze.com/
