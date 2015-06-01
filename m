From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/WIP PATCH 11/11] Document protocol version 2
Date: Mon, 1 Jun 2015 16:14:15 -0700
Message-ID: <CAGZ79kaRTLX7eBCOA=yQHVwcN-H-o_aZFfQ1gw7Nx-NC82pbag@mail.gmail.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
	<1432677675-5118-12-git-send-email-sbeller@google.com>
	<xmqqsiafazr7.fsf@gitster.dls.corp.google.com>
	<CAGZ79kbELvZ6otnNwGHsgiC9EjgS2vrDGU2KCgF2c_Azm=-rWg@mail.gmail.com>
	<xmqqk2vraw6p.fsf@gitster.dls.corp.google.com>
	<20150529222120.GB15678@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 02 01:14:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzYuW-0005n8-0N
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 01:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348AbbFAXOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 19:14:20 -0400
Received: from mail-qc0-f179.google.com ([209.85.216.179]:33298 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753602AbbFAXOS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 19:14:18 -0400
Received: by qcmi9 with SMTP id i9so53750281qcm.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 16:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=q2nv8Mo761iJGAG//7vX8xpI9nREUIH+sIA033XZQGM=;
        b=SeuEhm+0SyxCqEAdc9BL0/0NT9DkfPGu67cGEtoXlQcyWZQbHFc1G+zTzmkhzv53gb
         axP3XkxEPipV6B0gYijyYfeEp7FeAZ4bIZywLLn0OHEokFQ9xMSEvS99KSCsG6U5l8K+
         BI6gQoZtKFqHw2j2oxJV08dz3Vim+xiYIjxuZLgSDMZwSPrIwRdm1LevAkmPbDRQVT4T
         41VVq7Ai2V4a9wDsDQPWI7UD2xWcORPdb5UNmF651VSBpYp304KkXvAGT21O4b+pYHFQ
         HApwcaBMsmLV8NARMln0IQ+isJyzCUKGSpK1e3nu/tac1UjQZ+whxt2mZUInpvyJHj/x
         rjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=q2nv8Mo761iJGAG//7vX8xpI9nREUIH+sIA033XZQGM=;
        b=YYsxjTyhkJ3qRHcmxxmdOkGP8XPE9v1qE026pPZfk/rt4wLkro9P/+xXU+hnhB4SNC
         oU+VjY9dqpNZsi83xDRrX5YSS+j400gSQg3nO7xuCUYRXQXGqTRqMsReC4RYr7qQFmh8
         +8RBemz1EM3M33hwRmiE1q8WkfH2i8YfoTTd6TmsSLpKOGJqi9he2DImC6A/1RQo3QjS
         GfY0icDl9F1buk1k3O5QebzPGk/L+MoLXUQ20vZCKOsuZOddah69cDyM0NKEL0pQOKbu
         jcz/8o/nkDL17WJt5SzWr3Dp4ruciiDhUvPn4CWNMvr2ZyTls02hbPBvDCUkkluqtIMB
         E1Ow==
X-Gm-Message-State: ALoCoQk5BYTNn3x2IG1mrQ1CZnwBM3HOC65UwrALKkbxVW5I4V/2cWQS516HHBUtEw6BbPbCsRhD
X-Received: by 10.55.19.197 with SMTP id 66mr42702139qkt.24.1433200455460;
 Mon, 01 Jun 2015 16:14:15 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Mon, 1 Jun 2015 16:14:15 -0700 (PDT)
In-Reply-To: <20150529222120.GB15678@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270479>

On Fri, May 29, 2015 at 3:21 PM, Jeff King <peff@peff.net> wrote:
> On Fri, May 29, 2015 at 02:52:14PM -0700, Junio C Hamano wrote:
>
>> > Currently we can do a = as part of the line after the first ref, such as
>> >
>> >     symref=HEAD:refs/heads/master agent=git/2:2.4.0
>> >
>> > so I thought we want to keep this.
>>
>> I do not understand that statement.
>>
>> Capability exchange in v2 is one packet per cap, so the above
>> example would be expressed as:
>>
>>       symref=HEAD:refs/heads/master
>>         agent=git/2:2.4.0
>>
>> right?  Your "keyvaluepair" is limited to [a-z0-9-_=]*, and neither
>> of the above two can be expressed with that, which was why I said
>> you need two different set of characters before and after "=".  Left
>> hand side of "=" is tightly limited and that is OK.  Right hand side
>> may contain characters like ':', '.' and '/', so your alphabet need
>> to be more lenient, even in v1 (which I would imagine would be "any
>> octet other than SP, LF and NUL").

I think the recent issue with the push certificates shows that having arbitrary
data after the = is a bad idea. So we need to be very cautious when to allow
which data after the =.

I'll try split up the patch.

>
> Yes. See git_user_agent_sanitized(), for example, which allows basically
> any printable ASCII except for SP.
>
> I think the v2 capabilities do not even need to have that restriction.
> It can allow arbitrary binary data, because it has an 8bit-clean framing
> mechanism (pkt-lines). Of course, that means such capabilities cannot be
> represented in a v1 conversation (whose framing mechanism involves SP
> and NUL). But it's probably acceptable to introduce new capabilities
> which are only available in a v2 conversation. Old clients that do not
> understand v2 would not understand the capability either. It does
> require new clients implementing the capability to _also_ implement v2
> if they have not done so, but I do not mind pushing people in that
> direction.
>
> The initial v2 client implementation should probably do a few cautionary
> things, then:
>
>   1. Do _not_ fold the per-pkt capabilities into a v1 string; that loses
>      the robust framing. I suggested string_list earlier, but probably
>      we want a list of ptr/len pair, so that it can remain NUL-clean.
>
>   2. Avoid holding on to unknown packets longer than necessary. Some
>      capability pkt-lines may be arbitrarily large (up to 64K). If we do
>      not understand them during the v2 read of the capabilities, there
>      is no point hanging on to them. It's not _wrong_ to do so, but just
>      inefficient; if we know that clients will just throw away unknown
>      packets, then we can later introduce new packets with large data,
>      without worrying about wasting the client's resources.
>
>      I suspect it's not that big a deal either way, though. I have no
>      plans for sending a bunch of large packets, and anyway network
>      bandwidth is probably more precious than client memory.

That's very sensible thoughts after rereading this email. The version
I'll be sending out today will not follow those suggestions though. :(

>
> -Peff
