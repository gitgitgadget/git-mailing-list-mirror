From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] test-lib: Document short options in t/README
Date: Tue, 25 Mar 2014 01:52:29 -0400
Message-ID: <CAPig+cSLNt6G4tk9C8UpE7Bj--F3+Cy0isSp094eV9oGX_tHaA@mail.gmail.com>
References: <1395650987-5960-1-git-send-email-ilya.bobyr@gmail.com>
	<1395650987-5960-2-git-send-email-ilya.bobyr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>
To: Ilya Bobyr <ilya.bobyr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 06:52:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSKHs-0007FX-Da
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 06:52:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbaCYFwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 01:52:31 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:35582 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbaCYFw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 01:52:29 -0400
Received: by mail-yk0-f176.google.com with SMTP id 19so17500894ykq.7
        for <git@vger.kernel.org>; Mon, 24 Mar 2014 22:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=tT9bm7XVAzYoJJclhnHnj5xdXT2/lvlsmv8QOHAfCbY=;
        b=Usr6eoE/tneQbRBJMH+cHoBiVCpYuNhpYQ8GyAH4o04WEMISw8bFT0jcVR4VYOcB+2
         agudK6HMUKKwAOOsdkvzinqpAd/1zumU3flHYlWeg78akSZ6bYdDCRVeqBLo+eM4nS3i
         FtVI3Dj6L1xaghPN7Whl8UD4LJXz4sdhHMq3CZM7rl80VeTla5mbn3tozfAyxeW9tJLN
         hkvgg6guyIb+ZAUU6EdhSg9vPyHCPqwAkeELRMKiqwDIoDWFqyf99Nm8aRZFV33fro7a
         pTwH/FL/G2BzXjWFUB/mrOPcOVEB3TjLwcKy8UnHqZ1xdE/FJDTysudP7o/qTYbPx/Ro
         RZGQ==
X-Received: by 10.236.75.74 with SMTP id y50mr96292541yhd.27.1395726749377;
 Mon, 24 Mar 2014 22:52:29 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Mon, 24 Mar 2014 22:52:29 -0700 (PDT)
In-Reply-To: <1395650987-5960-2-git-send-email-ilya.bobyr@gmail.com>
X-Google-Sender-Auth: d5Cl7O3M8fBFAt7O72Aq9VXtbpE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244906>

On Mon, Mar 24, 2014 at 4:49 AM, Ilya Bobyr <ilya.bobyr@gmail.com> wrote:
> Most arguments that could be provided to a test have short forms.
> Unless documented the only way to learn then is to read the code.

s/then/them/

(Also, add a comma after "documented".)

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
>         This makes the test more verbose.  Specifically, the
>         command being run and their output if any are also
>         output.
> @@ -81,7 +81,7 @@ appropriately before running "make".
>         numbers matching <pattern>.  The number matched against is
>         simply the running count of the test within the file.
>
> ---debug::
> +-d,--debug::
>         This may help the person who is developing a new test.
>         It causes the command defined with test_debug to run.
>         The "trash" directory (used to store all temporary data
> @@ -89,18 +89,18 @@ appropriately before running "make".
>         failed tests so that you can inspect its contents after
>         the test finished.
>
> ---immediate::
> +-i,--immediate::
>         This causes the test to immediately exit upon the first
>         failed test. Cleanup commands requested with
>         test_when_finished are not executed if the test failed,
>         in order to keep the state for inspection by the tester
>         to diagnose the bug.
>
> ---long-tests::
> +-l,--long-tests::
>         This causes additional long-running tests to be run (where
>         available), for more exhaustive testing.
>
> ---valgrind=<tool>::
> +-v,--valgrind=<tool>::
>         Execute all Git binaries under valgrind tool <tool> and exit
>         with status 126 on errors (just like regular tests, this will
>         only stop the test script when running under -i).
> --
> 1.7.9
>
