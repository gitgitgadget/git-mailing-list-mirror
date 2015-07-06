From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH 3/7] pack-protocol.txt: Mark all LFs in push-cert as required
Date: Mon, 6 Jul 2015 11:29:28 -0400
Message-ID: <CAD0k6qSfPEp9L2htDp7+JQ6jv=Enm7O1+j_0hiThWZdi-3PL-g@mail.gmail.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
 <1435774099-21260-4-git-send-email-dborowitz@google.com> <xmqqfv578x87.fsf@gitster.dls.corp.google.com>
 <CAD0k6qSN9=afCe3RumJPfP9JERy1w+tAYdjq01MsQnsOjdKu3A@mail.gmail.com>
 <xmqqzj3f7gde.fsf@gitster.dls.corp.google.com> <CAD0k6qTDpH0H-k9h+f3X8PjXpOZ7tRzv+8wvi8HALhg9DDm4Ew@mail.gmail.com>
 <CAD0k6qSJeNBX=kmo4dn-=SqHGottXT2PJfpCD=y_SKNwEMDMyA@mail.gmail.com> <CAD0k6qQyhMKe7=gzuPt3QwDEvX1ovr72aHnGeAHnf1=LffqF-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 17:30:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZC8LK-0006bJ-1d
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 17:30:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753412AbbGFP3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 11:29:55 -0400
Received: from mail-vn0-f42.google.com ([209.85.216.42]:41195 "EHLO
	mail-vn0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbbGFP3s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 11:29:48 -0400
Received: by vnbf62 with SMTP id f62so7916877vnb.8
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 08:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sl6sqq1c/wYtNKQBUKQHxm9T2HrkAYNA9D5Z5DYRqak=;
        b=JVaXZEKxz7o4LOCDxbHorRAEWQJ+eRJsuuDdY5NyMWu45qWfN0ZELXd3HNh85xDTwN
         7aDX2PldtyEWY5xNk47ma5uGkntM01A6WIoAw9T1iriLSmXqaMvpfR76uHRJhVrOcHqN
         JTuNLpVlD3Pe/TBXTdU4lurgZwFch5oqiSL0i8BLDS+CZUQMvCn3K+/QNSWL4ga7XcII
         7eg11X7bSX3aCRTR5JRiOyxmedHXhHkeY+xcVSDVZMJ4suzvjg1kl0+9VVleM1ajRaux
         Wueg09w5goPQyNVh3ah7WjNdfQammIOi3JC9CHRHcMdkkkV9eK95gf7Jx8MKGC6Jz5X/
         PVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=sl6sqq1c/wYtNKQBUKQHxm9T2HrkAYNA9D5Z5DYRqak=;
        b=DH/j8clXVvJZJzhn12Bs5S/pkuQm0Swr7KAItEnec4iQ7Thgo3Eqb2JjbJN+yQG9jc
         Us01OLK/nY1m6J3PkiyY3LUOeD/Z6GSObeWS766+mLMDM0i8JZ8tTZRoVVOno6TSIDv/
         oxFNSUckLRS1f7lAy7BcCKymEL6pEI/YXehfbe1idZ4MXk5YjIDaQUyR/wg869SEht29
         7vhozLW4kGFmEq43QpPMRKPtkDLv0j9HkvB0B7j3m5qHTTZeDGmokqAIZtilSdhYhaJ9
         xtDeabUJ7zoojsUMNpRQidFlorUWtWaVcCc/IYhJ9jjghAx8IoUY0kVaNZ9dyGG7aytf
         BYcQ==
X-Gm-Message-State: ALoCoQnV3S/Ly2+tvI3b4Ey9i8Zy/rGH074vgnh9Wz5ZkUCuBrdEe16Ex1HHQ+8KTicqwVyivd2V
X-Received: by 10.52.188.137 with SMTP id ga9mr50475524vdc.30.1436196587868;
 Mon, 06 Jul 2015 08:29:47 -0700 (PDT)
Received: by 10.52.177.6 with HTTP; Mon, 6 Jul 2015 08:29:28 -0700 (PDT)
In-Reply-To: <CAD0k6qQyhMKe7=gzuPt3QwDEvX1ovr72aHnGeAHnf1=LffqF-Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273388>

On Mon, Jul 6, 2015 at 11:27 AM, Dave Borowitz <dborowitz@google.com> wrote:
> On Mon, Jul 6, 2015 at 11:22 AM, Dave Borowitz <dborowitz@google.com> wrote:
>> b. Write a parser in some other clever way, e.g. parsing the entire
>> cert in reverse might work.
>
> ...as long as " " is illegal in nonce and pushee values, which it may
> be but is not explicitly documented. I still have no desire to write
> such a parser.

TBQH at this point I would prefer, as a protocol implementor, to
restore the original proposal of this patch, which is to require \n in
push certificates.
