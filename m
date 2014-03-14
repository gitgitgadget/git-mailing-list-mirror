From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Fri, 14 Mar 2014 09:45:30 -0700
Message-ID: <CAJo=hJvy6KKMNT9iyZAnKy18Pa+rQkKPQtfqT1e+ddXoVwX0yg@mail.gmail.com>
References: <5110DF1D.8010505@alum.mit.edu> <CACsJy8BhL4qDb8BgOVuaUFF_9GXvgu55urYyKqPuZMZCTCoLwA@mail.gmail.com>
 <7v4nhpckwd.fsf@alter.siamese.dyndns.org> <CACBZZX6xLvuMEhPnfYLj8W9pMLwdoS7Zb+mTtn+3DanJPiWfXw@mail.gmail.com>
 <7vmwvh9e3p.fsf@alter.siamese.dyndns.org> <CACsJy8Aas3tRoDp9LQw7Nwf6+S3QnvwA7h7s-sHVY+1yFKhTYg@mail.gmail.com>
 <20140311014945.GB12033@sigill.intra.peff.net> <xmqqtxb4pm3u.fsf@gitster.dls.corp.google.com>
 <20140311200513.GB29102@sigill.intra.peff.net> <xmqq4n34pjnw.fsf@gitster.dls.corp.google.com>
 <20140311203650.GA31173@sigill.intra.peff.net> <CACsJy8AZ0CfqHRYDrnQD+z0ibVQnsFuSzktEHKRhCVwaXPQryg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 17:45:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOVF7-0007Qr-3P
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 17:45:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755570AbaCNQpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 12:45:52 -0400
Received: from mail-we0-f175.google.com ([74.125.82.175]:41679 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755031AbaCNQpv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 12:45:51 -0400
Received: by mail-we0-f175.google.com with SMTP id q58so2377415wes.34
        for <git@vger.kernel.org>; Fri, 14 Mar 2014 09:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PSbTI2qBYYPN5rVhPwr5ktgmDQsiuiSxu3OeJunIay8=;
        b=ZHlp6lmiTIpEuW6ifNVIzgXBDtXp7P1CueGPIWg2MUYnb9pPW5A2R9fWlszwPqx/+w
         HglRLVR0nozPgkVy4XdpknwZAdI4jbHjo5jXt6neqoLrOqQdcxA5CwyQ37LyTZFbIKi+
         TtmEMOE9Dpj9eXv8v+k8h2hgNkVSgBfpOneBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=PSbTI2qBYYPN5rVhPwr5ktgmDQsiuiSxu3OeJunIay8=;
        b=iKsdnX0d4uItp8PSyd3LoKlBtdLwD9Mhx7pSj8GuHuYVEdIhhxzdnM1P7KIGbWSVe8
         n7CIqkan16GnDfdtB9Ln1M8v7qrKEjUYpX1Xf5HYLEKPLa0mQFs66X7WXB/YKepprRxK
         Vyqrv+52yH/X+P+lTPumfauGDv8OCpjLTP4uBkV+maAy5XRCWiQc67VEnkscdL8lTL/k
         t3+MyJmYeyT4PJrk3WNOpM8/wqZFJocKBqBKgG4tw32TraRHTvfa7429ctVKjBAWNuk5
         8vxJWRgHNPTlXpXxAyIRdBkdW3T3EkMzlvIbosMVsnukTLpZDTAY0AxHGcEgig4coQhh
         T1/A==
X-Gm-Message-State: ALoCoQmOY0Ya+Bu9yPU7PrEEk/uIWHqxhIL4LxicjCFwy4BH2B53JQahEklp6dASZVkq/D7UpaQH
X-Received: by 10.194.241.132 with SMTP id wi4mr7458685wjc.14.1394815550538;
 Fri, 14 Mar 2014 09:45:50 -0700 (PDT)
Received: by 10.227.7.131 with HTTP; Fri, 14 Mar 2014 09:45:30 -0700 (PDT)
In-Reply-To: <CACsJy8AZ0CfqHRYDrnQD+z0ibVQnsFuSzktEHKRhCVwaXPQryg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244094>

On Fri, Mar 14, 2014 at 5:37 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Mar 12, 2014 at 3:36 AM, Jeff King <peff@peff.net> wrote:
>> If the client is limited to setting a few flags, then something like
>> http can get away with:
>>
>>   GET foo.git/info/refs?service=git-upload-pack&advertise-symrefs&refspec=refs/heads/*
>>
>> And it does not need to worry about upload-pack2 at all. Either the
>> server recognizes and acts on them, or it ignores them.
>>
>> But given that we do not have such a magic out-of-band method for
>> passing values over ssh and git, maybe it is not worth worrying about.
>
> git could go the same if we lift the restriction in 73bb33a (daemon:
> Strictly parse the "extra arg" part of the command - 2009-06-04). It's
> been five years. Old daemons hopefully have all died out by now. For
> ssh, I suppose upload-pack and receive-pack can take an extra argument
> like "advertise-symrefs&refspec=refs/heads/*" (daemon would use it too
> to pass the advertiment to upload-pack and receive-pack).

Heh. IIRC you are talking about the DoS attack for git-daemon where
you send an extra header and the process infinite loops forever? We
really don't want a modern client attempting to upgrade the protocol
with an ancient daemon to DoS attack that server.

> That would make all three not need to change the underlying protocol
> for capability advertisement. Old git-daemon, upload-pack and
> receive-pack will fail hard on the new advertisement though, unlike
> http. But that's no worse than upload-pack2.

You missed the SSH case. It doesn't have this slot to hide the data into.

>> Http can move to upload-pack2 along with the rest.
>
> Or maybe http may lead the rest to another way.
> --
> Duy
