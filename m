From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/4] t4300 (rebase): don't unnecessarily set GIT_TRACE
Date: Fri, 10 May 2013 12:16:39 -0700
Message-ID: <20130510191639.GB3478@elie>
References: <1368196178-5807-1-git-send-email-artagnon@gmail.com>
 <1368196178-5807-5-git-send-email-artagnon@gmail.com>
 <7vmws2529j.fsf@alter.siamese.dyndns.org>
 <CALkWK0k_ArM9EpY0S7=mbgFpHsoauZCr9e=ESX_CEA5-vRHrHQ@mail.gmail.com>
 <7vr4he3kpz.fsf@alter.siamese.dyndns.org>
 <CALkWK0kLjf=m-_9PkXzxOpnpqfh-n004E0f7_mi-VL3SbYWFAg@mail.gmail.com>
 <7vk3n6206h.fsf@alter.siamese.dyndns.org>
 <CALkWK0kTvwxMFGUqH0wKNVpLg-qQQbN+vOcAxiEwmOeDe=87jA@mail.gmail.com>
 <20130510190705.GA3478@elie>
 <CALkWK0kZWrY5_B3mxuVV1cA-AqvkqJpjRAuSovXLi6OCA+3ybQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 21:16:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UasoD-0002x4-FO
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 21:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783Ab3EJTQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 15:16:45 -0400
Received: from mail-bk0-f44.google.com ([209.85.214.44]:60243 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279Ab3EJTQo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 15:16:44 -0400
Received: by mail-bk0-f44.google.com with SMTP id jk13so2182295bkc.17
        for <git@vger.kernel.org>; Fri, 10 May 2013 12:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=M0OCMdsT8lHJjciMlO4Gd2QHc1b4r3I95wFviXFat1E=;
        b=Xe3aR0E8J2wrSwzOkQe8Tlf4RPcV5ZmAkrfnVDcTDkM6vXtl/r6E40ATClV2z+7l04
         +qenFADvCqqTBUpWYG5B12g/rV/YuXF9ttI4l4c7HCidqUPOcaRYF8mnLjeb7dYAQy8q
         8fEc5YKXhClvKfy43j1h/7nq9QJ1hLYz6vc9pgd/gbHbKGeKilLKKOOgxhhuDRe5CUZV
         ulGMpzuo4Kep23mZy7sn/80pspPH1udirUKnDObJTDso8rxtHM3G6R/ZCpqG4R+Tar90
         n//dGmxo88lABNJL/TCWo270urszXmJ2haqcGAbBtDkJ1OZL5bekqQ/wdr9dgBiSa010
         i/8w==
X-Received: by 10.204.184.132 with SMTP id ck4mr4313612bkb.126.1368213403560;
        Fri, 10 May 2013 12:16:43 -0700 (PDT)
Received: from elie ([213.221.117.228])
        by mx.google.com with ESMTPSA id jz9sm1045284bkb.1.2013.05.10.12.16.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 10 May 2013 12:16:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0kZWrY5_B3mxuVV1cA-AqvkqJpjRAuSovXLi6OCA+3ybQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223898>

Ramkumar Ramachandra wrote:

>                           Can we do better by not printing the -v
> output of the passing tests though?

Not for my use.  The output from comprable tests before is often
useful for comparison.  I wouldn't be against such an option for
people who want it, though.

Thanks,
Jonathan
