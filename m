From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Enhancements to git-protocoll
Date: Sun, 29 Jul 2012 22:20:43 -0700
Message-ID: <CAJo=hJvjFP0m96YPNBCwvnkRGWhMZQdbL7C3Shsa6HQ62a9FuA@mail.gmail.com>
References: <20120728214116.GA3591@paksenarrion.iveqy.com> <7vehnvvyta.fsf@alter.siamese.dyndns.org>
 <20120729142458.GB16223@paksenarrion.iveqy.com> <CAMK1S_iTv3BOV3LEoj83feuO2iQnPqTrOq0wyFC-GrvvJQqWTA@mail.gmail.com>
 <7vvch6uw89.fsf@alter.siamese.dyndns.org> <7vr4ruuu2e.fsf@alter.siamese.dyndns.org>
 <CAMK1S_geKq5DkNAy2wxGt5EmoOesxaSKKuQjVaQVcbRVdR+9gA@mail.gmail.com>
 <CAJo=hJsgMz-=pdG=HB3KtTE7g6Gvu9mr56dg2+V3WUST+rpAQg@mail.gmail.com> <7vehnut1kt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 07:21:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SviPz-0006vb-SD
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 07:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754030Ab2G3FVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 01:21:08 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:65194 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754009Ab2G3FVF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 01:21:05 -0400
Received: by ghrr11 with SMTP id r11so4439917ghr.19
        for <git@vger.kernel.org>; Sun, 29 Jul 2012 22:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cX1V8yxJtHDB4hUD53Jl/X2miv+fL+/HB06iaqGVqyw=;
        b=NyCw+zQ6kGnhlQzF4PPcXDUy0qAFRKWexb0hv7TYm06DUY7ASJBUD7WZD1X7XrZIDf
         p1WMCh9KHNuI5wzvFjRdkEmE32h1kgo30k0KYTJMof3u4HcRxTRzQHNKwyuVMB3ymxL3
         TRPZumcLyUUV5xOwPZ5OL2cdZMomIhnlsC+o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=cX1V8yxJtHDB4hUD53Jl/X2miv+fL+/HB06iaqGVqyw=;
        b=D8wuxsL9ui8Uy52xn8VWnUacOMA8MmV2mjWDg/y9/ZPc79nLWzo7Dt0VvrZUiItIL/
         2x9pNCebQkSoysruR1XAadPBbs5SC/kUF0nB5MBuxwQ83oK4sBTdnihkdcSCbgAECZlg
         jTvO5ORb9dkzGsQxx7xlFgAavlWw0KKtMage1+o+IPl13+cBA6mAzsb+ko9vVD4b2jaR
         EJDPecXL+E92INrsA3JZyMMO9QZSlC1+6Bi59rIRmHb9VoOJIxt4Oy+epeQ3+MJm14yv
         SfJCmKlQ+Lm8fiHHUgJEgSZT4WMETBmyOBPdHjOk2r4rVlS91+vVFFJmxsSDznc85uI2
         HAGQ==
Received: by 10.50.188.233 with SMTP id gd9mr10163929igc.73.1343625664104;
 Sun, 29 Jul 2012 22:21:04 -0700 (PDT)
Received: by 10.64.14.177 with HTTP; Sun, 29 Jul 2012 22:20:43 -0700 (PDT)
In-Reply-To: <7vehnut1kt.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQkQmIJ1/Ex2gGxbLdQPP3gCR8lzpDzBqkOuxIOPkrjY+ntlxCeEkHsuu2OreB1UDL1osMJe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202522>

On Sun, Jul 29, 2012 at 7:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
>
>> We sort of want this in Gerrit Code Review to pass reviewer names on
>> the command line of git push, making it easier for users to upload a
>> code review. The idea is similar to what happens with gcc accepting
>> linker flags that are just passed onto the linker.
>
> For reviewer names, authentication cookies and things of that nature
> where the extra pieces of information affect the outcome in a way
> that does not have to change how the underlying protocol exchange
> works, such an additional one-way channel from the pusher to pushee
> to carry auxiliary information would be sufficient.

Yes, that is what I was trying to argue. :-)

I agree that authentication information is outside of the Git protocol
itself. We rely on SSH authentication for SSH and HTTP native
authentication methods for HTTP transport. But at least in the HTTP
case, the Git client has learned how to set up the authentication data
for the user to make it easier to use HTTP authentication. We don't
yet support native OAuth 2.0 (ick!) or HTTP cookies as well as we do
client side SSL certificates or basic username/password pair.

If we want to support additional information from pusher to pushee,
this is a "native feature" of Git and should be supported on all
native push type transports, with roughly the same semantics
everywhere. I don't want to add additional data into X-Git-Foo HTTP
headers in HTTP, and as environment variables in SSH, for example.
Additional HTTP headers will *probably* transit an HTTP proxy
correctly (but there are a lot of broken proxy servers so I don't put
it past someone to strip an X-* header they don't think is "safe").
SSH environment variables are icky to set from the client, and server
side Git would need to know how it was invoked to decode the correct
data and make it available uniformly to repository owner authored
hooks.

>  The server may
> decide to accept otherwise forbidden, or reject otherwise permitted,
> push based on the extra information given, for example, and that is
> an example of an enhancement that does not have to change how the
> underlying protocol exchange works.

Yes.

> The way to expose the extra information parsed by Git to the server
> side could be made into calling out to hooks, and at that point,
> gitolite would not even have to know about the pack protocol.

Good point. The case that spawned this thread however still has a
problem with this approach. gitolite would need to create a repository
to invoke the receive-pack process within, and install that new hook
script into... when the hook was trying to prevent the creation of
that repository in the first place.

Maybe I am jaded by the way JGit handles the protocol, it is easy for
application code to glue into and see things going on in the protocol
in ways that are hard to do from git-core.

> Perhaps the interface to such a hook may be "hook can tell Git to
> abort the communication by exiting non-zero, after giving a message
> to its standard output".

Perhaps this new channel data is simply passed as arguments to
receive-pack on the remote side?

An ancient Git would abort hard if passed this flag. An updated Git
could set environment variables before calling hooks, making the
arguments visible that way. And gitolite can still scrape what it
needs from the command line without having to muck about inside of the
protocol, but only if it needs to observe this new data from pusher to
pushee?

`git push -Rfoo=baz host:dest.git master` on the client would turn
into `git-receive-pack -Rfoo=baz dest.git` in the SSH and git://
command line, and cause GIT_PUSH_ARG_FOO=baz to appear in the
environment of hooks. Over smart HTTP requests would get an additional
query parameter of foo=baz.


The other hacky idea I had was to use a fake reference and have the
client push a structured blob to that ref. The server would decode the
blob, and deny the creation of the fake reference, but be able to get
additional data from that blob. Its hacky, and I don't like making a
new blob on the server just to transport a few small bits of data from
the client.
