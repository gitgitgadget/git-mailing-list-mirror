From: Matthieu Brucher <matthieu.brucher@gmail.com>
Subject: Re: git p4 clone not processing branches properly
Date: Fri, 5 Jul 2013 19:45:25 +0100
Message-ID: <CAHCaCkJDNqhd0UqnZhrA13V=J_yJBr17BuWohjMRADCPYFiQ4Q@mail.gmail.com>
References: <CAHCaCkJ+zRwu67QsYidmvcwtWtPPd4XPBYDaTnHLt9HrTSDM3A@mail.gmail.com>
	<CAHCaCk+8EehnwMP98EX=cdoyQof=zPj65Vyd_YaADVquztOYww@mail.gmail.com>
	<loom.20130705T195116-413@post.gmane.org>
	<CAHCaCkLpobqTOUMeK2TP_=VkjRo4P3-dMwt85_CaasSuRNE1Kg@mail.gmail.com>
	<CAOpHH-WAjjaa3oOXje3u5bBWb=vm-2wG1KYf8oKwH__XLK4R2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 05 20:45:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvB0c-0001EO-6u
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 20:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757580Ab3GESp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 14:45:26 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:43757 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241Ab3GESp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 14:45:26 -0400
Received: by mail-oa0-f41.google.com with SMTP id n10so3811755oag.0
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 11:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pGRRQZnEm02f0Bq6352PAuuSZWccPxC8/Su5TLlxyYs=;
        b=Fn2rOBxvkkxSfmNj/WLjqFYZ7DKjQcWw3B8KI1+wcq1DtmzUAe/Lay840G5RpaDDQT
         g6yU3a0ZUa2niyRlTndfsPD081cey+uHdwgBg905rs8k1QICEr3Jpvc5cXEJmz8u8Bdb
         4q62bx+yk0LQblEIcNy12tg0J8vY0EQIS2ujEiVsW0ncTRIl9JyZmRIxgoNUUOc68nUv
         7fuo4MqnCf7WHbhR/0N68fDoUL85WuDoymoBVCgFaXOBXHolljQf/GZlaW9wZRGk4JJm
         ScXo/d+qAMWVVuu79ZUcR3r2Dk49avhxCQCm7yAh8x0Y5YnDy15YdrImAloIZnSFrE8L
         87Kw==
X-Received: by 10.182.88.202 with SMTP id bi10mr12468973obb.91.1373049925528;
 Fri, 05 Jul 2013 11:45:25 -0700 (PDT)
Received: by 10.76.153.5 with HTTP; Fri, 5 Jul 2013 11:45:25 -0700 (PDT)
In-Reply-To: <CAOpHH-WAjjaa3oOXje3u5bBWb=vm-2wG1KYf8oKwH__XLK4R2A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229677>

>> I can try. Indeed, at this revision, the two other branches do not yet
>> exist. But @all will get everything? Last time, I only got head
>> (IIRC).
>
> Our P4 server has a limitation on the number of lines returned by "p4
> changes" command, so sometimes I have to use @change_start,@change_stop
> instead of @all. You might want to use this range limitation to test
> git-p4 by limiting to a small number of changelists that allows you to
> check if at least one branch is correctly detected.

I didn't know about this. I wanted to start the cloning at some point
in the past, that's why I used the @123456789 notation.

>>> Also, by using that command it means that the following depot paths must
>>> exist:
>>> //Depot/Project/Branch/Main
>>> //Depot/Project/Releases/2013
>>> //Depot/Project/Branch/Feature1
>>
>> Yes, they indeed do.
>
> In this case the problem should not be in branchList configuration.
>
>>> I've never used the --use-client-spec, so I'm not sure if that will not
>>> break the branch detection code.
>>
>> I need to do that because if I don't, the depot is clobbed with
>> binaries. Or perhaps if I put some .gitignore stuff, I might not do
>> this?
>
> Keep using it, at least for now. If everything else fails we can look at
> this again.

OK, I'll send a mail on Monday (forgot it was the week end tomorrow...)

Cheers,

Matthieu
--
Information System Engineer, Ph.D.
Blog: http://matt.eifelle.com
LinkedIn: http://www.linkedin.com/in/matthieubrucher
Music band: http://liliejay.com/
