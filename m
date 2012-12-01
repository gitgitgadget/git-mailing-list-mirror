From: Adam Spiers <git@adamspiers.org>
Subject: Re: Topics currently in the Stalled category
Date: Sat, 1 Dec 2012 00:36:58 +0000
Message-ID: <CAOkDyE-dq+L0Gd4T=8oUeQ4OHE0hgmK4AfUhYgBo0uzq9TrrYw@mail.gmail.com>
References: <7vpq39up0m.fsf@alter.siamese.dyndns.org>
	<7vy5hvq1ey.fsf@alter.siamese.dyndns.org>
	<7vobirq0q2.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 01 01:37:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Teb5B-0002qs-QR
	for gcvg-git-2@plane.gmane.org; Sat, 01 Dec 2012 01:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755963Ab2LAAhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2012 19:37:06 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:56858 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755619Ab2LAAg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2012 19:36:59 -0500
Received: by mail-qa0-f46.google.com with SMTP id r4so49307qaq.19
        for <git@vger.kernel.org>; Fri, 30 Nov 2012 16:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=GE4eY0Ozda17z2RmHTDtZwwbNveE+ItiFEWMWpBoTyQ=;
        b=Oag+cW+fwNHvbkflBhxzPMma7cRqMTCrW0fIVW1bDf4whM9MCDgetKEP0ZmyeQXgrp
         pbbBol9iy5I+YUkxBdHbjSRbMcBf0Gg3hT4GKTsFvudJV54bKCOESBqm93DsEOi+xzpb
         xJMaoWVLSPSGaSe7Mx5z8UF0U0cHiJ1dQW+MObJgW2SWCBnNCmw1RiIaohp0+xpZRz59
         ai7Wsc8og+TN8qr7/CwNTOkAvJVY2ejBDeTu4i7np//LbBY3oj0fLLY8GBk4bXWTr8AE
         tz+FIW3AW4QGpFrnWcPZtt7NJkXzRz7m5PB7dnRPGbAuzRkOHY0K9bW6C1Fy8/K1vH2g
         YPqw==
Received: by 10.224.33.205 with SMTP id i13mr5623048qad.35.1354322218982; Fri,
 30 Nov 2012 16:36:58 -0800 (PST)
Received: by 10.49.30.74 with HTTP; Fri, 30 Nov 2012 16:36:58 -0800 (PST)
In-Reply-To: <7vobirq0q2.fsf_-_@alter.siamese.dyndns.org>
X-Google-Sender-Auth: X6LZDhtLkp3tSqINNHeO37r2Om4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210954>

On Wed, Nov 21, 2012 at 12:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Here is a list of stalled topics I am having trouble deciding what
> to do (the default is to dismiss them around feature freeze).

[snipped]

> * as/check-ignore (2012-11-08) 14 commits
>  - t0007: fix tests on Windows
>  - Documentation/check-ignore: we show the deciding match, not the first
>  - Add git-check-ignore sub-command
>  - dir.c: provide free_directory() for reclaiming dir_struct memory
>  - pathspec.c: move reusable code from builtin/add.c
>  - dir.c: refactor treat_gitlinks()
>  - dir.c: keep track of where patterns came from
>  - dir.c: refactor is_path_excluded()
>  - dir.c: refactor is_excluded()
>  - dir.c: refactor is_excluded_from_list()
>  - dir.c: rename excluded() to is_excluded()
>  - dir.c: rename excluded_from_list() to is_excluded_from_list()
>  - dir.c: rename path_excluded() to is_path_excluded()
>  - dir.c: rename cryptic 'which' variable to more consistent name
>
>  Duy helped to reroll this, but it seems that there weren't any
>  activity since then during my absense.

I have been delayed several times, but I finally resumed work on
another re-roll.  I don't think there is any major reworking required;
just a number of small tweaks.

> * as/test-tweaks (2012-09-20) 7 commits
>  - tests: paint unexpectedly fixed known breakages in bold red
>  - tests: test the test framework more thoroughly
>  - [SQUASH] t/t0000-basic.sh: quoting of TEST_DIRECTORY is screwed up
>  - tests: refactor mechanics of testing in a sub test-lib
>  - tests: paint skipped tests in bold blue
>  - tests: test number comes first in 'not ok $count - $message'
>  - tests: paint known breakages in bold yellow
>
>  Various minor tweaks to the test framework to paint its output
>  lines in colors that match what they mean better.
>
>  Has the "is this really blue?" issue Peff raised resolved???

I have a re-roll of this ready - just need to rebase to latest master,
do a final sanity check, and then send.

Sorry again for the delays.
