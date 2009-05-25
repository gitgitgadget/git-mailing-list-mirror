From: Tim Uckun <timuckun@gmail.com>
Subject: Re: can anybody explain the following to a git noob?
Date: Tue, 26 May 2009 00:52:29 +1200
Message-ID: <855e4dcf0905250552r27e73a15tc06dbd9fa1cbb507@mail.gmail.com>
References: <855e4dcf0905212046o3e1d6ec6l487829a0a411dcaf@mail.gmail.com>
	 <32541b130905212202q9aed54cn892171b7e654812f@mail.gmail.com>
	 <855e4dcf0905212244r454a5c21w7bdbfb566a28efb8@mail.gmail.com>
	 <4A1671E5.4030400@op5.se>
	 <855e4dcf0905220335n367a065fidc65567119c0a5a3@mail.gmail.com>
	 <4A16822A.2060404@viscovery.net>
	 <855e4dcf0905220436h1b6fa632q7804c98bf09b324c@mail.gmail.com>
	 <alpine.LNX.2.00.0905221244370.2147@iabervon.org>
	 <855e4dcf0905230121h28ef22f8n4758953e612325cf@mail.gmail.com>
	 <20090525111059.GE1070@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Andreas Ericsson <ae@op5.se>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon May 25 14:52:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8ZfS-0005VN-MO
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 14:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbZEYMwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 08:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbZEYMwa
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 08:52:30 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:33107 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbZEYMw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 08:52:29 -0400
Received: by gxk10 with SMTP id 10so5548732gxk.13
        for <git@vger.kernel.org>; Mon, 25 May 2009 05:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/1WAC71jyKAU0Yya9fuHHpNcat+TIOqI2g7NiOzb1jg=;
        b=Pzw/M+EFYjlWdHGfBB8cbOJXSkjabUHp/MqKzPv2ORVW8CVqdaOu2XR92u0dSfreeO
         6Lp6PlwMsHEImbDe6iv23kkBiVQII39g7jmDiigW9JG9POwyXmWveCBegM0pi5GA15Wl
         gYo9B1U13PYrzo8tTKVDLLXLDZwHcF09eJbFA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=k2LebNEMSHzWM1SZS+IYln9pteWmAa11fT2T9DChgQchO6F/kdpsK4JQPjCDiTH2Br
         le4ZiPjhCUlaWoueANb8owkIF545M7ii0uLecbWExRp0WP0fv7wtP4RNS8RuaqIT5i1x
         /zf5yCENaQlf2RTvG2NB2vz8CR9coBEFeXtAI=
Received: by 10.90.69.15 with SMTP id r15mr6293376aga.74.1243255949888; Mon, 
	25 May 2009 05:52:29 -0700 (PDT)
In-Reply-To: <20090525111059.GE1070@macbook.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119933>

>
> Note that a second git init does not delete the previous database. So if
> you want to start from scratch you need to delete the main .git folder.

Yes of course.


> As already mentioned a script recreating your setup from public sources
> would really be a big help to find out were git does not do what you are
> expecting.
>

OK. I'll give that a shot.

I would still like to know what went wrong with my own sources though.
 After all I am going to be using it with my own sources.
