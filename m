From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [git-users] Highlevel (but simple to implement) commands provided
 by default for git
Date: Thu, 30 May 2013 13:00:02 +0530
Message-ID: <CALkWK0mU1XhsjNaQdvOC=Lq5ELgMKnL7ykH8wt8o6coST48Y6Q@mail.gmail.com>
References: <f611150e-a12a-47f6-97f0-8aaff3045338@googlegroups.com>
 <CAJri6_tm=tk6L1DT=A_BB25jm7b+2Uniw1uSCGtrY5_8X=t_hw@mail.gmail.com>
 <CAMP44s0Cx-FCZLOFZxcpC86sY+H03HKBi0nKFMgit=B5XCy71g@mail.gmail.com>
 <CALkWK0mBOB1RM+MXH+Nvos29M5vqc2yAtC__zPyowf7imfnz9Q@mail.gmail.com>
 <CAJri6_uScqjovt5eK9f9+Z4ehtsdYQNuiEX1MERiDBEJWueAXg@mail.gmail.com>
 <CALkWK0=5BwterP7ATM1GgFvLUs391w_MW4YrwbnvsbM6Q4_Opg@mail.gmail.com> <20130529234335.GE28153@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Br=C3=A1ulio_Bhavamitra?= <brauliobo@gmail.com>,
	git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 09:30:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhxJx-0000UH-1v
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 09:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967633Ab3E3Hap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 03:30:45 -0400
Received: from mail-bk0-f42.google.com ([209.85.214.42]:40654 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488Ab3E3Hao (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 03:30:44 -0400
Received: by mail-bk0-f42.google.com with SMTP id jk14so56010bkc.29
        for <git@vger.kernel.org>; Thu, 30 May 2013 00:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OAhjEuWtH0YUfRt88Kbc/VBqgOhqZdhzpV3XP2OO5Ac=;
        b=wXFJNOI1kRquHDI4LNftpcvqg2RENMiBylA3o2yvLXnat4SFNs+KRRkqvVPFw5WP5+
         Tb3tlw48XIz6eyjsaOjqQjP9xhRPVyqJjzWtRWAMNP4BRaTGyZQCFwYmhVgsT+LIY+YW
         3rR6xdtiPIkr5aGBgSQIgmD8HQvvzlPrIFXYPIjGC4BT5/kqYi2geslULdzxTd7clHXz
         YkzKMyo86mGWtw0ci0c0QgmwUfk0/m6FeWOtvi89MG+x5QR/MyApqJlvP4OlojVeo8J1
         1QlHkqJwRYJdVzds5NLr4JQ4h3X++6Z2NCwrxcVquuGE59++uIKl4Fg3CVfnCyhkQN/w
         e67g==
X-Received: by 10.205.8.67 with SMTP id or3mr1356293bkb.172.1369899042722;
 Thu, 30 May 2013 00:30:42 -0700 (PDT)
Received: by 10.204.172.209 with HTTP; Thu, 30 May 2013 00:30:02 -0700 (PDT)
In-Reply-To: <20130529234335.GE28153@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225943>

Jonathan Nieder wrote:
> That's detectable and could be made to error out, so it's not too bad.

Sure it's possible, but I'm arguing about whether it's worth the
effort.  There can be loops like a -> b -> c -> d -> e -> a.  Given
that nobody has even bothered to get git to print an error message
when a builtin command is overridden, do you think anyone will be
interested in this?

> A bigger problem (in my opinion) with allowing arbitrary changes to
> the meaning of existing commands is that scripts, whether placed in
> .sh files or given as commands to run over IRC, stop working
> altogether.  It's nice to have commands like "git log" and "git am"
> mean the same thing no matter what machine I am on.

Yeah, I agree with this to a large extent.  It's nice to have a
minimal set of unambiguous commands for the purposes of communicating,
and I'm quite happy with the present state of things.
