From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Summer of Code project ideas due this Friday
Date: Fri, 11 Mar 2011 21:27:50 +0700
Message-ID: <AANLkTinKnfiE9zQwYxfCX8VhRfgJhQopDbqBA+oQLL0w@mail.gmail.com>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com>
 <20110303185918.GA18503@sigill.intra.peff.net> <AANLkTinXZDq5FJxMmxUuWpCGgMYb3HH774eLJCojmnOz@mail.gmail.com>
 <20110303203323.GA21102@sigill.intra.peff.net> <20110309174956.GA22683@sigill.intra.peff.net>
 <AANLkTinpAOE06YX-m=ptQM_y-QMGpVmjewDxWopkXJkQ@mail.gmail.com>
 <20110309215841.GC4400@sigill.intra.peff.net> <4D7A1325.1090003@miseler.de>
 <20110311125259.GA777@LK-Perkele-VI.localdomain> <AANLkTin30fZURU-PxddSai5Qzfqjtwej=maGssyr2b7W@mail.gmail.com>
 <4D7A2D47.9010101@miseler.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>,
	Pranav Ravichandran <prp.1111@gmail.com>
To: Alexander Miseler <alexander@miseler.de>
X-From: git-owner@vger.kernel.org Fri Mar 11 15:28:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Py3KN-0006JU-7M
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 15:28:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096Ab1CKO2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 09:28:22 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33811 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395Ab1CKO2V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 09:28:21 -0500
Received: by wya21 with SMTP id 21so2455477wya.19
        for <git@vger.kernel.org>; Fri, 11 Mar 2011 06:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=yaloUMvEH0mo/gqx2yBmnQgztQLum78bLsm6aKFWptc=;
        b=HtJLyhobuHpE+ztgDocLFSWCxPrZDrgBn1MVraHgQ94Wm+9zzJK1bq3l6r5z1lXTCe
         jcJH3NZI15aXipxUTFWHffKm7SjDJl3HwL8C4CQ1Px5qlfJNgrLwI1/qL5As4/YA7Y1L
         UNRRLjoCu5hZfPiP7fPst77mxAs64l7iHMQLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=jQLseaeh0/Br3apS4cWhVP6obxYRMzTF2TNIAvgljiGUn4et0t2tDLE7Egpq6wNnwz
         wje2fHmhnztzGaAKzuNhLFXCsGsnl1VV8upb3RWrHCk7OS5xrENpDvqu3ACFigUS4PYa
         Z6nIz3U97h/6mfafT4YD2vum4tYe82bSGt0ak=
Received: by 10.216.123.69 with SMTP id u47mr8355139weh.16.1299853700175; Fri,
 11 Mar 2011 06:28:20 -0800 (PST)
Received: by 10.216.239.5 with HTTP; Fri, 11 Mar 2011 06:27:50 -0800 (PST)
In-Reply-To: <4D7A2D47.9010101@miseler.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168903>

On Fri, Mar 11, 2011 at 9:10 PM, Alexander Miseler <alexander@miseler.de> wrote:
> This may all be aiming to short. IMHO the best solution would be some
> generic way for the client to specify exactly what it wants to get and to
> get just that.

But how do you define "what it wants to get"? Pros and cons are
different and depend on that defintion.

Git's way of saying now is "I have these commits, give me these
branches (cutting at certain depth)". A near future extension would be
"I have these commits _restricted to these paths only_, give me...".
If it's broken half way, start again.

The bundle way is basically Git's way except that the remote side says
"I've got this bundle, fetch it here, then you can ask us again for
the rest in a normal way".

mirrorsync (aka gittorrent) says "I have this commit, give me objects
so that I can have this commit", which leaves the (probably) huge
initial commit out of view.

My way is "give me a chain of deltas starting from this SHA-1". A big
blob can be considered as a history of smaller pieces.

The last way of saying is just "give me this object", which would be a
big waste of bandwidth.

Your move :)
-- 
Duy
