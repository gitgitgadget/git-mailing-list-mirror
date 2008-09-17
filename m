From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: [RFC/PATCH] Use compatibility regex library for OSX/Darwin
Date: Wed, 17 Sep 2008 08:48:18 -0600
Message-ID: <alpine.LNX.1.10.0809170845240.17105@suse104.zenez.com>
References: <20080907184537.GA4148@regex.yaph.org> <W_emvcr7ijntBMNCDV17_XHXotGkm1Bn-9Bw-ZixcXmFyBWlDj5vYg@cipher.nrlssc.navy.mil> <alpine.LNX.1.10.0809161722580.18110@suse104.zenez.com> <20080916233220.GA14173@coredump.intra.peff.net>
 <alpine.LNX.1.10.0809161738010.17105@suse104.zenez.com> <20080916234624.GA14405@coredump.intra.peff.net> <alpine.LNX.1.10.0809161900340.17105@suse104.zenez.com> <_MhavOIoKmx4_xVm-blejLMi-eFa1T8Huv94Uz9PxwJ3DyOMzuyUeg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jeff King <peff@peff.net>, Arjen Laarhoven <arjen@yaph.org>,
	git@vger.kernel.org, Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Sep 17 16:49:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfyLW-0001r7-Rd
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 16:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610AbYIQOsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 10:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752733AbYIQOsU
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 10:48:20 -0400
Received: from suse104.zenez.com ([198.60.105.164]:7208 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416AbYIQOsT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 10:48:19 -0400
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id 59CCEA7C861; Wed, 17 Sep 2008 08:48:18 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id 4F05EA7C25F;
	Wed, 17 Sep 2008 08:48:18 -0600 (MDT)
In-Reply-To: <_MhavOIoKmx4_xVm-blejLMi-eFa1T8Huv94Uz9PxwJ3DyOMzuyUeg@cipher.nrlssc.navy.mil>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96118>

On Tue, 16 Sep 2008, Brandon Casey wrote:
> Boyd Lynn Gerber wrote:
>> So with path set so my /usr/gnu/bin/ is before any others this is what I
>> get as the next failure.  After a long run...
>>
>> * FAIL 5: alternation in pattern
>>
>>                 git config diff.java.funcname "^[
>> ]*\(\(public\|static\).*\)$"
>>                 git diff --no-index Beer.java Beer-correct.java |
>>                 grep "^@@.*@@ public static void main("
>>
>>
>> * failed 1 among 5 test(s)
>> gmake[1]: *** [t4018-diff-funcname.sh] Error 1
>> gmake[1]: Leaving directory `/home/zenez/build/osr6/git-1.6.0.2/t'
>> gmake: *** [test] Error 2
>
> That's the one, thanks.
>
> And just so you know, this isn't a regression. It's just a new test that
> was designed to reveal a shortcoming that no one knew existed before Arjen
> discovered it.

Six of the 12 all have the same problem.  I would say all 12 have it as my 
experience has shown that if these have it then all have it.  The fixes I 
did were so generic that once I got these first 6 working the others just 
worked.  So I would say they all need the patch or fix.  Sorry I did not 
follow the whole thread.  I read it from the archive what I could.  It 
seems the archive is about 2 days behind.

Good Luck,

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
