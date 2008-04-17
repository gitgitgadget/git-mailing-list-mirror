From: "Ray Lee" <ray-lk@madrabbit.org>
Subject: Re: Reporting bugs and bisection
Date: Thu, 17 Apr 2008 12:35:12 -0700
Message-ID: <2c0942db0804171235o49238b99u6cdbd3e5c8d6ebb7@mail.gmail.com>
References: <47FEADCB.7070104@rtr.ca>
	 <9a8748490804161417n4ad6c1den54ccd302831a66c6@mail.gmail.com>
	 <48078323.4010109@davidnewall.com> <200804172109.35027.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "David Newall" <davidn@davidnewall.com>,
	"Jesper Juhl" <jesper.juhl@gmail.com>, sverre@rabbelier.nl,
	git@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	"James Morris" <jmorris@namei.org>,
	"Al Viro" <viro@zeniv.linux.org.uk>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"Willy Tarreau" <w@1wt.eu>, david@lang.hm,
	"Stephen Clark" <sclark46@earthlink.net>,
	"Evgeniy Polyakov" <johnpol@2ka.mipt.ru>,
	"Tilman Schmidt" <tilman@imap.cc>, Valdis.Kletnieks@vt.edu,
	"Mark Lord" <lkml@rtr.ca>, "David Miller" <davem@davemloft.net>,
	yoshfuji@linux-ipv6.org, jeff@garzik.org, netdev@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753856AbYDQTff@vger.kernel.org Thu Apr 17 21:59:04 2008
connect(): Connection refused
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753856AbYDQTff@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmZuA-0001oC-UG
	for glk-linux-kernel-3@gmane.org; Thu, 17 Apr 2008 21:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753856AbYDQTff (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 17 Apr 2008 15:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbYDQTfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2008 15:35:16 -0400
Received: from rv-out-0708.google.com ([209.85.198.240]:35321 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750976AbYDQTfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2008 15:35:13 -0400
Received: by rv-out-0506.google.com with SMTP id k29so105195rvb.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2008 12:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=D9lz66zWOZh5xj0ZygLKv8ZG+Rd0A/d3oot6Z8yfYyA=;
        b=Gb1z3HyC0Ffk+7h4am4Z3G4QAd3D4+JDpMc14LwUWxdbbCgV9MbW2DpJsXf+YkidhQM81wh/hJh3i0rjG4ZhxosX35+VihMzXyzBdljwZ7jDkKJknoTkN1qxALpY2NXzQoKO+MB1zWEnKQIIM7T2haHpxFlCY6X9/Ui+91SZksQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=oyLY7o7c8q+uPNWD6rVvOSgUFKoHdMWHBVsQu3ZzMWoAVthUPmVO/0dvInBf5vUTwmM0jx7W8Cv2qD1ZqmBD/TFje7oCpkB9n5kq8b7Bj5ZN7TpYH6IEBKMSWXfpCeoYE4LywWimsd+qpdEyhgYa7u7kNaM+iJTaAaysUiK542k=
Received: by 10.140.249.20 with SMTP id w20mr1067819rvh.21.1208460912584;
        Thu, 17 Apr 2008 12:35:12 -0700 (PDT)
Received: by 10.141.4.16 with HTTP; Thu, 17 Apr 2008 12:35:12 -0700 (PDT)
In-Reply-To: <200804172109.35027.rjw@sisk.pl>
Content-Disposition: inline
X-Google-Sender-Auth: 66781d05dec3790c
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79814>

On Thu, Apr 17, 2008 at 12:09 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>  > Finger-pointing, in these extreme cases, gives incentive to improve
>  > quality.  It's a positive thing.
>
>  Sorry, but I have to disagree.  Negative finger-pointing is never a good thing.

Correct, but let's be careful here. The original suggestion was,
effectively, to get better metrics on the quality of contributions.
Those metrics *could* be used for finger pointing, or (my preference)
they could be used to direct and allocate our scarce resources: code
reviews and mentoring.

There's no way to know what the metrics will tell us until we have
them. Arguing against metrics because they *may* be used to point
fingers at people is a silly argument; anything can be subverted to do
that.

Let's get some measurements and see what they say. In the meantime,
try to believe that they could be put to good purposes, such as
identifying code areas that are tricky for contributors to get right
(independent of contributor), or contributors that could benefit from
code reviews, etc.
