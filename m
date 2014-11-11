From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv4 9/9] t3301: Modernize
Date: Tue, 11 Nov 2014 02:50:20 +0100
Message-ID: <CALKQrgfHNj=TRnFL+5P-_8YCs4D6SF6S9xBqeVAdvj0c+USp4Q@mail.gmail.com>
References: <1415536255-19961-1-git-send-email-johan@herland.net>
	<1415536255-19961-10-git-send-email-johan@herland.net>
	<xmqqioim9498.fsf@gitster.dls.corp.google.com>
	<CALKQrgec-_9kbqba7PBFvNpCpeRAb=Pq6-OMnrJ2nw0fh_5LjQ@mail.gmail.com>
	<CAPig+cQuZ7F5OEVDJ8M-p8B5YB9YNgnNzbbNXS2Dzy6u5_rxdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	"James H. Fisher" <jhf@trifork.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 02:50:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xo0bO-0002gu-5f
	for gcvg-git-2@plane.gmane.org; Tue, 11 Nov 2014 02:50:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbaKKBud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 20:50:33 -0500
Received: from mail12.copyleft.no ([188.94.218.224]:54359 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbaKKBuc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 20:50:32 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1Xo0bG-0006VW-Do
	for git@vger.kernel.org; Tue, 11 Nov 2014 02:50:30 +0100
Received: from mail-pd0-f174.google.com ([209.85.192.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Xo0bD-0004vG-Bz
	for git@vger.kernel.org; Tue, 11 Nov 2014 02:50:27 +0100
Received: by mail-pd0-f174.google.com with SMTP id p10so9052093pdj.33
        for <git@vger.kernel.org>; Mon, 10 Nov 2014 17:50:20 -0800 (PST)
X-Received: by 10.66.140.102 with SMTP id rf6mr3521525pab.1.1415670620365;
 Mon, 10 Nov 2014 17:50:20 -0800 (PST)
Received: by 10.70.68.3 with HTTP; Mon, 10 Nov 2014 17:50:20 -0800 (PST)
In-Reply-To: <CAPig+cQuZ7F5OEVDJ8M-p8B5YB9YNgnNzbbNXS2Dzy6u5_rxdw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 11, 2014 at 2:07 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Nov 10, 2014 at 8:04 PM, Johan Herland <johan@herland.net> wrote:
>> On Mon, Nov 10, 2014 at 9:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Johan Herland <johan@herland.net> writes:
>>>
>>>> Make this test script appear somewhat less old-fashioned:
>>>>  - Use test helper functions:
>>>>     - write_script
>>>>     - test_commit
>>>>     - test_write_lines
>>>>     - test_config
>>>>     - test_unconfig
>>>>     - test_path_is_missing
>>>>  - Remove whitespace between redirection operators and their targets.
>>>>  - Move preparation of "except" files into tests.
>>>
>>> expect, I think (no need to resend; I've fixed it up locally).
>>
>> Thanks.
>
> One further modernization would be to use the name "actual" rather
> than "output" for files holding actual contents (as opposed to the
> "expect" contents).

Agreed. Will be fixed in the re-roll.

...Johan
-- 
Johan Herland, <johan@herland.net>
www.herland.net
