From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Reporting bugs and bisection
Date: Thu, 17 Apr 2008 21:57:06 +0200
Message-ID: <bd6139dc0804171257l5f875694yb57105ba40170789@mail.gmail.com>
References: <47FEADCB.7070104@rtr.ca>
	 <9a8748490804161417n4ad6c1den54ccd302831a66c6@mail.gmail.com>
	 <48078323.4010109@davidnewall.com> <200804172109.35027.rjw@sisk.pl>
	 <2c0942db0804171235o49238b99u6cdbd3e5c8d6ebb7@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	"David Newall" <davidn@davidnewall.com>,
	"Jesper Juhl" <jesper.juhl@gmail.com>, git@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"James Morris" <jmorris@namei.org>,
	"Al Viro" <viro@zeniv.linux.org.uk>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"Willy Tarreau" <w@1wt.eu>, david@lang.hm,
	"Stephen Clark" <sclark46@earthlink.net>,
	"Evgeniy Polyakov" <johnpol@2ka.mipt.ru>,
	"Tilman Schmidt" <tilman@imap.cc>, Valdis.Kletnieks@vt.edu,
	"Mark Lord" <lkml@rtr.ca>, "David Miller" <davem@davemloft.net>,
	yoshfuji@linux-ipv6.org, jeff@garzik.org, netdev@vger.kernel.org
To: "Ray Lee" <ray-lk@madrabbit.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753931AbYDQT5k@vger.kernel.org Thu Apr 17 22:21:13 2008
connect(): Connection refused
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753931AbYDQT5k@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmaFQ-00007S-QQ
	for glk-linux-kernel-3@gmane.org; Thu, 17 Apr 2008 21:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931AbYDQT5k (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 17 Apr 2008 15:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752686AbYDQT5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2008 15:57:10 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:62701 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644AbYDQT5H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2008 15:57:07 -0400
Received: by wf-out-1314.google.com with SMTP id 28so155788wff.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2008 12:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=/cDWvXgm+JORvCRAZ771BKy0YjQid7+H8XVPN924gvI=;
        b=GcX4y+h/r9F9g1PqJA9gWHv/GtYP3K735DicPTCJOGgj4+Zttn3dE9eOVWW+mzFqb+Sg0fUdXaV4KltlbXHpUsZBoPYd1VTZNazUWu4edMOx/iqL4rZSyGIJPbjpnX64XQ82CEBDD77sJh1BiP5y+9kSTEuDFcHq10UPxTLtOKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=weFurQfAl/FBVlkSJ4BxlUj/oF73u5vxAr/jHpxbla9yA8UrkwxIwDP/AQ9kxVe1b5965Q4qrreqOP6rM6zhSXf/1wWZta94wePTi29ZLQIfNOgQqvPzC5D8Vk/gi/oII4B0nWSD12aYiOVWxtDMojKPR8DcdrTmIQzAiKucdlk=
Received: by 10.142.203.13 with SMTP id a13mr517906wfg.224.1208462227111;
        Thu, 17 Apr 2008 12:57:07 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Thu, 17 Apr 2008 12:57:06 -0700 (PDT)
In-Reply-To: <2c0942db0804171235o49238b99u6cdbd3e5c8d6ebb7@mail.gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79817>

On Thu, Apr 17, 2008 at 9:35 PM, Ray Lee <ray-lk@madrabbit.org> wrote:
> On Thu, Apr 17, 2008 at 12:09 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>  >  > Finger-pointing, in these extreme cases, gives incentive to improve
>  >  > quality.  It's a positive thing.
>  >
>  >  Sorry, but I have to disagree.  Negative finger-pointing is never a good thing.
>
>  Correct, but let's be careful here. The original suggestion was,
>  effectively, to get better metrics on the quality of contributions.
>  Those metrics *could* be used for finger pointing, or (my preference)
>  they could be used to direct and allocate our scarce resources: code
>  reviews and mentoring.

Exactly!

>  There's no way to know what the metrics will tell us until we have
>  them. Arguing against metrics because they *may* be used to point
>  fingers at people is a silly argument; anything can be subverted to do
>  that.

Thank you, that should have been said before, you worded it perfectly.

>  Let's get some measurements and see what they say. In the meantime,
>  try to believe that they could be put to good purposes, such as
>  identifying code areas that are tricky for contributors to get right
>  (independent of contributor), or contributors that could benefit from
>  code reviews, etc.

This especially is an area that I plan to focus on and should be very
reliable when finished. As can be read in my application, I plan to
look at how often a piece of code is changed, in what timespan and by
how many different authors.

Thanks for the reply!

Cheers,

Sverre
