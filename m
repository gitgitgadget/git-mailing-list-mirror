From: Bryan Larsen <bryan.larsen@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Fri, 23 Jul 2010 12:05:11 -0400
Message-ID: <4C49BDB7.3080805@gmail.com>
References: <4C472B48.8050101@gmail.com> <AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com> 	<AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com> 	<AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com> 	<AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com> 	<4C4778DE.9090905@web.de> <AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com> 	<m31vavn8la.fsf@localhost.localdomain> <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com> <4C49B0E9.1090300@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Jul 23 18:05:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcKkW-0002cc-PW
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 18:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759921Ab0GWQFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 12:05:19 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39585 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756359Ab0GWQFR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 12:05:17 -0400
Received: by gwb20 with SMTP id 20so718577gwb.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 09:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=fcYTYb74RMbwyWYkN5dVVZTgpXEGvnsVV65fG7FcLXw=;
        b=AfKrRi9Ok6kQ21R64JT3sAko9tvErXRUjEUO23e9L6xJ2zHKvJI9QYQfCgdCtujcDY
         TAwn19N0hRugiXH6o6RTL5wJ229OENGAKok1RtihdBbWn5CeaeQ3PJo/jwYl4Ku0B1wC
         cGb0M5aHcXTycQr+hXW2GHNkVE4MvcR9dy9+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=g+i/jhQuunowTj1DUWOYvnTwp7ao5uiKQSKIbw3GFxeV2NQgQnJVZh7lwZjgkdovsF
         yc+fk3O9ZLcq/PBowIUmRdqIrk3R06LBuE4Hg9dyN4nsKegrG1tqbSGThKoCDkj241gm
         oiDeBJ/F3ZmFbRdYfc311nhYKnMMBC0PI0veA=
Received: by 10.101.95.9 with SMTP id x9mr4287699anl.36.1279901115795;
        Fri, 23 Jul 2010 09:05:15 -0700 (PDT)
Received: from [192.168.1.102] (76-10-182-75.dsl.teksavvy.com [76.10.182.75])
        by mx.google.com with ESMTPS id n20sm349507ibe.17.2010.07.23.09.05.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 Jul 2010 09:05:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100528 Thunderbird/3.0.5
In-Reply-To: <4C49B0E9.1090300@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151545>

On 10-07-23 11:10 AM, Jens Lehmann wrote:
> Am 22.07.2010 21:41, schrieb Avery Pennarun:
>> I create an app named myapp on github:
>>
>>     git://github.com/apenwarr/myapp
>>
>> It uses 17 different ruby gems, which I import as subprojects.  I have
>> two choices:
>>
>> [1] .gitmodules can use absolute paths to the original gem locations:
>>
>>     git://github.com/rubygems/gem[1..n]
>>
>> [2] Or else I can fork them all and use relative paths in .gitmodules:
>>
>>     ../gem[1..n]
>>     translates to -->  git://github.com/apenwarr/gem[1..n]
>
> You forgot what we do as best practice at work:
>
> [3] Fork the gem repos on github (or another server reachable by your
>      co-workers) and use those, so you don't have to change the URL
>      later:
>
>      git://github.com/apenwarrrubygems/gem[1..n]
>
> Your problems go away, setup has to be done only once on project
> start and not for every developer, you can use your own branchnames
> and you have a staging repo from where you can push patches upstream
> if necessary.

What's best practice for open source projects?   I do this, but nobody 
except my coworkers can push to my forks, so it's a huge rigamarole just 
to get a fix into a submodule.

>
> That is just one example. Another one is code shared between
> different repos (think: libraries) where you want to make sure that
> a bugfix in the library made in project A will make it to the shared
> code repo and thus doesn't have to be fixed again by projects B to X.
> This was one of the reasons we preferred submodules over subtrees
> in our evaluation, because there is no incentive to push fixes inside
> the subtree back to its own repo like there is when using submodules.

But you stated above that each project has its own fork of the library. 
   So there's no special incentive to push changes from the fork back to 
its master repo.

>
>
>>>> It's very clear that git-submodule's current behaviour totally
>>>> mismatches the entire git philosophy.  That's why it's so impossible
>>>> to make the git-submodule command usable.
>>>
>>> That's very strong accusation.
>>
>> Agreed... but that doesn't make it wrong :)
>
> But calling a feature "impossible to make ... usable" is an
> interesting thing to say about a feature lots of people are
> using productively in their daily work, no? ;-)

In my experience, it's possible to make it usable if and only if:

1.  you have a small team
2.  all of whom are very comfortable with git
3.  changes inside submodules are either infrequent or only happen in a 
single direction
4.  the project is not public/open source

I think #4 is the killer reason why submodules don't work.  It works 
fine if the submodule is fairly independent, but if you have a patch to 
the submodule that was created for and in the context of the 
superproject, things get really annoying really quickly.

Bryan
