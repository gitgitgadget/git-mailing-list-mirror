From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/5] autoconf: Add -liconv to LIBS when NEEDS_LIBICONV
Date: Tue, 05 Sep 2006 14:27:26 -0700
Message-ID: <7vu03mats1.fsf@assigned-by-dhcp.cox.net>
References: <200609050054.24279.jnareb@gmail.com>
	<200609050055.52980.jnareb@gmail.com> <20060905162526.GA5547@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 05 23:27:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKiSI-0002R5-4Y
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 23:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWIEV1Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 17:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWIEV1P
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 17:27:15 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:24026 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751397AbWIEV0y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Sep 2006 17:26:54 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060905212653.GPQD27846.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Tue, 5 Sep 2006 17:26:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id JlSu1V0031kojtg0000000
	Tue, 05 Sep 2006 17:26:54 -0400
To: Jonas Fonseca <fonseca@diku.dk>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26488>

Jonas Fonseca <fonseca@diku.dk> writes:

> Jakub Narebski <jnareb@gmail.com> wrote Tue, Sep 05, 2006:
>> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
>> ---
>> Just in case; it could matter for testing if iconv is properly
>> supported (NO_ICONV test).
>> 
>>  configure.ac |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>> 
>> diff --git a/configure.ac b/configure.ac
>> index 36f9cd9..fc5b813 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -147,6 +147,7 @@ AC_CHECK_LIB([c], [iconv],
>>  [NEEDS_LIBICONV=],
>>  [NEEDS_LIBICONV=YesPlease])
>>  AC_SUBST(NEEDS_LIBICONV)
>> +test -n "$NEEDS_SOCKET" && LIBS="$LIBS -liconv"
>
> I see that this has entered already, but it looks like it needs a
> s/NEEDS_SOCKET/NEEDS_LIBICONV/

Eek, eye-ballo-o.  Thanks for noticing.
