From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: windows smoke tester (was Re: What's cooking in git.git (Aug
 2010, #02; Wed, 11))
Date: Thu, 12 Aug 2010 22:29:51 +0000
Message-ID: <AANLkTimp5TSvjcmZG-pGtG6ep3axertqWuooS7e+A3Ow@mail.gmail.com>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
	<4C63BD9B.6000608@viscovery.net>
	<AANLkTi=9_FPS=zzcZ3ndqcd83KmQ-eVT9JmLbwjiZtXz@mail.gmail.com>
	<AANLkTi=N-fA9r-Akm3_=ucFYew8BhcsQoWM-Z9S8+58C@mail.gmail.com>
	<AANLkTina+62MczLNhXC6VCtz_kQZ_t0+uZ8fH=vTV=XO@mail.gmail.com>
	<4C64308D.8030000@gmail.com>
	<AANLkTikh14FVmE6E78FNRvSG0B_5ZmNcOLSwye4ExNVx@mail.gmail.com>
	<4C647360.50304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: kusmabite@gmail.com, Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Greg Brockman <gdb@mit.edu>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Elijah Newren <newren@gmail.com>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 00:30:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjgHf-0000oN-I6
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 00:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934036Ab0HLW3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 18:29:53 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47971 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760957Ab0HLW3w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 18:29:52 -0400
Received: by gxk23 with SMTP id 23so633573gxk.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 15:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=TVlMR5MZFqj8Xh71+1DbAbVfentXxHgd3qopk80jXUw=;
        b=gHzAW7V6WkeF4V4ng/sgQKyCPJjvhc48P4FmcVVdRqaFHch7cmiJhSw4T6b+KFQcE6
         yIEDY0xNKTs6pS0vofE3J+qkCvqnCzuw4ElD479WH82jPDznZ2xlVle39tijsG6uDb1i
         bVLmMww9lNrrNkmWTZu3RZC3lW/ZBbE4MdR6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=o1NiBtywE2VwU9Hqa7U3ZCFqamCZmK5k/EBhDo4AbDiGr6juKRExU0flKMsrrE2Yhb
         JfeK9eLepZS1s0m6XU6twBxzOkWC+s1ZjoulxSYcjrnvw3vx+SJL/9l6ub3sfBB2cSTs
         scosdFg3OXjJzy8Zf5C+6qJMxPhPhOqHqbhps=
Received: by 10.231.152.146 with SMTP id g18mr822602ibw.48.1281652191239; Thu,
 12 Aug 2010 15:29:51 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Thu, 12 Aug 2010 15:29:51 -0700 (PDT)
In-Reply-To: <4C647360.50304@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153435>

On Thu, Aug 12, 2010 at 22:19, Chris Packham <judge.packham@gmail.com> wrote:
> I checked out Avar's (Aevar?)

Whatever works :)


> branch One problem is that I don't have any of the perl TAP
> modules. It's complaining about TAP/Harness/Archive.pm. Any
> suggestions for installing additional perl modules under msysgit?

I don't know what msysgit does for perl but if you can make it use
strawberry perl's perl + modules that'd be easiest:

    http://strawberryperl.com

It comes with an easy-to use CPAN shell out of the box.

> Another problem is that the mingw sh.exe is _really_ slow (the box is an
> oldish Dell Latitude).

Odd that sh.exe is the slowest bit.

One thing (as the t/README notes) that'll make the tests much faster
is using a ramdisk for the trash directory, but I don't know if
Windows can do that.
