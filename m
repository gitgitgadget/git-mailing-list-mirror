From: "Jakub Narebski" <jnareb@gmail.com>
Subject: Re: [PATCH 19/19] gitweb: Remove creating directory for temporary files
Date: Sun, 27 Aug 2006 02:38:13 +0200
Message-ID: <8fe92b430608261738t16cd861brb78c8e78c2c58835@mail.gmail.com>
References: <200608240015.15071.jnareb@gmail.com>
	 <200608252135.27894.jnareb@gmail.com>
	 <7vpsen1eq3.fsf@assigned-by-dhcp.cox.net>
	 <7vwt8vyqij.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 27 02:38:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GH8fn-0000Nd-TS
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 02:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWH0AiO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 20:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWH0AiO
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 20:38:14 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:62291 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750782AbWH0AiN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Aug 2006 20:38:13 -0400
Received: by wx-out-0506.google.com with SMTP id s14so1272862wxc
        for <git@vger.kernel.org>; Sat, 26 Aug 2006 17:38:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F6qePaDArI5Tr5GLXr3ReBXvfAlaeDjXsizimBVP1rseC8bYEeys8khErOn/xVH9yRSsuP80qywj0TaORISFuPAZielX3hB9UY9pOqrqAjuP8XczfSqJ0o99dGtpZP9L23AYMkvYL821nJUmCvOnj/kzGhAKmgNJxJIOjcFQ1jc=
Received: by 10.90.79.6 with SMTP id c6mr832298agb;
        Sat, 26 Aug 2006 17:38:13 -0700 (PDT)
Received: by 10.90.72.1 with HTTP; Sat, 26 Aug 2006 17:38:13 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vwt8vyqij.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26077>

On 8/27/06, Junio C Hamano <junkio@cox.net> wrote:
> Junio C Hamano <junkio@cox.net> writes:
>
>>    "get-following" is inherently a very expensive operation, so
>>    I would suggest not doing this.  It seems that nobody uses
>>    these two subs yet, so probably it is better to yank them
>>    before they cause damages.
>
> A bit of clarification.  gitk has preceding/following but unlike
> gitweb it has three things that go in favor of having it.
>
>  - gitk can afford to use as much CPU as the user throw at it,
>    since it runs locally.
>
>  - gitk finds preceding/following in the background so the user
>    does not have to wait, and it is done while it gets the list
>    of commits which it needs to do anyway.

I wonder if we could AJAXize gitweb, and have _browser_ compute
preceding/following tags using some JavaScript...

That would be client side, could be in background, and could be cached. :-)
-- 
Jakub Narebski
ShadeHawk on #git
