From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: [RFC/PATCH] Use compatibility regex library for OSX/Darwin
Date: Tue, 16 Sep 2008 18:38:11 -0600
Message-ID: <alpine.LNX.1.10.0809161824470.17105@suse104.zenez.com>
References: <20080907184537.GA4148@regex.yaph.org> <W_emvcr7ijntBMNCDV17_XHXotGkm1Bn-9Bw-ZixcXmFyBWlDj5vYg@cipher.nrlssc.navy.mil> <alpine.LNX.1.10.0809161722580.18110@suse104.zenez.com> <20080916233220.GA14173@coredump.intra.peff.net>
 <alpine.LNX.1.10.0809161738010.17105@suse104.zenez.com> <20080916234624.GA14405@coredump.intra.peff.net> <alpine.LNX.1.10.0809161811100.17105@suse104.zenez.com> <a4X38z5PMKaSj4KeLKBBqWb9elMD_Pp1n1eMqdmujRqMrr9xtvQAfA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jeff King <peff@peff.net>, Arjen Laarhoven <arjen@yaph.org>,
	git@vger.kernel.org, Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Sep 17 02:42:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfl7I-0003v0-9h
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 02:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419AbYIQAiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 20:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752361AbYIQAiN
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 20:38:13 -0400
Received: from suse104.zenez.com ([198.60.105.164]:23883 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbYIQAiM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 20:38:12 -0400
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id 885FFA7C86E; Tue, 16 Sep 2008 18:38:11 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id 78A46A7C869;
	Tue, 16 Sep 2008 18:38:11 -0600 (MDT)
In-Reply-To: <a4X38z5PMKaSj4KeLKBBqWb9elMD_Pp1n1eMqdmujRqMrr9xtvQAfA@cipher.nrlssc.navy.mil>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96060>

On Tue, 16 Sep 2008, Brandon Casey wrote:
> Boyd Lynn Gerber wrote:
>> If I use gdiff or make gnu diff and put it in /usr/local/bin/ and change
>> the path to have /usr/local/bin first it does not fail/.
>>
>> I have a /usr/gnu/bin/... where I have gdiff linked to diff.
>
> You must have done something like this in the past when you were testing 
> previous versions since the test_cmp variable has not changed.
>
> So, for future reference either have a diff that understands '-u' in 
> your path, or set the test_cmp environment variable.

I had customized things so that any GNU util used gutil_name.  This is 
the easiest way for me to distinguish between Native utils and GNU utils.

Is there an easy way to have git use gcommand_name instead of 
command_name?  I changed the path to run the git test, but not all my 
clients will allow be to have the gnu named command instead of the native 
command.  There programs require the non GNU functionality.  That is why I 
create a /usr/gnu/  with all the GNU stuff available for my use, but 
having to change paths back and forth just to run git is a pain when 
build/trouble shooting customer  aplications.

Thanks,

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
