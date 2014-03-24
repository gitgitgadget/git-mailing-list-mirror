From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 1/3] test-lib: Document short options in t/README
Date: Mon, 24 Mar 2014 11:39:22 +0000
Message-ID: <5330196A.3030101@ramsay1.demon.co.uk>
References: <1395650987-5960-1-git-send-email-ilya.bobyr@gmail.com> <1395650987-5960-2-git-send-email-ilya.bobyr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Ilya Bobyr <ilya.bobyr@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 12:45:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS3K4-0007Ls-RH
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 12:45:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419AbaCXLp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 07:45:28 -0400
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:35437 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750924AbaCXLp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 07:45:27 -0400
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Mar 2014 07:45:27 EDT
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 7175818C9E8;
	Mon, 24 Mar 2014 11:39:28 +0000 (GMT)
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 39E3618C4C2;
	Mon, 24 Mar 2014 11:39:28 +0000 (GMT)
Received: from [192.168.254.11] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta005.tch.inty.net (Postfix) with ESMTP;
	Mon, 24 Mar 2014 11:39:27 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <1395650987-5960-2-git-send-email-ilya.bobyr@gmail.com>
X-MDF-HostID: 18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244817>

On 24/03/14 08:49, Ilya Bobyr wrote:
> Most arguments that could be provided to a test have short forms.
> Unless documented the only way to learn then is to read the code.
> 
> Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
> ---
>  t/README |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/t/README b/t/README
> index caeeb9d..ccb5989 100644
> --- a/t/README
> +++ b/t/README
> @@ -71,7 +71,7 @@ You can pass --verbose (or -v), --debug (or -d), and --immediate
>  (or -i) command line argument to the test, or by setting GIT_TEST_OPTS
>  appropriately before running "make".
>  
> ---verbose::
> +-v,--verbose::

OK

>  	This makes the test more verbose.  Specifically, the
>  	command being run and their output if any are also
>  	output.
> @@ -81,7 +81,7 @@ appropriately before running "make".
>  	numbers matching <pattern>.  The number matched against is
>  	simply the running count of the test within the file.
>  
> ---debug::
> +-d,--debug::
>  	This may help the person who is developing a new test.
>  	It causes the command defined with test_debug to run.
>  	The "trash" directory (used to store all temporary data
> @@ -89,18 +89,18 @@ appropriately before running "make".
>  	failed tests so that you can inspect its contents after
>  	the test finished.
>  
> ---immediate::
> +-i,--immediate::
>  	This causes the test to immediately exit upon the first
>  	failed test. Cleanup commands requested with
>  	test_when_finished are not executed if the test failed,
>  	in order to keep the state for inspection by the tester
>  	to diagnose the bug.
>  
> ---long-tests::
> +-l,--long-tests::
>  	This causes additional long-running tests to be run (where
>  	available), for more exhaustive testing.
>  
> ---valgrind=<tool>::
> +-v,--valgrind=<tool>::

The -v short option is taken, above ... :-P

>  	Execute all Git binaries under valgrind tool <tool> and exit
>  	with status 126 on errors (just like regular tests, this will
>  	only stop the test script when running under -i).
> 

ATB,
Ramsay Jones
