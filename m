From: "Matthias Kestenholz" <lists@spinlock.ch>
Subject: Re: gitattributes
Date: Wed, 25 Apr 2007 00:06:35 +0200
Message-ID: <1f6632e50704241506q15315ccbi239b5eee1f184b3e@mail.gmail.com>
References: <1f6632e50704240436l4a81d8c9s1bbf95a7892db68c@mail.gmail.com>
	 <81b0412b0704240918t70bfb3bt5f0e6e85028be5e6@mail.gmail.com>
	 <7v4pn55u4d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 25 00:06:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgT9n-0000eb-11
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 00:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423158AbXDXWGi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 18:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423159AbXDXWGi
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 18:06:38 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:30234 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423158AbXDXWGh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 18:06:37 -0400
Received: by wr-out-0506.google.com with SMTP id 76so2145376wra
        for <git@vger.kernel.org>; Tue, 24 Apr 2007 15:06:36 -0700 (PDT)
Received: by 10.114.198.1 with SMTP id v1mr3465329waf.1177452395990;
        Tue, 24 Apr 2007 15:06:35 -0700 (PDT)
Received: by 10.114.154.15 with HTTP; Tue, 24 Apr 2007 15:06:35 -0700 (PDT)
In-Reply-To: <7v4pn55u4d.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Google-Sender-Auth: 80acc858bb7afd65
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45493>

2007/4/24, Junio C Hamano <junkio@cox.net>:
> "Alex Riesen" <raa.lkml@gmail.com> writes:
>
> > On 4/24/07, Matthias Kestenholz <lists@spinlock.ch> wrote:
> >> The .gitattributes system together with input/output filters has already
> >> proven exceptionally useful for me. I've got some co-workers which
> >> do not seem to care about CRLF line endings or whitespace damage.
> >>
> >> core.autocrlf = input
> >>
> >> and
> >>
> >> [filter "whitespace"]
> >>   clean = stripspace
> >>   smudge = cat
> >>
> >
> > Why didn't --ignore-space-at-eol, -b and -w work for you?
>
> It should.  What Matthias would want more is probably to have
> others to have the "clean" side of the filter in their working
> repository.

Yes, that's the reason. Furthermore, I like the approach of the filter
better than adding command line arguments (which I and others will
always forget on the first try)

I've just copy-pasted the smudge filter from an example I saw on
the list. I'll retest the filter setup tomorrow without "smudge = cat"
and look for problems.
