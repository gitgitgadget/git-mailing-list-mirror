From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH/RFC 4/6] transport: add refspec list parameters to functions
Date: Tue, 26 Apr 2016 20:59:22 -0700
Message-ID: <CAGZ79kYGi9bhRfGype7te4cGkxvnKww269kYoykB+76HNnTarg@mail.gmail.com>
References: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
	<1460747949-3514-5-git-send-email-dturner@twopensource.com>
	<xmqqa8kq69i5.fsf@gitster.mtv.corp.google.com>
	<20160419071403.GA22577@sigill.intra.peff.net>
	<1461102001.5540.125.camel@twopensource.com>
	<20160419232243.GF18255@sigill.intra.peff.net>
	<1461109391.5540.138.camel@twopensource.com>
	<20160420011740.GA29839@sigill.intra.peff.net>
	<1461185215.5540.180.camel@twopensource.com>
	<20160420205726.GA17876@sigill.intra.peff.net>
	<1461602647.25914.2.camel@twopensource.com>
	<CAGZ79kYc+uMCJq5tTHujp1YYG5OcNSPiyWuGvVzipuBcwtLNYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 05:59:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avGdg-00021t-ND
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 05:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbcD0D7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 23:59:24 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:35776 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbcD0D7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 23:59:24 -0400
Received: by mail-ig0-f173.google.com with SMTP id bi2so116917969igb.0
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 20:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=sK7AK4zWdO8hyMphiAPJ976p3FgGDIuESWvP/PrW4LE=;
        b=WmFjsSsmIwo2QylxKl1cBwbpdZARll/7Wz2wXGng3Ci+TiDwfOa5j3PffwEhR8MTYV
         fKIktStzS4hk6ITBrVCuzGDZe8/c5cpHf9JJKqllxRki0oqYcBhMpI3idwpV5s7VWJ8x
         TYOovN8hICLO9WZ6vhqJf4qRb9pNoFL2M37Xbkbn1RMnictq4wWq4t9kmQL9IsUe6xc3
         ITU5SS9ZN5omxGhJsi7Rgrpu/5tL6hNNB6zYwFb8dpTuVa29sKlEtsy4wOsZFQ9cG12t
         h3s47QHj8XSMZ9craXMCUTpbQ4RxlnMx0aEKea5VkgVbuZc80QQ1xHrrYNGr6LDySzRK
         s0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=sK7AK4zWdO8hyMphiAPJ976p3FgGDIuESWvP/PrW4LE=;
        b=V7OK/AlJQLuQfqTotcYwgmcM3AmrxMpDLkLWP4W0qlH5b2M9qmjczNfMJTkJzSHxDt
         IrIUOOOxcICxolEwFcStaI3zWAgOjaVlaYWOiKpdCKX/3DFQSvVHiQOTJC8v2IXc+VTj
         Zsm5fwTgi9l4vZDso3aUZntLpaPlnTwh5UuvSg771NtQTluROqPQKepu+gcQ2DqGmj9M
         O3VSBw8b3/wllfsfkMO1tmODiZtukJ411NBfM6e6Wj2sK+F+QxRC1AMr0ti4j/TTeabX
         2k/U4crxAakskG1spAC5FfBR3tLffUb2tvf8kPzOdgeSGhy9oy9TvlNKxrmwxDCZl9q6
         Bv6A==
X-Gm-Message-State: AOPr4FVIAs4HUbQit/AXzyd+3hMsG9LU64pVfUWcf6ElTjEzHBnsjs6posG4W0kjWc/wPcQUZCefpZo+lMbhq8vy
X-Received: by 10.50.111.15 with SMTP id ie15mr8214939igb.94.1461729562902;
 Tue, 26 Apr 2016 20:59:22 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Tue, 26 Apr 2016 20:59:22 -0700 (PDT)
In-Reply-To: <CAGZ79kYc+uMCJq5tTHujp1YYG5OcNSPiyWuGvVzipuBcwtLNYA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292702>

