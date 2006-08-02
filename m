From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] gitweb.cgi: Customization
Date: Wed, 2 Aug 2006 19:59:16 +1200
Message-ID: <46a038f90608020059w2d4567ve2043f2c7467dea3@mail.gmail.com>
References: <20060801225352.26998.qmail@web31801.mail.mud.yahoo.com>
	 <7v8xm8xbaa.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90608011913t777cf20dh9baaf355b19d18e6@mail.gmail.com>
	 <7v1wrzwpg5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 09:59:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8BdX-0002Tj-4k
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 09:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWHBH7S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 03:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWHBH7S
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 03:59:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:7428 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751220AbWHBH7R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Aug 2006 03:59:17 -0400
Received: by nf-out-0910.google.com with SMTP id o25so552631nfa
        for <git@vger.kernel.org>; Wed, 02 Aug 2006 00:59:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gCS+HdS6YAg9f9aaJZCY0K9iex3IN5EpIQkVza0r8dKyfZId6+okWhZRrXBCuO/UQjzi28vsFwQVQhbbLGu0Qg8UzB8Xs3FbxAd66dAPCZdWo5k9PC3xauVlQMILH+BZ5Kefs+Kh8WRLUV/2WizoBvBFGpez3SuG2sZMxcvr5rk=
Received: by 10.78.133.10 with SMTP id g10mr200134hud;
        Wed, 02 Aug 2006 00:59:16 -0700 (PDT)
Received: by 10.78.120.17 with HTTP; Wed, 2 Aug 2006 00:59:16 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v1wrzwpg5.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24638>

On 8/2/06, Junio C Hamano <junkio@cox.net> wrote:
> "Martin Langhoff" <martin.langhoff@gmail.com> writes:
>
> > I'm a bit lost as to gitweb config. Are we not relying on %ENV for
> > this stuff?
>
> It is Ok to use %ENV as an alternative way, but I'd rather not
> make it the _only_ way for basic configuration.  Not everybody
> runs Apache.

Ho-hum. And are those other webservers limited in their ENV-setting-fu? ;-)

I always thought that any webserver implementing CGI had reasonable
means of ENV manipulation, as that's the main mechanism for the
webserver to "configure" the CGI program.

But I'm definitely old-style and out-of-fashion in this.



martin
