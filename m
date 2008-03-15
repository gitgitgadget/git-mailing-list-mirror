From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: About detached heads
Date: Sat, 15 Mar 2008 12:33:08 +1030
Message-ID: <93c3eada0803141903p30184defk979247129a1cc6db@mail.gmail.com>
References: <93c3eada0803140246k53408c74m21f9dc277857202d@mail.gmail.com>
	 <alpine.LFD.1.00.0803141041080.3557@woody.linux-foundation.org>
	 <20080314183731.GA2994@atjola.homenet>
	 <alpine.LFD.1.00.0803141150070.3557@woody.linux-foundation.org>
	 <m34pb9xgrp.fsf@localhost.localdomain>
	 <BAYC1-PASMTP1563DCF0556F09CFE67BE8AE0A0@CEZ.ICE>
	 <93c3eada0803141643r2f2c4c56l9e59f2ee7b67a8ca@mail.gmail.com>
	 <alpine.LFD.1.00.0803142025080.2947@xanadu.home>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Mar 15 03:03:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaLkT-0001zF-I0
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 03:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753315AbYCOCDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 22:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685AbYCOCDM
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 22:03:12 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:43829 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbYCOCDK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 22:03:10 -0400
Received: by fg-out-1718.google.com with SMTP id l27so451257fgb.17
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 19:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=qujeyIDtTBP0ksyTmayvEfY5kDXpVdXCa0s2gSkR+eA=;
        b=kgy3uvI0hCgb4lf0nv6mxsYV95wzRVdf1WNcxwfmejoaRjwCVTnYuc+Y7P7FiGBV+LB61rGY+XPQMepRK9C8jutR/lgOi3KZ3NcyzVxPbQhT0rGvAtRZ/kAECNjB2uwgTh83xyBRqkMpj5WHZPNO1s9npAHJ2vC+VE1/c99VN/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jByLS4n8taK5lWtmQTln5gvSh8RzklA8D5h6zcLuZuAzqBFT2fDn9FNa0f+R+zdlTbncY1Featsm/IfFotVbEyuM0tDRSulgzEG6HzADX2Qhz6QJxPyn7Doyw13p/UZqyaZErCPOUXkB9/DxoVzv6H5FKKbAdwwMi4kZ7A+fIGI=
Received: by 10.82.115.8 with SMTP id n8mr27863258buc.10.1205546589056;
        Fri, 14 Mar 2008 19:03:09 -0700 (PDT)
Received: by 10.82.114.1 with HTTP; Fri, 14 Mar 2008 19:03:08 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.00.0803142025080.2947@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77300>

On 3/15/08, Nicolas Pitre <nico@cam.org> wrote:
> ...
>
>         git reset --hard HEAD@{yesterday.at.4pm}
>
>  and it'll magically bring you back to the state you were yesterday at
>  4pm.  You need the 6pm state instead?  No problem: just ask for
>  yesterday.at.6pm then.
>
>  And before doing the 'reset --hard', you might want to do a simple
>  'checkout' beforehand so you can be sure it actually corresponds to what
>  you want:
>
>         git checkout HEAD@{yesterday.at.4pm}
>         [compile, test, whatever]
>         git checkout HEAD@{yesterday.at.6pm}
>         [compile, test, whatever]
>
>  and when OK with it, then:
>
>         # return to your master branch (or any other branch)
>         git checkout master
>         # then reset it to the desired state
>         git reset --hard HEAD@{yesterday.at.6pm}
>
>
>
>  Nicolas

More useful advice ... many thanks.

Cheers,
Geoff.
