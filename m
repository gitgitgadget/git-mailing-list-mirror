From: "Dave Hanson" <drh@drhanson.net>
Subject: Re: [ANNOUNCE] GIT 1.5.2
Date: Sun, 20 May 2007 06:47:46 -0700
Message-ID: <9fb1551c0705200647j50e38e6bi6faabff5938cf51@mail.gmail.com>
References: <7vsl9rq2u2.fsf@assigned-by-dhcp.cox.net>
	 <9fb1551c0705200646m62b61efegbae76e6f17b06799@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 15:47:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpllJ-0000wB-VW
	for gcvg-git@gmane.org; Sun, 20 May 2007 15:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756017AbXETNrs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 09:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755619AbXETNrs
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 09:47:48 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:32794 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756017AbXETNrs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 09:47:48 -0400
Received: by ug-out-1314.google.com with SMTP id 44so924517uga
        for <git@vger.kernel.org>; Sun, 20 May 2007 06:47:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=IekxyjZ+baBuITgjGf1ed87p57VEgwfDN3oKU13PHdZ9iNmf+z09vBy23EvuH9CP/2JlzoSNHZrnAC0tDXo+H8FCuuEDw6mPAYqpkn+QCEb7BS4neb904YvdgpDni9Oa1scZxosv6QOGFuceGDiwPA9+U6+WNXp4F9P64n3Q3rE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=m6W6EI7E99UJ94oUYDMsZdALsD2WchkhwztV0uS627WDY4XJU5wyY+ouUZGKUE+bwsh1+ssCKKCcSeXR/BNo6Rhrx1MLL4bUeGTMywOk2rO4ZAidjghA/EpQOUXHiUBRtbyEZXWfNripHKDgT4myGhbvfWwJ/ZjfyyJgehmSxV8=
Received: by 10.82.126.5 with SMTP id y5mr6383276buc.1179668866666;
        Sun, 20 May 2007 06:47:46 -0700 (PDT)
Received: by 10.82.107.19 with HTTP; Sun, 20 May 2007 06:47:46 -0700 (PDT)
In-Reply-To: <9fb1551c0705200646m62b61efegbae76e6f17b06799@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: dfbbe75dc63ff235
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47837>

ps: This error occurred only on the PowerPC; the build on the Intel
Mac worked fine.

On 5/20/07, Dave Hanson <drh@drhanson.net> wrote:
> When I try building git 1.5.2 on Mac OS X 10.4.9, using "make
> prefix=/usr/local", it fails with:
>
> $ git checkout v1.5.2
> $ make prefix=/usr/local
> ...
>     LINK git-http-fetch
> /usr/bin/ld: can't locate file for: -lexpat
> collect2: ld returned 1 exit status
> make: *** [git-http-fetch] Error 1
>
> But the build succeeds when I use:
>
> $ make configure; ./configure --prefix=/usr/local; make
>
> thanks,
> dave h
>
