From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: Suggestion: "man git clone"
Date: Thu, 21 Aug 2008 19:52:15 +0200
Message-ID: <36ca99e90808211052k5a67b7ccv7031c38d28f75f73@mail.gmail.com>
References: <48ACB29C.7000606@zytor.com> <48ACB5F4.3000905@sneakemail.com>
	 <48AD99DF.5090802@zytor.com>
	 <32541b130808211007xf295e40l567ecf785a8fca22@mail.gmail.com>
	 <48ADA467.1030407@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Avery Pennarun" <apenwarr@gmail.com>,
	"=?UTF-8?Q?\"Peter_Valdemar_M=C3=B8rch_(Lists)\"?=" 
	<4ux6as402@sneakemail.com>, flucifredi@acm.org,
	"Git ML" <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 19:57:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWELZ-00032I-4j
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 19:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbYHURwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 13:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbYHURwR
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 13:52:17 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:50592 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbYHURwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 13:52:16 -0400
Received: by an-out-0708.google.com with SMTP id d40so13645and.103
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 10:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=gjDl9BDTYZAx5NuLjzal4O3vfSOuIGx4QEg8SsDgls8=;
        b=tLpaacWU0qZ+P3r92mL+Lf9sBXSGR8UYEC0tZCqc4VTDX6fkGQzYXejTguvWF9AVjp
         sTh7s0Mox8jHwl/p2QVUF9W6/H+E1P3X/VlmXz1eaQHxBqbnuSnGqJfr0v2SbFm+0Z4w
         vmAYxLJ3z2BDyMa7NUGKwCgvGL/vSQIb7rw7M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=OL4H90iXGSUeAY4rFCgyh7KA/JVNZ6E49GeNatCarZ4KLoUXe2ByvFgJgKstGO7gy3
         RlLc/86za/M3rN11lSkp2jo+QPhlXAF38BDPrTXb7KjygyGi0Avpl3BKKFVuSkh3eo9A
         V8bylVNQN+0dz5InyAK0rmKM2+bL9gm3mBT2o=
Received: by 10.100.172.16 with SMTP id u16mr119024ane.50.1219341135705;
        Thu, 21 Aug 2008 10:52:15 -0700 (PDT)
Received: by 10.70.49.12 with HTTP; Thu, 21 Aug 2008 10:52:15 -0700 (PDT)
In-Reply-To: <48ADA467.1030407@zytor.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93183>

On Thu, Aug 21, 2008 at 19:22, H. Peter Anvin <hpa@zytor.com> wrote:
> Avery Pennarun wrote:
>>
>> [and I put him back...]
>>
>> Unfortunately what we don't have is a proposal that would work better.
>>  Also, changing the behaviour of 'man' wouldn't work on any platform
>> other than Linux (presumably), which means the git documentation
>> wouldn't be able to rely on that behaviour.
>>
>> Still, in a perfect world, what *should* man do in such a case?
>> Automatically open /usr/man/man1/git/clone.1?
>>
>
> That would probably be the best option, other options are $MANPATH/man1/git\
> clone.1 or $MANPATH/mangit/clone.git (I actually tried that on the
> assumption that it might treat "git" as a section; unfortunately, it didn't
> work.)
It works here. I have to add 'git' to the SECTION list in /etc/manpath.config.

Bert
>
>        -hpa