On Mon, Apr 25, 2016 at 3:10 PM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Apr 25, 2016 at 9:44 AM, David Turner <dturner@twopensource.com> wrote:
>> On Wed, 2016-04-20 at 16:57 -0400, Jeff King wrote:
>>> On Wed, Apr 20, 2016 at 04:46:55PM -0400, David Turner wrote:
>>>
>>> > As you note, it appears that git-daemon does sort-of have support
>>> > for
>>> > extra args -- see parse_host_arg.  So it wouldn't be hard to add
>>> > something here. Unfortunately, current versions of git die on
>>> > unknown
>>> > args.  So this change would not be backwards-compatible.  We could
>>> > put
>>> > a decider on it so that clients would only try it when explicitly
>>> > enabled.  Or we could have clients try it with, and in the event of
>>> > an
>>> > error, retry without.  Neither is ideal, but both are possible.
>>>
>>> Right. This ends up being the same difficulty that the v2 protocol
>>> encountered; how do you figure out what you can speak without
>>> resorting
>>> to expensive fallbacks, when do you flip the switch, do you remember
>>> the
>>> protocol you used last time with this server, etc.
>>
>> Right.
>>
>> [moved]
>>> > If I read this code correctly, git-over-ssh will pass through
>>> > arbitrary
>>> > arguments.  So this should be trivial.
>>>
>>> It does if you are ssh-ing to a real shell-level account on the
>>> server,
>>> but if you are using git-shell or some other wrapper to restrict
>>> clients
>>> from running arbitrary commands, it will likely reject it.
>>
>> Oh, I see how I was mis-reading shell.c.  Oops.
>> [/moved]
>>
>>
>>> Which isn't to say it's necessarily a bad thing. Maybe the path
>>> forward
>>> instead of v2 is to shoe-horn this data into the pre-protocol
>>> conversation, and go from there. The protocol accepts that "somehow"
>>> it
>>> got some extra data from the transport layer, and acts on its
>>> uniformly.
>>
>> OK, so it seems like only HTTP (and non-git-shell-git://) allow backwar
>> ds-compatible optional pre-protocol messages.  So we don't have good
>> options; we only have bad ones.  We have to decide which particular
>> kind of badness we're willing to accept, and to what degree we care
>> about extensibility.  As I see it, the badness options are (in no
>> particular order):
>>
>> 1. Nothing changes.
>> 2. HTTP grows more extensions; other protocols stagnate.
>> 3. HTTP grows extensions; other protocols get extensions but:
>>    a. only use them on explicit client configuration or
>>    b. try/fail/remember per-remote
>> 4. A backwards-incompatible protocol v2 is introduced, which
>>    hits alternate endpoints (with the same a/b as above).  This is
>>    different from 3. in that protocol v2 is explicitly designed around
>>    a capabilities negotiation phase rather than unilateral client-side
>>    decisions.
>> 5. Think of another way to make fetch performant with many refs, and
>>     defer the extension decision.
>
> I'd prefer 2,3,4 over 1,5.
>
> Speaking about 2,3,4:
>
> Maybe we can do a mix of 2 and 4:
>
>    1) HTTP grows more extensions; other protocols stagnate for now.
>    2) Come up with a backwards-incompatible protocol v2, foccussed on
>        capabilities negotiation phase, hitting alternative end points
>        (non http only, or rather a subset of protocols only)
>     3) if HTTP sees the benefits of the native protocol v2, we may switch
>         HTTP, too
>
> (in time order of execution. Each point is decoupled from the others and may
> be done by different people at different times.)
>

Today I rebased protocol-v2[1] and it was fewer conflicts than expected.
I am surprised by myself that there is even a test case for v2 already,
so I think it is more progressed that I had in mind. Maybe we can do 1)
for now and hope that the non http catches up eventually?


[1] https://github.com/stefanbeller/git/tree/protocol-v2
