From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: Re: Test fails on ubuntu breezy
Date: Sat, 15 Apr 2006 21:13:23 +0530
Message-ID: <cc723f590604150843v33a52bb4ocab5de0482effc92@mail.gmail.com>
References: <20060413115447.11819.qmail@science.horizon.com>
	 <7vpsjl1ezb.fsf@assigned-by-dhcp.cox.net>
	 <cc723f590604142347p7646aa40r52506a0d85b7d817@mail.gmail.com>
	 <7vbqv3jo77.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 17:43:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUmw8-0002bX-64
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 17:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbWDOPnY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 11:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbWDOPnY
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 11:43:24 -0400
Received: from wproxy.gmail.com ([64.233.184.226]:2833 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030273AbWDOPnY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 11:43:24 -0400
Received: by wproxy.gmail.com with SMTP id i11so389389wra
        for <git@vger.kernel.org>; Sat, 15 Apr 2006 08:43:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bO43tgV3o4naLsGWvvtBYZmg9p8W8JxLfO048txdM7iJWSIpi//UiJOCu2GZrR9fUCHo7geHCWGkfxraDLYU1CwINa4R87oSz1DT8M2fa0Irh9DI0nw2Hjk6psOga6vi2qA2Nh4bTrD1vvDWcFpU428YS19IkEgDSqR0NRNJUcM=
Received: by 10.64.3.9 with SMTP id 9mr188659qbc;
        Sat, 15 Apr 2006 08:43:23 -0700 (PDT)
Received: by 10.64.114.4 with HTTP; Sat, 15 Apr 2006 08:43:23 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vbqv3jo77.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18750>

On 4/15/06, Junio C Hamano <junkio@cox.net> wrote:
> "Aneesh Kumar" <aneesh.kumar@gmail.com> writes:
>
> > I am still having failure with the top of the tree. I guess it is
> > because git rm exit with status 0.
>
> Please don't guess, but validate (I know you are capable of
> doing so).
>
>

I did :). I sent another mail explaining it is xargs in breezy. I also
filed a bug. But they are not going to fix it in breezy. The below is
the response i got.

"As Ubuntu Breezy is a released probuct, only security-related fixes
are accepted. If you think this fix is important enough, you could
discuss the issue with the maintainers of Ubuntu backports, and see if
they are interested in making a backport available: "

Right now i am commenting out the test case to build the .deb file.

-aneesh
