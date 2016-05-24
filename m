From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [Opinion gathering] Git remote whitelist/blacklist
Date: Tue, 24 May 2016 06:55:31 -0400
Message-ID: <84BDC4A4-FBE1-4542-868C-FA77A25469F3@gmail.com>
References: <1040142021.5607762.1463753271105.JavaMail.zimbra@ensimag.grenoble-inp.fr> <584027154.5608416.1463754104066.JavaMail.zimbra@ensimag.grenoble-inp.fr> <001001d1b2a3$06d7bbb0$14873310$@nexbridge.com> <1929221963.5686879.1464007899902.JavaMail.zimbra@ensimag.grenoble-inp.fr> <1884904685.12056.1464084750628.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org,
	matthieu moy <matthieu.moy@grenoble-inp.fr>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	wiliam duclot <wiliam.duclot@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>
To: Francois Beutin <beutinf@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue May 24 13:02:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5A6d-0005Sm-73
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 13:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbcEXLC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 07:02:26 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:37872 "EHLO
	mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbcEXLCZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2016 07:02:25 -0400
X-Greylist: delayed 409 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 May 2016 07:02:25 EDT
Received: by mail-it0-f49.google.com with SMTP id z123so8516610itg.0
        for <git@vger.kernel.org>; Tue, 24 May 2016 04:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xZUvadPrsiH5q/iZeV6jsRenmxIs65p2VJ0myeH1VZQ=;
        b=h+5gQNNQ1o6LjioIvlbYhqIW3dHAYZLXNLszBpWJc7S+U0gDYP8vauIayomgI4NF8h
         JEqbUpKtcuXkFPYX9jHw9J/SPySX/h21oLf452+UXL+2jvPAEhL9rUsu51Vl57TbOOcf
         6nkZ7NsU87tW0WLOtPH4S5XbTQItYewprYwWnB5QlvjeYd6SpS0a1haSgzZUnuVMLdAL
         ev7EaLTsraMj55mMmr5X3ZP2hUtal04BIL2d0t9CQ7C032DLNWO44VPg3xf2tJ0lo/OE
         vig+PGhf5k2W6b9zuwtSD8/jeu7zmzV3HZm/ZmcAkfBciR4Wdt6Sj31tVgMlz9d9/xD7
         iaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xZUvadPrsiH5q/iZeV6jsRenmxIs65p2VJ0myeH1VZQ=;
        b=WHi4tqJ0ofUOmmAOev2+P/qMaGKnB4ZSY/ELwjd7nZTtvtLsLsdwB384FvFZ9/I3+0
         naCcqmlw9c+B2k7ShmHf//hzY2XShbEQ6rzk0zsCZqOw3Cdkt+EvS/58WiHQwn3i8owG
         /V/ntrSZOz+tUCc0JGhZblA7MX5ldinoOJ7JJw/vSLdKcNtBoZT6TbwFQXWlHoiLF/UX
         hdH+S9aOZjgLrO218GUUOiDpKkK//XY2l/CTl/d36pZfTQc63BAk5DusjB+o1Mwt3+ps
         e+w116m9m7gf1sYucmY6zxLJDvuhV/0rHU1BWvZah8yktlUclkmXlhD0EQyjWEz0XJaV
         lepw==
X-Gm-Message-State: ALyK8tLj7o1RrUzd8FFs0hwSC6B28WlZc9j5UJ89diJTa4u+CmaFHNyxpRokWXKJvyKplg==
X-Received: by 10.36.127.1 with SMTP id r1mr11077022itc.52.1464087335384;
        Tue, 24 May 2016 03:55:35 -0700 (PDT)
Received: from rem20twn32.ads.autodesk.com ([132.188.72.187])
        by smtp.gmail.com with ESMTPSA id xo3sm934354igc.22.2016.05.24.03.55.33
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 03:55:34 -0700 (PDT)
In-Reply-To: <1884904685.12056.1464084750628.JavaMail.zimbra@ensimag.grenoble-inp.fr>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295484>


