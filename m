From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] send-email: Change from Mail::Sendmail to Net::SMTP
Date: Fri, 28 Apr 2006 13:04:32 +1200
Message-ID: <46a038f90604271804j195d62f3x93ae816e809f4ffd@mail.gmail.com>
References: <20060325235859.GO26071@mythryan2.michonline.com>
	 <1143336048205-git-send-email-normalperson@yhbt.net>
	 <46a038f90604251745u1b15ad99ka1aeff1cd8d8c344@mail.gmail.com>
	 <7vy7xsm6qa.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90604261324w76f272edp93941d7e8645be8@mail.gmail.com>
	 <20060428002744.GB9146@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>, git <git@vger.kernel.org>,
	"Ryan Anderson" <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Fri Apr 28 03:04:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZHPS-0005yw-F4
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 03:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965159AbWD1BEe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 21:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965167AbWD1BEe
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 21:04:34 -0400
Received: from wproxy.gmail.com ([64.233.184.228]:3053 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965159AbWD1BEe convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Apr 2006 21:04:34 -0400
Received: by wproxy.gmail.com with SMTP id i4so28158wra
        for <git@vger.kernel.org>; Thu, 27 Apr 2006 18:04:33 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fUc70uDhXdFT7XARlEiHoDAc/F4tkayd0XvQYpVmDRhMw4k1QnE0xPNdlljdf7LRmsqilJp0KIrFWcWQvmvxxoIp1kHi0OOGcYAmwry6nvr+wCjTCpVqM1DN7TymXxd4yWx6C+Xn8yjYalt8gaoNYNcIJrGyfJRoRfyUnSzDYVg=
Received: by 10.54.114.19 with SMTP id m19mr905655wrc;
        Thu, 27 Apr 2006 18:04:32 -0700 (PDT)
Received: by 10.54.127.4 with HTTP; Thu, 27 Apr 2006 18:04:32 -0700 (PDT)
To: "Eric Wong" <normalperson@yhbt.net>
In-Reply-To: <20060428002744.GB9146@hand.yhbt.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19259>

On 4/28/06, Eric Wong <normalperson@yhbt.net> wrote:
> You should be able to just open a pipe to:
>         /usr/sbin/sendmail @recipients
> and just write headers\nbody to that pipe.

Sounds reasonable. I just looked at what Mail::Sendmail does and it
isn't specially interesting. (There used to be a different Perl module
that did smart things, depending on what MTA it found, but I can't
find it now).

> Perhaps allow and detect --smtp-server=/path/to/sendmail ?

Oh, it should just work with sendmail if it's there and we don't
provide --smtp-server ;-)



m
