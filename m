From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Fri, 27 Feb 2015 15:44:45 -0800
Message-ID: <CAGZ79kY6B4BLvLVS-J50SqCz+t9uGd93WHxCYKmRU1Ey3qVg+A@mail.gmail.com>
References: <1424747562-5446-1-git-send-email-sbeller@google.com>
	<CACsJy8BSf2h_xD-Q1tudAg_xCzffRQM+7xzUgprONxD7vM5RYw@mail.gmail.com>
	<CAPc5daVbrUaU6LFM65evru0+1tBT916+0AOyids=f7DZThTPGw@mail.gmail.com>
	<CAGZ79kbZHtZuPrb6rEP41vbdnZqJmsMwq+8pNer-_D4U5B1xZw@mail.gmail.com>
	<CACsJy8BN2imGCW0cueh-jGKfN_nRg3=J-GTX2P5h2z0Tu=id6A@mail.gmail.com>
	<xmqqsidtoojh.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZE2+tCZgDzeTrQBn6JQv1OWJ7t_8j4kYMQgVaAbsnnxw@mail.gmail.com>
	<CACsJy8ASR-O-7tozw=p1Ek0ugct5EVZyWtxY_YA2nqcUV_+ECw@mail.gmail.com>
	<xmqqzj80l9c7.fsf@gitster.dls.corp.google.com>
	<xmqqioenhs4p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 00:44:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRUaR-0001Mp-AF
	for gcvg-git-2@plane.gmane.org; Sat, 28 Feb 2015 00:44:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755341AbbB0Xor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2015 18:44:47 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:40970 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860AbbB0Xoq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2015 18:44:46 -0500
Received: by iecrd18 with SMTP id rd18so34974823iec.8
        for <git@vger.kernel.org>; Fri, 27 Feb 2015 15:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LGlw+XfFX8XkoIQ9Un3qeap92CqI0wNy5rPQHQTdylM=;
        b=ezwnmWTDdshKVm1RnDH+4ApThFFjgQPQh13E+TEtmkNg371eGmHaaIhTcq+WeuBtP7
         Dg67qjlFxEwUGkMC6UUC2OxbzQgpOtK3cYOLOxjGflY9G4gf//pUVjRAVPwcrv2Z36up
         st7g16MjEL38wWBAE/YqdSs59JIA7DpPeouuMYFe+ZLOvlXYa3HCd3YXVCQ2oWBq8Gg4
         aeIMLeOi9VKdtQA9pvzF7T9zSzHnygPVUJwFj9L3CabBL4ITyogAAvpP+NApcVmUfUAF
         ZSqkJaI7XImzlBg5prWw2hLpQ2DP7/Wqqtk+YknFRQgMZXdYriGqrNgOjR7CxZoI8o1T
         Y8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=LGlw+XfFX8XkoIQ9Un3qeap92CqI0wNy5rPQHQTdylM=;
        b=GLp9Skx3HDXK7yPCs8vQgHOp1r71zV9xLrl8S1D8/ZUOJZGRg+4msG3W31VjNXIH1q
         V7itx8Kpo8YleQYmw73BZk9JE78Q3om/G5zXjNQr+tijVa8nCcCKXwsIOGg02C4urjFa
         lsetwNZwtReBmIj3xRGK6LCKdvaXDHDpyUuH9bavZueuBBmPvUR8KpVNEB4cfZaXyxKv
         +Ri/FcfTu1inkt8kgOfCeyLkV0U3zX8F4nPtoHU9FVke4/e5AI6IzVyxH96wqzQl6aY/
         yVEsLowk2ahE1KdufK1eTq9WU/JnV9fLxOryHU0B62X+P47/6tUnja7OU+tovTjre1QK
         ++/g==
X-Gm-Message-State: ALoCoQmXT8cvD340uIIue+6sXRiw9njmB0+uj5SzB1Ye2SqRELw1JwaQRWUSr4IZBcF+reLE6r3k
X-Received: by 10.107.134.160 with SMTP id q32mr22475183ioi.70.1425080685475;
 Fri, 27 Feb 2015 15:44:45 -0800 (PST)
Received: by 10.107.46.31 with HTTP; Fri, 27 Feb 2015 15:44:45 -0800 (PST)
In-Reply-To: <xmqqioenhs4p.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264513>

