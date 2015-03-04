From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Tue, 3 Mar 2015 20:27:33 -0800
Message-ID: <CAJo=hJtgda4ATtPeLWbhgDPiTm9h-gzBkpknxsOdRddueUgTbw@mail.gmail.com>
References: <xmqqsidtoojh.fsf@gitster.dls.corp.google.com> <CAGZ79kZE2+tCZgDzeTrQBn6JQv1OWJ7t_8j4kYMQgVaAbsnnxw@mail.gmail.com>
 <CACsJy8ASR-O-7tozw=p1Ek0ugct5EVZyWtxY_YA2nqcUV_+ECw@mail.gmail.com>
 <xmqqzj80l9c7.fsf@gitster.dls.corp.google.com> <xmqqioenhs4p.fsf@gitster.dls.corp.google.com>
 <CAGZ79kY6B4BLvLVS-J50SqCz+t9uGd93WHxCYKmRU1Ey3qVg+A@mail.gmail.com>
 <CAPc5daXJ6s2oNvqSmtp5d-Dgm-EX6Mb8kY2nOLQVxAT-3wjAmQ@mail.gmail.com>
 <CAGZ79ka8Zg86qqvWByNiP3F6a9QggO-bNY3ZZ9g+A-MdKYQ7NQ@mail.gmail.com>
 <xmqqioekawmb.fsf@gitster.dls.corp.google.com> <20150302092136.GA30278@lanh>
 <20150303103351.GA4922@lanh> <xmqqk2yy80mq.fsf@gitster.dls.corp.google.com> <CACsJy8B_r_0nP9NyKFBnr9bXgwjx8dJkSVkHbZw+Mxin_YpZZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 05:28:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT0ue-0008CU-21
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 05:28:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758117AbbCDE1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 23:27:55 -0500
Received: from mail-yk0-f172.google.com ([209.85.160.172]:46840 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757985AbbCDE1z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 23:27:55 -0500
Received: by ykbq9 with SMTP id q9so3607928ykb.13
        for <git@vger.kernel.org>; Tue, 03 Mar 2015 20:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kxqu/KWbQDxA0qodlorRVm2UXxbQlRVSOjnMKisRwhc=;
        b=eCk+mhVPrOjISE1TO6hh5Vy/NqkpUf8F85hvY0uPoJfPeKrSI9p0i1MHNI4mH9nuxM
         RflhXPZVN1zRDqcAGsN2+UsJDXbNijYHjFB3WXNeN9Xhm267zl8dfKloxJj9CDAJXkYm
         6y/87M8P4SvOoeaKZvMnnUBQBh2zT6iItyoh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=kxqu/KWbQDxA0qodlorRVm2UXxbQlRVSOjnMKisRwhc=;
        b=OOs9Q5qwTWmKb74j4rvW5jbGPCRmSGBEw048RCWmL6OS8sjgfc1cg0UY+a7A00Cdmc
         TpxnxkVFza1kk0qQJzfbCm8T7lN2U9KG62eOqpd1IUnI+NIyZ3b43aLdp8Hl8Mv6I6Qu
         kj4DhUf9AgUcbUC7wg+aPT4c4AE+CKAyn92wnqNzPqNziDgHj0CE+95ZbybjS+FCyaoS
         Y3uY+B5qjCO8Gv3758bwxmCwXeACdfnU92/yiPulcB9IrQO/wAtEDNO15iFUrp12VD+P
         ZlKPds0bPCal4Y45xDVbFg76bFInj5qH9yWmt11ln425o7Ydbc6uGoJzFwykSAQINKRD
         MVsQ==
X-Gm-Message-State: ALoCoQlgR10FiVg9lNK7aweaDMaakJ/V8Lavh6MT8cA9k0ndMDr63hXuWjAKPpOjp+DI9EMsQOsW
X-Received: by 10.170.51.81 with SMTP id 78mr1663959ykt.93.1425443273782; Tue,
 03 Mar 2015 20:27:53 -0800 (PST)
Received: by 10.170.39.19 with HTTP; Tue, 3 Mar 2015 20:27:33 -0800 (PST)
In-Reply-To: <CACsJy8B_r_0nP9NyKFBnr9bXgwjx8dJkSVkHbZw+Mxin_YpZZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264719>

On Tue, Mar 3, 2015 at 5:54 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Mar 4, 2015 at 12:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> My recollection is that the consensus from the last time we
>> discussed protocol revamping was to list one capability per packet
>> so that packet length limit does not matter, but you may want to
>> check with the list archive yourself.
>
> I couldn't find that consensus mail, but this one [1] is good enough
> evidence that we can hit packet length limit in capability line
> easily.
> With an escape hatch to allow maximum packet length up to  uint_max, I

The symbolic ref thing was done badly. There isn't an escape hatch in
current v1 protocol sufficient to allow this but each ref should be
its own pkt-line, or should be a small batch of refs per pkt-line, or
the ref advertisement should be a data stream in a side-band-64k sort
of format inside the pkt-line framing.

At 64k per frame of side-band there is plenty of data to header ratio
that we don't need  to escape to uint_max.

> Looks like one cap per pkt-line is winning..

Yes.

> [1] http://thread.gmane.org/gmane.comp.version-control.git/237929


Let me go on a different tangent a bit from the current protocol.

http://www.grpc.io/ was recently released and is built on the HTTP/2
standard. It uses protobuf as a proven extensibility mechanism.
Including a full C based grpc stack just to speak the Git wire
protocol is quite likely overkill, but I think the embedding of a
proven extensible format inside of a bi-directional framed streaming
system like HTTP/2 offers some good guidance.

Network protocol parsing is hard. Especially in languages like C where
buffer overflows are possible. Or where a client could trivially DoS a
server by sending a packet of size uint_max and the server naively
trying to malloc() that buffer. Defining the network protocol in an
IDL like protobuf 3 and being machine generated from stable well
maintained code has its advantages.
