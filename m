From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv5 9/9] t3301: Modernize
Date: Thu, 13 Nov 2014 00:43:41 +0100
Message-ID: <CALKQrge2FM79XQy14jEYQBY+DwQ9xpcC-yMmKk1kE-yJixzJVw@mail.gmail.com>
References: <1415752816-22782-1-git-send-email-johan@herland.net>
	<1415752816-22782-10-git-send-email-johan@herland.net>
	<CAPig+cSVtAi-n4EKaOgNwDqLvajzvozRG5_o3XjfZAMzW8T8-g@mail.gmail.com>
	<CALKQrgd-XzAhyZCADmQbCuUL6bdr1nrY8XACBb7UbEv9c=X3dQ@mail.gmail.com>
	<xmqq389o3yop.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	"James H. Fisher" <jhf@trifork.com>, Jeff King <peff@peff.net>,
	Michael Blume <blume.mike@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 00:44:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XohZz-0007nL-FF
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 00:44:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821AbaKLXn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 18:43:58 -0500
Received: from mail12.copyleft.no ([188.94.218.224]:37224 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753645AbaKLXn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 18:43:58 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1XohZm-0002dc-O1
	for git@vger.kernel.org; Thu, 13 Nov 2014 00:43:51 +0100
Received: from mail-pa0-f46.google.com ([209.85.220.46])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1XohZk-0004nV-Fv
	for git@vger.kernel.org; Thu, 13 Nov 2014 00:43:48 +0100
Received: by mail-pa0-f46.google.com with SMTP id lf10so13878683pab.5
        for <git@vger.kernel.org>; Wed, 12 Nov 2014 15:43:41 -0800 (PST)
X-Received: by 10.66.139.234 with SMTP id rb10mr21153881pab.146.1415835821590;
 Wed, 12 Nov 2014 15:43:41 -0800 (PST)
Received: by 10.70.68.3 with HTTP; Wed, 12 Nov 2014 15:43:41 -0800 (PST)
In-Reply-To: <xmqq389o3yop.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 12, 2014 at 10:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>> On Wed, Nov 12, 2014 at 2:57 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Tue, Nov 11, 2014 at 7:40 PM, Johan Herland <johan@herland.net> wrote:
>>>> +       test_line_count = 1 actual
>>>
>>> Broken &&-chain. This problem is repeated each place use invoke
>>> test_line_count().
>>
>> Thanks. Fixed in the next iteration.
>
> Just FYI, here is what I came up with on top of 9/9 as 10/9, and it
> can be squashed in.  If these will be the only differences between
> v5 and upcoming v6, you can just tell me to squash them together.

So far this is the only diff on top of v5. I've squashed it into my
tree, so if a re-roll is needed, this diff will also be part of it.
But if no other issues show up to trigger a re-roll, then please
squash them on your end as well.

> One unrelated changes is that '\'' is a bit shorter than '"'"' (and
> the four-letter sequence is idiomatic and easier to spot, once your
> eyes are used to reading strings in single-quote pairs).

Agreed, thanks.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
