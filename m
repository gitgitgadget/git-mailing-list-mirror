From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: Bug/problem with 1.6.0 on UnixWare
Date: Thu, 21 Aug 2008 15:38:32 +0100
Message-ID: <e2b179460808210738y9ca6e3fka113128fb1e6e024@mail.gmail.com>
References: <alpine.LNX.1.10.0808210522450.24713@xenau.zenez.com>
	 <e2b179460808210435w31b911a5ie6059b5628db8138@mail.gmail.com>
	 <alpine.LNX.1.10.0808210610440.29396@xenau.zenez.com>
	 <e2b179460808210541lfd7dcaeoea8554a2a76f8825@mail.gmail.com>
	 <20080821130816.GB22453@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Boyd Lynn Gerber" <gerberb@zenez.com>,
	"Git List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 21 16:41:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWBKY-0001dj-NO
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 16:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760155AbYHUOig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 10:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756480AbYHUOif
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 10:38:35 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:29830 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756649AbYHUOie (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 10:38:34 -0400
Received: by yx-out-2324.google.com with SMTP id 8so10067yxm.1
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 07:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=twAZNosPvgzC4opYPGI4SsHu1CG67g0/Ih2TekXtIZk=;
        b=pumLJRF5uy1lJfSpUXi/2YAx5zw6uJhl2gjOmSoYZtK4/3t1OoAPh2cKL7IT/NUZXq
         LA/mcdTunAtddt34drJaa/4Rgb5u9OhPr8GS4i+bNWWwfQYV66XT7BtYwK2RjTCfMi72
         xgYEfcg0y0T+zE3FRvaevKoN1c2uwAPTZ/7sY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=mhAes9fkW328uLAZVt+v/8jMObEsVdwEB7ZrmUGGqoxl9rWr99oQ5Soae805JJa3Gc
         l4rXULLcQwLBybJlJbX8gIcEvEplz81bcVJsUrx4Lus8GAua9Pv7RWhLoBD9tyySUVui
         ZZANJinh6cZ0ry324SzGsLybfhz6eS2g0/ee4=
Received: by 10.141.88.3 with SMTP id q3mr753499rvl.94.1219329512672;
        Thu, 21 Aug 2008 07:38:32 -0700 (PDT)
Received: by 10.141.19.11 with HTTP; Thu, 21 Aug 2008 07:38:32 -0700 (PDT)
In-Reply-To: <20080821130816.GB22453@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93158>

2008/8/21 Jeff King <peff@peff.net>:
> On Thu, Aug 21, 2008 at 01:41:07PM +0100, Mike Ralphson wrote:
>
>> You're very welcome to push tags describing the state of the build and
>> tests to http://repo.or.cz/w/git/gitbuild.git
>
> BTW, on my todo list is pushing my tags there. I am building FreeBSD
> nightly, and I plan to add Solaris 2.8. I just haven't gotten around to
> making the build work yet...:)

Great stuff. Though I think it might provoke some patches to improve
the display of multiple long tag names for the same commit in gitweb!

>> Personally, I'd like it if Junio could check to see if the 'satellite'
>> platforms are happily building and passing the last rc before he tags
>> a final release (with no additional code changes in it!), but that may
>> be too much of the tail wagging the dog.
>
> I think his procedure is more reactive. He tags 1.6.0-rc*, and he
> expects us to complain to him if it is broken.

Granted, but Junio seems to do releases at the weekend, and sometimes
they aren't the same content as the previous rc. Though I build and
test 7 days a week, I'd rarely look at the test results over the
weekend. And I was on vacation when the last minute AIX breakage went
into 1.5.6 - not that I would necessarily have been able to fix that
one.

Mike
