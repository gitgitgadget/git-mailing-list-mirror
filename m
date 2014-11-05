From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 1/2] t3312-notes-empty: Test that 'git notes' removes
 empty notes by default
Date: Wed, 5 Nov 2014 09:32:49 +0100
Message-ID: <CALKQrgdtvfZ+LFn+VSE-yjvJf1zwTZdEov48eDbhvx0JWHpeug@mail.gmail.com>
References: <1415151175-1682-1-git-send-email-johan@herland.net>
	<CAPig+cT4-1bY5tq8KioC8Js3ZUfZCuFEwOZMeoPW4M_brK+QXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	"James H. Fisher" <jhf@trifork.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Nov 05 09:33:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xlw1Y-0006Jm-4x
	for gcvg-git-2@plane.gmane.org; Wed, 05 Nov 2014 09:33:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbaKEIdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2014 03:33:00 -0500
Received: from mail12.copyleft.no ([188.94.218.224]:42223 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbaKEIc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2014 03:32:59 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1Xlw1R-00042O-1p
	for git@vger.kernel.org; Wed, 05 Nov 2014 09:32:57 +0100
Received: from mail-pa0-f50.google.com ([209.85.220.50])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Xlw1Q-0009eH-Io
	for git@vger.kernel.org; Wed, 05 Nov 2014 09:32:56 +0100
Received: by mail-pa0-f50.google.com with SMTP id eu11so322357pac.37
        for <git@vger.kernel.org>; Wed, 05 Nov 2014 00:32:49 -0800 (PST)
X-Received: by 10.69.20.42 with SMTP id gz10mr54758283pbd.91.1415176369092;
 Wed, 05 Nov 2014 00:32:49 -0800 (PST)
Received: by 10.70.68.3 with HTTP; Wed, 5 Nov 2014 00:32:49 -0800 (PST)
In-Reply-To: <CAPig+cT4-1bY5tq8KioC8Js3ZUfZCuFEwOZMeoPW4M_brK+QXw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 5, 2014 at 5:10 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:

[...]

> write_script() would allow you to drop the #!/bin/sh and chmod lines.

[...]

> Rather than hard-coding this output, generating it would make the test
> script less fragile:
>
>     git log -1 >expect_missing

[...]

> Each -c/-C case fails for me when trying to read $empty_object. For example:
>
> fatal: Failed to read object 'e69de29bb2d1d6434b8b29ae775ad8c2e48c5391'.
> not ok 5 - 'git notes add -c "$empty_blob"' removes empty note

These are all fixed in the re-roll.

Thanks for the feedback!


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
