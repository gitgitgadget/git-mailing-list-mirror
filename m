From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: git-1.6.2-rc2 problems on t4034-diff-words.sh
Date: Fri, 27 Feb 2009 13:49:10 -0700
Message-ID: <alpine.LNX.2.00.0902271348360.19082@suse104.zenez.com>
References: <alpine.LNX.2.00.0902271103450.19082@suse104.zenez.com> <alpine.DEB.1.00.0902271936090.6600@intel-tinevez-2-302> <alpine.LNX.2.00.0902271216090.19082@suse104.zenez.com> <7vwsbbir1j.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.2.00.0902271341440.19082@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 21:50:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld9fP-00068b-1C
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 21:50:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755811AbZB0UtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 15:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755858AbZB0UtN
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 15:49:13 -0500
Received: from suse104.zenez.com ([198.60.105.164]:39824 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755498AbZB0UtM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 15:49:12 -0500
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id B5ABA6C1A7A; Fri, 27 Feb 2009 13:49:10 -0700 (MST)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id A3BBA938174;
	Fri, 27 Feb 2009 13:49:10 -0700 (MST)
In-Reply-To: <alpine.LNX.2.00.0902271341440.19082@suse104.zenez.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111712>

On Fri, 27 Feb 2009, Boyd Lynn Gerber wrote:
> On Fri, 27 Feb 2009, Junio C Hamano wrote:
>> Boyd Lynn Gerber <gerberb@zenez.com> writes:
>>> Does the test suite use bash as it's shell?  I seem to have to use
>>> bash now to run the test.  I do not remember having to use bash on
>>> earlier 1.6.0
>> 
>> If your /bin/sh is not POSIX enough, you may be using a different shell
>> when building the scripted commands in the main Makefile by setting
>> SHELL_PATH.  The tests are supposed to use the same one as that.
>> 
>>> I have to use bash to run the test or I get
>>> 
>>> $ ./t4034-diff-words.sh
>>> ./t4034-diff-words.sh: syntax error at line 52: `(' unexpected
>> 
>> The open parenthesis on line 52 is the one between h and 4 here:
>>
>>    cat > expect <<\EOF
>>    <WHITE>diff --git a/pre b/post<RESET>
>>    <WHITE>index 330b04f..5ed8eff 100644<RESET>
>>    <WHITE>--- a/pre<RESET>
>>    <WHITE>+++ b/post<RESET>
>>    <BROWN>@@ -1,3 +1,7 @@<RESET>
>>    <RED>h(4)<RESET><GREEN>h(4),hh[44]<RESET>
>>    <RESET>
>>    a = b + c<RESET>
>>
>>    <GREEN>aa = a<RESET>
>>
>>    <GREEN>aeff = aeff * ( aaa )<RESET>
>>    EOF
>> 
>> Perhaps your shell has a broken here-text?
>
> On OpenServer 6.0.6 /u95/bin/sh /u95/bin/ksh /u95/bin/bash are POSIX 
> compliant shells.  The /bin/ shells are the stand SCO has had finx XENIX. 
> They use system 5v3.  POSIX is System 5v4.

That should have been OpenServer 6.0 MP4.

-- 
Boyd Gerber <gerberb@zenez.com> 801 849-0213
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
