From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: [RFC/PATCH] Use compatibility regex library for OSX/Darwin
Date: Tue, 16 Sep 2008 19:02:41 -0600
Message-ID: <alpine.LNX.1.10.0809161900340.17105@suse104.zenez.com>
References: <20080907184537.GA4148@regex.yaph.org> <W_emvcr7ijntBMNCDV17_XHXotGkm1Bn-9Bw-ZixcXmFyBWlDj5vYg@cipher.nrlssc.navy.mil> <alpine.LNX.1.10.0809161722580.18110@suse104.zenez.com> <20080916233220.GA14173@coredump.intra.peff.net>
 <alpine.LNX.1.10.0809161738010.17105@suse104.zenez.com> <20080916234624.GA14405@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Arjen Laarhoven <arjen@yaph.org>, git@vger.kernel.org,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 17 03:03:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KflSQ-0000sJ-72
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 03:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575AbYIQBCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 21:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752530AbYIQBCn
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 21:02:43 -0400
Received: from suse104.zenez.com ([198.60.105.164]:8858 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbYIQBCm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 21:02:42 -0400
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id AEF11A7C8E6; Tue, 16 Sep 2008 19:02:41 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id A2732A7C8E3;
	Tue, 16 Sep 2008 19:02:41 -0600 (MDT)
In-Reply-To: <20080916234624.GA14405@coredump.intra.peff.net>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96062>

On Tue, 16 Sep 2008, Jeff King wrote:
> On Tue, Sep 16, 2008 at 05:42:11PM -0600, Boyd Lynn Gerber wrote:
>> When I do a gmake test these 4 platforms all fail only these 2 tests.
>>
>> * FAIL 10: reinit
>> [...]
>> * FAIL 11: init with --template
>> [...]
>> gmake[1]: *** [t0001-init.sh] Error 1
>>
>> I have not had time to look into the failures.  How many tests should I
>> see and pass.  The first 40 all pass.  Then 2 of 12 fail as above.
>
> These failures are unrelated to the described problem, and prevent the
> system from continuing on to run other tests.
>
> So if you get a chance, please:
>
>       gmake test GIT_TEST_OPTS=--verbose

So with path set so my /usr/gnu/bin/ is before any others this is what I 
get as the next failure.  After a long run...

* FAIL 5: alternation in pattern

                 git config diff.java.funcname "^[ 
]*\(\(public\|static\).*\)$"
                 git diff --no-index Beer.java Beer-correct.java |
                 grep "^@@.*@@ public static void main("


* failed 1 among 5 test(s)
gmake[1]: *** [t4018-diff-funcname.sh] Error 1
gmake[1]: Leaving directory `/home/zenez/build/osr6/git-1.6.0.2/t'
gmake: *** [test] Error 2


--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
