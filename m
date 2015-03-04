From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Wed, 4 Mar 2015 11:10:21 -0800
Message-ID: <CAJo=hJupr=07+r6z5s9RiT_v2LYtdioiVS=yNfMag+mKfH9FhA@mail.gmail.com>
References: <xmqqsidtoojh.fsf@gitster.dls.corp.google.com> <CAGZ79kZE2+tCZgDzeTrQBn6JQv1OWJ7t_8j4kYMQgVaAbsnnxw@mail.gmail.com>
 <CACsJy8ASR-O-7tozw=p1Ek0ugct5EVZyWtxY_YA2nqcUV_+ECw@mail.gmail.com>
 <xmqqzj80l9c7.fsf@gitster.dls.corp.google.com> <xmqqioenhs4p.fsf@gitster.dls.corp.google.com>
 <CAGZ79kY6B4BLvLVS-J50SqCz+t9uGd93WHxCYKmRU1Ey3qVg+A@mail.gmail.com>
 <CAPc5daXJ6s2oNvqSmtp5d-Dgm-EX6Mb8kY2nOLQVxAT-3wjAmQ@mail.gmail.com>
 <CAGZ79ka8Zg86qqvWByNiP3F6a9QggO-bNY3ZZ9g+A-MdKYQ7NQ@mail.gmail.com>
 <xmqqioekawmb.fsf@gitster.dls.corp.google.com> <20150302092136.GA30278@lanh>
 <20150303103351.GA4922@lanh> <xmqqk2yy80mq.fsf@gitster.dls.corp.google.com>
 <CACsJy8B_r_0nP9NyKFBnr9bXgwjx8dJkSVkHbZw+Mxin_YpZZw@mail.gmail.com>
 <CAJo=hJtgda4ATtPeLWbhgDPiTm9h-gzBkpknxsOdRddueUgTbw@mail.gmail.com> <CACsJy8B=MN412dZYYc=NwpXHVz=Pxv+8wWMT7JNurVgqKrWn8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 20:10:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTEgy-0005Kz-Fq
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 20:10:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756764AbbCDTKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 14:10:43 -0500
Received: from mail-yk0-f171.google.com ([209.85.160.171]:36281 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755394AbbCDTKm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 14:10:42 -0500
Received: by yks20 with SMTP id 20so4083892yks.3
        for <git@vger.kernel.org>; Wed, 04 Mar 2015 11:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=wv2iCuPupQHS7NTJAr9wpGjkMSByHx+CU6iZwfSl5sM=;
        b=GN3s2m7+U1UHPSYl+14Bsl37QLZlbwP8Pm/SVvc8irL620zTmeKdzBGk+yT/avoP16
         pQm8NyuOXbCEshc/v9j4cjZ3RfjLpuU4Z292z1Pj9HkHpOAtcNtUyC+qbMLWuigocwDx
         7MtugWBzDWprPKMyz7YlG4951AUMf+YxErvGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=wv2iCuPupQHS7NTJAr9wpGjkMSByHx+CU6iZwfSl5sM=;
        b=FBpGx75zd0S+OqXZSJo451Un0Ryq53w6o2wHatmfxRMwXFYxYvXDJm4NrROy7pCUWO
         ZVYpPQUQUele6V9wV9KQeV+urIa0o20wRuGAvr/tZQwZJRvYA7tMC5+DAO+cllP57pUF
         TDE00L+BMP7MpjEDq4QfGFH1RVH7MenIMbWwrxBjdLj3JL2ZC+NOykIxNtIYbB90z47K
         h+bU8W2tA323cPdF8eOwqO4UeID8E6j89DqPA7lLn0JMPyChJG/odpLM5kVL0mRtHdAd
         2MMBP+kLQ/3u1QAyeHQOPdS1AMQMs3d2OsvEaxf+wZ2/D9OasNhRZgOvYjh2Tsh2mdnx
         GADg==
X-Gm-Message-State: ALoCoQmo/GRBmz+CN3+Bl11KrGASdVBV1QHvS4d3Sjinax1lXGT2A/VnnkQxLcd3g+csV4Fx555e
X-Received: by 10.170.190.69 with SMTP id h66mr4213803yke.51.1425496241842;
 Wed, 04 Mar 2015 11:10:41 -0800 (PST)
Received: by 10.170.39.19 with HTTP; Wed, 4 Mar 2015 11:10:21 -0800 (PST)
In-Reply-To: <CACsJy8B=MN412dZYYc=NwpXHVz=Pxv+8wWMT7JNurVgqKrWn8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264767>

On Wed, Mar 4, 2015 at 4:05 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Mar 4, 2015 at 11:27 AM, Shawn Pearce <spearce@spearce.org> wrote:
>> Let me go on a different tangent a bit from the current protocol.
>>
>> http://www.grpc.io/ was recently released and is built on the HTTP/2
>> standard. It uses protobuf as a proven extensibility mechanism.
>> Including a full C based grpc stack just to speak the Git wire
>> protocol is quite likely overkill, but I think the embedding of a
>> proven extensible format inside of a bi-directional framed streaming
>> system like HTTP/2 offers some good guidance.
>
> I'll take this as "learn from grpc, not just reuse grpc"

Correct, that was what I was trying to say and I just wrote it poorly.

HTTP 1.x, HTTP/2 and protobuf have proven themselves to be fairly open
to extension and working well in the wild for transports. There is
useful guidance there that we should draw from to try and leave doors
open for the future.

HTTP/2, protobuf and grpc are fairly complex. I consider any one of
them too complicated for Git specific use. However HTTP/2 is probably
the future of HTTP stacks so we may see it show up in libcurl or
something as popular as libcurl in another 10 years. Hg had some
reasonably sane ideas about building the wire protocol to work well on
HTTP 1.x upfront rather than Git tacking it on much later.

>> Network protocol parsing is hard. Especially in languages like C where
>> buffer overflows are possible. Or where a client could trivially DoS a
>> server by sending a packet of size uint_max and the server naively
>> trying to malloc() that buffer. Defining the network protocol in an
>> IDL like protobuf 3 and being machine generated from stable well
>> maintained code has its advantages.
>
> I'm still studying the spec, so I can't comment if using IDL/protobuf3
> is a good idea yet.
>
> But I think at least we can avoid DoS by changing the pkt-line (again)
> a bit: the length 0xffff means that actual length is 0xfffe and the
> next pkt-line is part of this pkt-line. Higher level (upload-pack or
> fetch-pack, for example) must set an upper limit for packet_read() so
> it won't try to concatenate pkt-lines forever.

pkt-line is a reasonably simple and efficient framing system. A 64 KiB
pkt-line frame only costs ~0.0061% overhead; ~0.0076% overhead if you
are a pack stream in a side-band-64k channel. That is probably more
efficient than HTTP/2 or SSL framing.

I see no reason to attempt to try and reduce that overhead further. 64
KiB frame size is enough for anyone to move data efficiently with
these headers. In practice you are going to wrap that up into SSH or
SSL/TLS and those overheads are so much higher it doesn't matter we
have a tiny loss here.

I think a mistake in the wire protocol was making the pkt-line length
human readable hex, but the sideband channel binary. _If_ we redo the
framing the only change I would make is making the side band readable.
Thus far we have only used 0, 1, 2 for sideband channels. These could
easily be moved into human readable channel ids:

  'd':  currently sideband 0; this is the application data, aka the pack data
  'p':  currently sideband 1; this is the progress stream for stderr
  'e':  currently sideband 2; there was an error, data in this packet
is the message text, and the connection will shutdown after the
packet.

And then leave all other sideband values undefined and reserved for
future use, just like they are all open today.

I am not convinced framing changes are necessary. I would fine with
leaving the sideband streams as 0,1,2... but if we want a text based
protocol for ease of debugging we should be text based across the
board and try very hard to avoid these binary values in the framing,
or ever needing to use a magical NUL byte in the middle of a packet to
find a gap in older parsers for newer data.


If you want to build a larger stream like ref advertisement inside a
pkt-line framing without using a pkt-line per ref record, you should
follow the approach used by pack data streams where it uses the 5 byte
side-band pkt-line framing and a side-band channel is allocated for
that data. Application code can then run a side-band demux to yank out
the inner stream and parse it.

It may be simpler to restrict ref names to be smaller than 64k in
length so you have room for framing and hash value to be transferred
inside of a single pkt-line, then use the pkt-line framing to do the
transfer.

Today's upload-pack ref advertisment has ~25% overhead. Most of that
is in the duplicated tag name for the peeled refs/tags/v1.0^{} lines.
If you drop those names (but keep the pkt-line and SHA-1), its only
about 8% overhead above the packed-refs file.

I think optimization efforts for ref advertisement need to focus on
reducing the number of refs sent back and forth, not shrinking the
individual records down smaller.


Earlier in this thread Junio raised a point that the flush-pkt is
confusing because it has way too many purposes. I agree. IIRC we have
0001-0003 as invalid pkt-line headers that could be used for special
markers in the stream.

For example we could use 0000 flush-pkt as "end of section" and define
0001 as "i am done speaking and now wait for you to reply".

I think we need to keep 0004 as "empty packet" in case we ever get
ourselves into a position where it makes sense to pass an empty string
from one end of the connection to another.


Running pkt-line inside of side-band-64k is... weird to read. IIRC we
only do that in the smart HTTP protocol to the remote-curl helper, and
this is where Junio's remarks about flush-pkt being confusing come
from. If we rewrote the protocol to have that explicit 0001 "i am done
talking" marker the helper wouldn't need the double framing to
understand how to break up the originally bidirectional packet stream
into a sequence of bursts sent on unidirectional HTTP 1.x.
