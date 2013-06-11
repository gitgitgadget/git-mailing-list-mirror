From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Tue, 11 Jun 2013 15:12:58 -0500
Message-ID: <CAMP44s0ytu39thUo4Jfpy_rEdMKyTu6AtXW+4SBWHoRj+G-TwA@mail.gmail.com>
References: <1370712574-27688-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0mA7MXQv1k5bFpZLARDOHxU5kzKFXzcyUfb6NLZZY-=FA@mail.gmail.com>
	<CAMP44s0cozMsTo7KQAjnqkqmvMwMw9D3SZrVxg48MOXkH9UQJQ@mail.gmail.com>
	<CALkWK0=7PRndNc7XQ-PCPbVCp9vck909bA561JhQG6uXXj1n4g@mail.gmail.com>
	<20130609151235.GA22905@serenity.lan>
	<CAMP44s0L9nQxp5OeK8uT4Ls5WUerCjVpR9uONUcOwvTD6k7Jfg@mail.gmail.com>
	<51B4BBB7.8060807@lyx.org>
	<20130610214504.GG13333@sigill.intra.peff.net>
	<CAMP44s2-94LTu54oX1_m14tnE3KfwK+N=pPxgUSqGCgd51EA5A@mail.gmail.com>
	<20130610220627.GB28345@sigill.intra.peff.net>
	<7vk3m1efda.fsf@alter.siamese.dyndns.org>
	<7v8v2hedou.fsf@alter.siamese.dyndns.org>
	<CAMP44s1HM0zFvkGmaHrX2Wq2JSzDNk8uwNSz3bNo12eWxDcL8A@mail.gmail.com>
	<7v4nd5ecmy.fsf@alter.siamese.dyndns.org>
	<7vwqq1ct0g.fsf@alter.siamese.dyndns.org>
	<CAMP44s0r96ByEs3+N1Qo+O18rOmT72rHk4zAEFAyFdU_DsQ8wA@mail.gmail.com>
	<7vtxl4blht.fsf@alter.siamese.dyndns.org>
	<CAMP44s02PqGFNmrGEcJVT6xcQHx8k4NYqJ_TtOTUEY8XHPj0BA@mail.gmail.com>
	<7vppvsbkc3.fsf@alter.siamese.dyndns.org>
	<CAMP44s02KaMaMUz4618n5RqVqVSXzr_D9rPS1uesy2XEdqnq5A@mail.gmail.com>
	<CA+55aFwYAFuz5p0=8QiAFDy4e66f1pF3v=D5nnL6+3um7Z3L2g@mail.gmail.com>
	<7vehc8a05n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 22:13:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmUwJ-0002cm-Oe
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 22:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757094Ab3FKUND (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 16:13:03 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:52481 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757085Ab3FKUNA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 16:13:00 -0400
Received: by mail-lb0-f172.google.com with SMTP id v20so3428401lbc.3
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 13:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jlX0mKewgIn6XTF2XIO0xC1GULOn5VZkqE6UVOxzSjs=;
        b=erJPNeUNDt81E+5+o9gK4E4i3Ku12+xYnOqNgCICjzSrg/Ll5A+owJC4WfsZ8o2108
         QLU0H8yNwylOv7lNlAUNYXF6JZUc2ZmiPsUA3WosV/k+1hkwwp8gq6XKY5xGUGpsZnSw
         BEMZKOeuldTfB802x7KEoN8DIq8a9BRck8En6fLIqwBb6F2kGxT4nL5kJX2E1XQLe9O2
         TQAx+yH7uztpEgeYbMe9SnmG0TaHxthYNPivdR7Ag7I2/QIFbX0ZqhWChmg9sGtu9oum
         CABYkswmflRSz2GCqDbv/xakcgE5xl2BvV8dCQ9jntbpgDEPeZc0Ahh2gtLQBm5TELtV
         aX0w==
X-Received: by 10.112.166.67 with SMTP id ze3mr9638529lbb.25.1370981579108;
 Tue, 11 Jun 2013 13:12:59 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Tue, 11 Jun 2013 13:12:58 -0700 (PDT)
In-Reply-To: <7vehc8a05n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227510>

On Tue, Jun 11, 2013 at 2:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> This whole thread has been one long argument about totally pointless
>> things that wouldn't improve anything one way or the other. It's
>> bikeshedding of the worst kind. Just let it go.
>
> The proposal to move sequencer.c to builtins/sequencer.c and then
> adding a filter in Makefile to exclude so that "git-sequencer" is
> not built is "it wouldn't improve anything one way or the other".
> It is to throw in something into a set to which it does not belong,

In your opinion.

> and then working around that mistake with another kludge.

In your opinion.

You continually use absolutist rhetoric to try to convince yourself
and others that what you say is absolute 100% fact. But it's not, it's
your opinion.

> So I do not think this is not even a bikeshedding.  Just one side
> being right, and the other side continuing to repeat nonsense
> without listening.

George W. Bush said history would prove him right, but saying so
doesn't make it so. At least he had the decency to acknowledge that
other people had different valid opinions.

builtin/lib.a makes perfect sense, and it's the first logical step in
moving libgit.a towards libgit2.

-- 
Felipe Contreras
