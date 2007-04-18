From: "Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>
Subject: Re: GIT vs Other: Need argument
Date: Wed, 18 Apr 2007 22:08:07 +0200
Message-ID: <8b65902a0704181308i41c878ebi88c03a929769ba39@mail.gmail.com>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
	 <20070417104520.GB4946@moonlight.home>
	 <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
	 <200704171818.28256.andyparkins@gmail.com>
	 <20070417173007.GV2229@spearce.org> <462521C7.2050103@softax.com.pl>
	 <Pine.LNX.4.64.0704181130150.12094@racer.site>
	 <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Marcin Kasperski" <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 22:08:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeGRq-0005R6-Vp
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 22:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512AbXDRUIK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 16:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753537AbXDRUIK
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 16:08:10 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:26070 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512AbXDRUII (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 16:08:08 -0400
Received: by an-out-0708.google.com with SMTP id b33so348832ana
        for <git@vger.kernel.org>; Wed, 18 Apr 2007 13:08:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Lt6lE7MuQomzW87OQQZLeTbdqvaj6J8SlTzhMn6ipEGW6nzcYWSiBHD3BdvnwzlR/Nugtd9yFShCJ25lzbYU5BEwsAneRAuoEC4MC4C9r4nCsN16JdGgkXj14YbM5JeZrhh6gViNqeRShvbA2p4rN2Ulei74Htr/9uUdTTRZ6aU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hn82FUiaGK2qZeam9cbOvZWjbnZeTJX+kLIzvibC4Ke/E+Tdp0XQ6Ga52THVmhvEER49CYonk3YiEgacxZTjjVlcMipLKRPYkIXfJBprjXlnttJ1DjGxatxsHffymZCrjWygPn38RkHUtN3tB5+rUf/vQj3PZoZ2qcnH+W5YAEk=
Received: by 10.100.124.5 with SMTP id w5mr700141anc.1176926887861;
        Wed, 18 Apr 2007 13:08:07 -0700 (PDT)
Received: by 10.100.44.7 with HTTP; Wed, 18 Apr 2007 13:08:07 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44937>

On 4/18/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> What _is_ true is that git is simply different from CVS. I don't think
> it's necessarily harder to understand or use (in fact, I would argue that
> git is a lot _easier_ to understand), but it is *different*, and it has a
> ton more capabilities.

Yes, but I think that, as Git has ton more capabilities, user has to
understand more things than with CVS.

I don't know lot of corporate teams, but here, our developers are
REALLY not motivated by VCS. It's only a way to share work. And I'm
not talking about concurrent modification: lot of people in my office
really think that the better model is the locked one.
These people won't be the guy who set up the repo. These people only
expect a system to:
- retrieve and merge the job done by other people
- archive their job for other people.
Nothing more. No interest for topic branches (they are simple minded
;-)), no interest for data integrity (it's "not their job"),
interested in problem with connected system ("hey, CVS server is down,
would you like a coffee while waiting IT detects that ?")...

So for such people, I really think raw Git is much more complicated
than CVS/SVN.

-- 
Guilhem BONNEFILLE
-=- #UIN: 15146515 JID: guyou@im.apinc.org MSN: guilhem_bonnefille@hotmail.com
-=- mailto:guilhem.bonnefille@gmail.com
-=- http://nathguil.free.fr/
