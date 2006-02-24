From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Convert open("-|") to qx{} calls
Date: Fri, 24 Feb 2006 16:25:47 +0100
Message-ID: <81b0412b0602240725r38360ca4yf90dcb827ffeccfb@mail.gmail.com>
References: <Pine.LNX.4.63.0602231532470.29635@wbgn013.biozentrum.uni-wuerzburg.de>
	 <86hd6qgit5.fsf@blue.stonehenge.com>
	 <7v1wxuhsgw.fsf@assigned-by-dhcp.cox.net>
	 <863bi9hq6u.fsf@blue.stonehenge.com>
	 <Pine.LNX.4.63.0602232039160.30630@wbgn013.biozentrum.uni-wuerzburg.de>
	 <86lkw1g647.fsf@blue.stonehenge.com>
	 <20060223211403.GB5827@steel.home> <43FE9771.4030206@dawes.za.net>
	 <81b0412b0602240527v5d617111sc33e627ff3e1641c@mail.gmail.com>
	 <43FF185C.1080909@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 16:27:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCepM-0008Jj-UQ
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 16:25:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWBXPZt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 10:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWBXPZt
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 10:25:49 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:33752 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932258AbWBXPZs convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 10:25:48 -0500
Received: by nproxy.gmail.com with SMTP id c31so228815nfb
        for <git@vger.kernel.org>; Fri, 24 Feb 2006 07:25:47 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GhNCHvDAodtzCje2aScqBhhWuoyrEBRQIU6CaUZM/kTMz0MQXmj2tOq9NVUOWWKQWkhXhfFa+53m4FBzjvVaFF2KA1P6ktuVIifnZ3cdsfkUbh9NamF/L/N9NuGMOmT9ZfoK4RymHxilkA06YHchKwn+aX0T0KshfY4WL4jGX0I=
Received: by 10.48.244.12 with SMTP id r12mr2808273nfh;
        Fri, 24 Feb 2006 07:25:47 -0800 (PST)
Received: by 10.49.88.16 with HTTP; Fri, 24 Feb 2006 07:25:47 -0800 (PST)
To: "Rogan Dawes" <discard@dawes.za.net>
In-Reply-To: <43FF185C.1080909@dawes.za.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16707>

On 2/24/06, Rogan Dawes <discard@dawes.za.net> wrote:
> Interesting. I tried to do that one-liner at a DOS prompt (not cygwin,
> which I assume you are using), and I was unable to do so.

Yes, it was from cygwin's bash.

> Do you get the same results if you run it from a DOS prompt? and via a file?

Microsoft Windows 2000 [Version 5.00.2195]
(C) Copyright 1985-2000 Microsoft Corp.

C:\>perl -e 'print qx{echo joe & echo joe}'
Can't find string terminator "'" anywhere before EOF at -e line 1.
joe}'

C:\>perl -e "print qx{echo joe & echo joe}"
joe & echo joe

C:\>perl x.pl
joe & echo joe

C:\>
