From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv5 9/9] t3301: Modernize
Date: Wed, 12 Nov 2014 10:08:02 +0100
Message-ID: <CALKQrgd-XzAhyZCADmQbCuUL6bdr1nrY8XACBb7UbEv9c=X3dQ@mail.gmail.com>
References: <1415752816-22782-1-git-send-email-johan@herland.net>
	<1415752816-22782-10-git-send-email-johan@herland.net>
	<CAPig+cSVtAi-n4EKaOgNwDqLvajzvozRG5_o3XjfZAMzW8T8-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	"James H. Fisher" <jhf@trifork.com>, Jeff King <peff@peff.net>,
	Michael Blume <blume.mike@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 10:08:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoTua-0003ec-5h
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 10:08:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbaKLJIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 04:08:17 -0500
Received: from mail12.copyleft.no ([188.94.218.224]:33040 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588AbaKLJIO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 04:08:14 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1XoTuN-0004yD-HW
	for git@vger.kernel.org; Wed, 12 Nov 2014 10:08:11 +0100
Received: from mail-pd0-f176.google.com ([209.85.192.176])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1XoTuN-000EF5-81
	for git@vger.kernel.org; Wed, 12 Nov 2014 10:08:11 +0100
Received: by mail-pd0-f176.google.com with SMTP id ft15so11800117pdb.7
        for <git@vger.kernel.org>; Wed, 12 Nov 2014 01:08:02 -0800 (PST)
X-Received: by 10.68.221.162 with SMTP id qf2mr17745354pbc.148.1415783282754;
 Wed, 12 Nov 2014 01:08:02 -0800 (PST)
Received: by 10.70.68.3 with HTTP; Wed, 12 Nov 2014 01:08:02 -0800 (PST)
In-Reply-To: <CAPig+cSVtAi-n4EKaOgNwDqLvajzvozRG5_o3XjfZAMzW8T8-g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 12, 2014 at 2:57 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Nov 11, 2014 at 7:40 PM, Johan Herland <johan@herland.net> wrote:
>> +       test_line_count = 1 actual
>
> Broken &&-chain. This problem is repeated each place use invoke
> test_line_count().

Thanks. Fixed in the next iteration.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
