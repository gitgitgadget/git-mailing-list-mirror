From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Thu, 22 Jul 2010 14:56:53 -0500
Message-ID: <20100722195653.GC4439@burratino>
References: <4C472B48.8050101@gmail.com>
 <AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com>
 <AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com>
 <AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com>
 <AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com>
 <4C4778DE.9090905@web.de>
 <AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com>
 <m31vavn8la.fsf@localhost.localdomain>
 <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 21:58:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc1u9-0007bR-H6
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 21:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754348Ab0GVT56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 15:57:58 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:63198 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676Ab0GVT55 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 15:57:57 -0400
Received: by ewy23 with SMTP id 23so3086210ewy.19
        for <git@vger.kernel.org>; Thu, 22 Jul 2010 12:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=oVTBnBZ75BleA9f4NBqkIcs0UccQN0tJ6auv4tvkD38=;
        b=w9A6aVHmR+rAp5nYd62Ig80fdeilDPxmDHvdMYtcN7O1bxOCjMSCQzFKcMh1p6hfKc
         xO9SX47cm+bI5YanhqB4xCb5ZWKfo1vaJaY8qRDXfaG0l7DkY+wmvrRVsJuLvEMIg+rV
         jZBdFIKJTHcKoO6i8jEa+RHMmOoFHCnFJpd4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DryTCtN0VLAsBwZ71XIVTEZDNxdEqveeWkCHYZVkTT9kfPhbcuWwvUzoHdkb/PmVip
         NPudY9DeEWN+W0YhRlUmgYabKKrZBXOIy80JMsKKdPU+A1sdOoo7pSPogxPJhs5DnFpU
         D+1GvO9H/QDjR3XKxw1bLbPrBEeVgPVVjn8NI=
Received: by 10.213.22.18 with SMTP id l18mr2253862ebb.85.1279828675035;
        Thu, 22 Jul 2010 12:57:55 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id v59sm55830766eeh.16.2010.07.22.12.57.51
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 22 Jul 2010 12:57:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151475>

Avery Pennarun wrote:

> Unfortunately everything built *on top of* Linus's file format
> contribution has turned out to be a disaster.

Aside: this kind of statement might make it unlikely for exactly
those who would benefit most from your opinions to read them.

Well, that is my guess, anyway.  I know that I have not found the time
to read your email (though I would like to) because I suspect based on
such sweeping statements that it would take a while to separate the
useful part from the rest.

Of course I am glad to see people thinking about these issues.
My comment is only about how the results get presented.

Jonathan
