From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Summer of Code project ideas due this Friday
Date: Fri, 11 Mar 2011 20:48:14 +0700
Message-ID: <AANLkTin30fZURU-PxddSai5Qzfqjtwej=maGssyr2b7W@mail.gmail.com>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com>
 <20110303185918.GA18503@sigill.intra.peff.net> <AANLkTinXZDq5FJxMmxUuWpCGgMYb3HH774eLJCojmnOz@mail.gmail.com>
 <20110303203323.GA21102@sigill.intra.peff.net> <20110309174956.GA22683@sigill.intra.peff.net>
 <AANLkTinpAOE06YX-m=ptQM_y-QMGpVmjewDxWopkXJkQ@mail.gmail.com>
 <20110309215841.GC4400@sigill.intra.peff.net> <4D7A1325.1090003@miseler.de> <20110311125259.GA777@LK-Perkele-VI.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alexander Miseler <alexander@miseler.de>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>,
	Pranav Ravichandran <prp.1111@gmail.com>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Fri Mar 11 14:48:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Py2i3-0002c5-Ln
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 14:48:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496Ab1CKNsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 08:48:46 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63416 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753205Ab1CKNsp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 08:48:45 -0500
Received: by wya21 with SMTP id 21so2419208wya.19
        for <git@vger.kernel.org>; Fri, 11 Mar 2011 05:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=3vfjIgYYN3DcAZeSxoy6XsAFSx0TDVyNcmCrGDKL9Pg=;
        b=xZeIIUSP02eN38NLQ+ezAFbvv3UgnTf9PPceMCDmfvSTvo8d4LyxSjBwSqNHZRsBdk
         Vq5+B6CDVLpzsgxJwhwckS0pvBXDEZh2Umw5H21+ASpRWaAJRB2iBaybU2ElGAFgn9j5
         MjSRwM9sbYTZc2tSkdSIMNu6ofHmwBxCMs3Gs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Wxj68evBYpP2MnEmvXqxRuAa66S+SASWVga5KgIUkHCpxkaoM6NqORDAHvhYSlZ+ly
         +H3yXEvbi4gEgUfyYWBAPMEyOG2cy/nH93o6o1yBPVzoZ38mSd2AjSb1DBbrkH7Ug/el
         NfLnLIM0fPkxdNXhSnW1fO5BxcOipFyTqHnmY=
Received: by 10.216.87.8 with SMTP id x8mr8251290wee.46.1299851324116; Fri, 11
 Mar 2011 05:48:44 -0800 (PST)
Received: by 10.216.239.5 with HTTP; Fri, 11 Mar 2011 05:48:14 -0800 (PST)
In-Reply-To: <20110311125259.GA777@LK-Perkele-VI.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168899>

On Fri, Mar 11, 2011 at 7:52 PM, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> On Fri, Mar 11, 2011 at 01:18:45PM +0100, Alexander Miseler wrote:
>> On 09.03.2011 22:58, Jeff King wrote:
>> >If you have any ideas, please add them to the page! Whether you are
>> >available to mentor the project, or simply think it would make a good
>> >project and want to inspire others to mentor it, it's appropriate to go
>> >there.
>>
>
>> Resumable clone
>
> This is very very hard. Not so much to implement but to design the way it
> can be done without assuming things (like object sort orders) that aren't
> stable.

Yes it's hard. I have some experimental thing that nearly works [1],
although whether it is an acceptable approach is to be seen. If
anyone's interested, I'll post it some time

A simpler way to restartable clone is to facilitate bundles (Nicolas'
idea). Some glue is needed to teach git-fetch/git-daemon to use the
bundles, and git-push to automatically create bundles periodically (or
a new command that can be run from cron). I think this way fit in GSoC
scope better.

[1] The idea of my work above was mentioned elsewhere, history is cut
down by path. Each file/dir's history a very long chain of deltas. We
can stream deltas (in parallel if needed) over the wire, resuming
where the chain stops last time.

There are many problems. One is that a deep chain can make git run out
of stack, so chains have to be broken down before storing (not done).
Another one is that not many deltas can be reused, so it will consume
more power than normal clone. But once you clone this way, the cloned
repo have lots of delta suitable for another clone (but probably not
for anything else).
-- 
Duy
