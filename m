From: "Ray Lee" <ray-lk@madrabbit.org>
Subject: Re: Reporting bugs and bisection
Date: Thu, 17 Apr 2008 14:01:55 -0700
Message-ID: <2c0942db0804171401r2696884bq22540deaab40ef9b@mail.gmail.com>
References: <47FEADCB.7070104@rtr.ca>
	 <9a8748490804161417n4ad6c1den54ccd302831a66c6@mail.gmail.com>
	 <48078323.4010109@davidnewall.com> <200804172109.35027.rjw@sisk.pl>
	 <2c0942db0804171235o49238b99u6cdbd3e5c8d6ebb7@mail.gmail.com>
	 <20080417201657.GF27459@ZenIV.linux.org.uk>
	 <2c0942db0804171338p7bc7d9f2u8079c2f8c8998e76@mail.gmail.com>
	 <20080417205301.GG27459@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	"David Newall" <davidn@davidnewall.com>,
	"Jesper Juhl" <jesper.juhl@gmail.com>, sverre@rabbelier.nl,
	git@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	"James Morris" <jmorris@namei.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"Willy Tarreau" <w@1wt.eu>, david@lang.hm,
	"Stephen Clark" <sclark46@earthlink.net>,
	"Evgeniy Polyakov" <johnpol@2ka.mipt.ru>,
	"Tilman Schmidt" <tilman@imap.cc>, Valdis.Kletnieks@vt.edu,
	"Mark Lord" <lkml@rtr.ca>, "David Miller" <davem@davemloft.net>,
	yoshfuji@linux-ipv6.org, jeff@garzik.org, netdev@vger.kernel.org
To: "Al Viro" <viro@zeniv.linux.org.uk>
X-From: git-owner@vger.kernel.org Thu Apr 17 23:19:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmbFn-0001mi-5T
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 23:02:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753706AbYDQVB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 17:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753736AbYDQVB7
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 17:01:59 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:60944 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636AbYDQVB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 17:01:57 -0400
Received: by wx-out-0506.google.com with SMTP id h31so238649wxd.4
        for <git@vger.kernel.org>; Thu, 17 Apr 2008 14:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=p/xHiHz+wjbzWGplLeH3WbACyqUJwMLqAWN+ewXpdxo=;
        b=N72yXOvgIWO6fV+cT3EHWJ9Ka47DrfMuNNT95CLTv2YjQwj8QhNVYKn6aHKJnBOyJDODs4GD2kiLonLIYFyVsQIMFI0GaHATTXxrXTD/d5LoNAghuDs7iYQ/TR4Kk0CINbI4h/GgEUL0uvkIRWF+tDDiTRbhCDpxa5/tUlhghN8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=HpICrzgancxrZ/8fRc2/zzU0LA6fpjyjDwyRB1qr2mgm9kMG4HxpwmN/3BfhIRgRbaZ6YPffdGUvoYK4CQWQNC3J2g9Nl9bBWy2GY/XNJubw2Jy69yxAmcu6YtVDlcCmBpZjTyoukY46Pc7+w9VEmOnOxynlPd7MQnv1oGfnglc=
Received: by 10.141.115.6 with SMTP id s6mr1120104rvm.4.1208466116066;
        Thu, 17 Apr 2008 14:01:56 -0700 (PDT)
Received: by 10.141.4.16 with HTTP; Thu, 17 Apr 2008 14:01:55 -0700 (PDT)
In-Reply-To: <20080417205301.GG27459@ZenIV.linux.org.uk>
Content-Disposition: inline
X-Google-Sender-Auth: de53ac6975b019b4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79825>

On Thu, Apr 17, 2008 at 1:53 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Thu, Apr 17, 2008 at 01:38:18PM -0700, Ray Lee wrote:
>  > >         And frankly, that's the only thing that matters anyway; I suspect
>  > >  I'd do rather well by proposed criteria, but you know what?  I don't give
>  > >  a flying f*ck through the rolling doughnut for self-appointed PHBs and
>  > >  their idea of performance reviews.
>  >
>  > (Geez, conflate the issue much?) No one is saying you should. But
>  > also, I haven't seen anyone saying it'd be used for performance
>  > reviews other than you.
>
>
> || If there are individuals at whom a finger needs to be pointed, this
>  || system will highlight them, and fingers will (and should) be pointed.
>  || Contributors of poor-quality code need to be weeded-out.
>
>  in this thread (From: David Newall).

Ah, I failed reading comprehension, yet again. Well, sounds like you
have a beef to take up with David, then. That's still not an argument
against trying to gather statistics and to see if they're worth
anything.

>  > <shrug> Shame and Guilt, two major motivators of human behavior, it's
>  > true. But, one last time, *you're* the one saying the stats would be
>  > used for finger pointing at people.
>
>  Not really.  Unless you are trying to imply that David is my sock puppet, that
>  is...

Momentarily amusing to think so, but no :-).