> On 24 May 2016, at 06:12, Francois Beutin <beutinf@ensimag.grenoble-inp.fr> wrote:
> 
>>>> On May 20, 2016 10:22 AM, Francois Beutin wrote:
>>>> We (Ensimag students) plan to implement the "remote whitelist/blacklist"
>>>> feature described in the SoC 2016 ideas, but first I would like to be
>>>> sure
>>>> we
>>>> agree on what exactly this feature would be, and that the community sees
>>>> an
>>>> interest in it.
>>>> 
>>>> The general idea is to add a way to prevent accidental push to the wrong
>>>> repository, we see two ways to do it:
>>>> First solution:
>>>> - a whitelist: Git will accept a push to a repository in it
>>>> - a blacklist: Git will refuse a push to a repository in it
>>>> - a default policy
>>>> 
>>>> Second solution:
>>>> - a default policy
>>>> - a list of repository not following the default policy
>>>> 
>>>> The new options in config if we implement the first solution:
>>>> 
>>>> [remote]
>>>> 	# List of repository that will be allowed/denied with
>>>> 					# a whitelist/blacklist
>>>> 	whitelisted = "http://git-hosting.org"
>>>> 	blacklisted = "http://git-hosting2.org"
>>>> 
>>>> 	# What is displayed when the user attempts a push on an
>>>> 		# unauthorised repository? (this option overwrites
>>>> 		# the default message)
>>>> 	denymessage = "message"
>>>> 
>>>> 	# What git should do if the user attempts a push on an
>>>> 		# unauthorised repository (reject or warn and
>>>> 		# ask the user)?
>>>> 	denypolicy = reject(default)/warning
>>>> 
>>>> 	# How should unknown repositories be treated?
>>>> 	defaultpolicy = allow(default)/deny
>>>> 
>>>> 
>>>> Some concrete usage example:
>>>> 
>>>> - A beginner is working on company code, to prevent him from
>>>> 	accidentally pushing the code on a public repository, the
>>>> 	company (or him) can do:
>>>> git config --global remote.defaultpolicy "deny"
>>>> git config --global remote.denymessage "Not the company's server!"
>>>> git config --global remote.denypolicy "reject"
>>>> git config --global remote.whitelisted "http://company-server.com"
>>>> 
>>>> 
>>>> - A regular git user fears that he might accidentally push sensible
>>>> 	code to a public repository he often uses for free-time
>>>> 	projects, he can do:
>>>> git config remote.defaultpolicy "allow"	#not really needed
>>>> git config remote.denymessage "Are you sure it is the good server?"
>>>> git config remote.denypolicy "warning"
>>>> git config remote.blacklisted "http://github/personnalproject"
>>>> 
>>>> 
>>>> We would like to gather opinions about this before starting to
>>>> 	implement it, is there any controversy? Do you prefer the
>>>> 	first or second solution (or none)? Do you find the option's
>>>> 	names accurate?
>>> 
>>> How would this feature be secure and made reliably consistent in managing
>>> the
>>> policies (I do like storing the lists separate from the repository, btw)?
>>> My
>>> concern is that by using git config, a legitimate clone can be made of a
>>> repository with these attributes, then the attributes overridden by local
>>> config on the clone turning the policy off, changing the remote, and
>>> thereby
>>> allowing a push to an unauthorized destination (example: one on the
>>> originally intended blacklist). It is unclear to me how a policy manager
>>> would keep track of this or even know this happened and prevent policies
>>> from being bypassed - could you clarify this for the requirements?
>>> 
>>> Cheers,
>>> Randall
>>> 
>>> -- Brief whoami: NonStop&UNIX developer since approximately
>>> UNIX(421664400)/NonStop(211288444200000000)
>>> -- In my real life, I talk too much.
>>> 
>> 
>> I agree that we cannot have a completly secure and reliable
>> way to forbid a push to the wrong remote. This is not what
>> our feature is trying to do, we assume that if a programmer
>> tweaks his config file and changes the rules he knows what
>> he is doing and we won't try to prevent it.
>> Our goal is to implement a safeguard against accidental push,
>> the feature will work only if the programmer wants it to.
> 
> 
> In the end we decided to implement the first solution described
> above.
> We chose this version because we think there could have been
> conflicts between the global and local config files. Moreover, we
> think using two different lists for denied/allowed remotes is more
> intuitive and user-friendly, and it will allow the user to use
> "advanced" options such as:
> denied = "http://git-hosting.org"
> allowed = "http://git-hosting.org/exception-repo"
> to deny a push to git-hosting.org EXCEPT to git-hosting.org/
> 						exception-repo
> 
> We are unsure about the behavior to adopt in case of a conflicting
> config file (for example a remote is in both the allowed and the
> denied lists). The programm would print a warning message and:
> 		- follow the defaultpolicy
> 	OR	- ask for confirmation
> 	OR	- reject the push
> As of now we are inclined to implement the "ask for confirmation"
> option.

First of all: thanks for picking up the idea and working on the feature!
I proposed the idea for GSoC and I am glad you CC'ed me because otherwise 
I would have missed that you are working on it :-)

As you already stated correctly to Randall: this "protection" can never
be completely secure as you can always override Git config settings. 
It is more a "hint" to protect inexperienced Git users. Therefore I would
make the default as conservative as possible. To answer your question,
I would reject the push (because the remote is in the denied list) and
print a warning to point out the conflicting configs to the user.

Cheers,
Lars