On Fri, Feb 27, 2015 at 3:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> I do not think v1 can be fixed by "send one ref with capability,
>> newer client may respond immediately so we can stop enumerating
>> remaining refs and older one will get stuck so we can have a timeout
>> to see if the connection is from the newer one, and send the rest
>> for the older client", because anything that involves such a timeout
>> would not reliably work over WAN.
>
> Just for fun, I was trying to see if there is a hole in the current
> protocol that allows a new client to talk a valid v1 protocol
> exchange with existing, deployed servers without breaking, while
> letting it to know a new server that it is a new client and it does
> not want to get blasted by megabytes of ref advertisement.
>
> The idea is to find a request that can be sent as the first
> utterance by the client to an old server that is interpreted as a
> no-op and can be recognised by a new server as such a "no-op probe".
> If there is such a request, then the exchange can go like this with
> (new client, old server) pair:
>
>     - new client connects and sends that no-op.
>
>     - old server starts blasting the ref advertisement
>
>     - new client monitors and notices that the other side
>       started speaking, and the ref advertisement lacks the
>       capability bit for new protocol.
>
>     - new client accepts the ref advertisement and does the v1
>       protocol thing as a follow-up to what it already sent.
>
> As long as the first one turns out to be no-op for old server, we
> would be OK.  On the other hand, (new client, new server) pair
> would go like this:
>
>     - new client connects and sends that no-op.
>
>     - new server notices that there is already a data from the
>       client, and recognises the "no-op probe".
>
>     - new server gives the first v2 protocol message with
>       capability.
>
>     - new client notices thqat the other side started speaking, and
>       it is the first v2 protocol message.
>
>     - both sides happily speak v2.
>
> and (old client, new server) pair would go like this:
>
>     - old client connects and waits.
>
>     - new server notices that there is *no* data sent from the
>       client and decides that the other side is a v1 client.  It
>       starts blasting the ref advertisement.
>
>     - both sides happily speak v1 from here on.
>
> A misdetected case between (new client, new server) pair might go
> like this:
>
>     - new client connects and sends that no-op.
>
>     - new server accepts the connection, but that no-op probe has
>       not arrived yet.".  It misdetects the other side as a v1
>       client and it starts blasting the ref advertisement.
>
>     - new client notices that the ref advertisement has the
>       capability bit and the server is capable of v2 protocol.  it
>       waits until the server sends "sorry, I misdetected" message.
>
>     - new server eventually notices the "no-op probe" while blasting
>       the ref advertisement and it can stop in the middle.
>       hopefully this can happen after only sending a few kilobytes
>       among megabytes of ref advertisement data ;-).  The server
>       sends "sorry, I misdetected" message to synchronise.
>
>     - both sides happily speak v2 from here on.
>
> So the topic of this exercise ("just for fun") is to see if there is
> such a no-op request the client side can send as the first thing for
> probing.
>
> On the fetch side, the first response upload-pack expects are one
> of:
>
>   - "want " followed by an object name.
>   - "shallow " followed by an object name.
>   - "deepen " followed by a positive integer.
>
> And there _is_ a hole ;-).  The parsing of "shallow " object name is
> done in such a way that an object name that passes get_sha1_hex()
> that results in a NULL return from parse_object() is _ignored_.  So
> a new client can use "shallow 0{40}" as a no-op probe.
>
> It appears that on the push side, there is a similar hole that can
> be used. receive-pack expects either "shallow ", "push-cert" or the
> refname updates (i.e. two "[0-9a-f]{40}" followed by a refname); the
> parsing of "shallow " is not as loose as the fetch side in that
> using a "shallow 0{40}" as a no-op probe will end up causing
> prepare_shallow_info() sift the "0{40}" object name into "theirs",
> but I think it will be ignored at the end as "unreachable cruft"
> without causing harm.
>
> I am _not_ proposing that we should go this route, at least not yet.
> I am merely pointing out that an in-place sidegrade from v1 to a
> protocol that avoids the megabyte-advertisement-at-the-beginning
> seems to be possible, as a food for thought.
>


This is a fun thing indeed, though I'd personally feel uneasy with
such a probe as
a serious proposal. (Remember somebody 10 years from now wants to enjoy
reading the source code). So let's keep the idea around if we don't find another
solution.

As far as I can tell we have
* native git protocol (git daemon)
* ssh
* http(s)
* ftp (deprecated!)
* rsync(deprecated)

For both native git as well as ssh, Duy presented a solution at [1, 2]
a year ago,
which essentially presents the desired client capabilites 'out of
band' to the server
via an argument to the server.  So we'd only need to examine the
http(s) path how to
pass in arguments there.

Since 5 years an additional argument in the git protocol would cause
no harm, so it's
pretty safe to extend it with caution. We'd advertise the
client-may-ask-for-capabilities-out-of-band
per server and the client would eventually learn about it and only use
this for servers
which advertised they can do so. And nobody sane out there will
downgrade a version
of today to a git of 5 years ago.

I did rebase Duys' patches and I am trying to send out a patch series
today going that route
asking for comments.

Thanks a lot for the digging!
Stefan

[1] https://github.com/pclouds/git/commit/e26fa77c4d9ace06b9f2c80091af9eb7b63a1c95
[2] https://github.com/pclouds/git/commit/20d048e5fc650b20fdc7dd8bbe35cb8510ac9c50
