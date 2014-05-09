From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v1 00/25] contrib: cleanup
Date: Fri, 9 May 2014 15:15:45 +0200
Message-ID: <CALbm-EYi2sQB5-x7AbivO5wfSfAt4=KRc347T+K3j-hmizCrrg@mail.gmail.com>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
	<CACPiFCJnsu3qw59oK94sP1u0+KBDvne0ZpKS0LMGc_9ge+rJjA@mail.gmail.com>
	<536c36fc8e04c_741a161d31095@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 15:15:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WikeU-0003kC-TU
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 15:15:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753862AbaEINPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 09:15:47 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:54003 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbaEINPq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 09:15:46 -0400
Received: by mail-wg0-f46.google.com with SMTP id n12so3974458wgh.5
        for <git@vger.kernel.org>; Fri, 09 May 2014 06:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/Ujjh4Jxwnkg/hSNxdyg3OCnbq/djYzyKR9un+Difig=;
        b=ArquDvZaimseBsWlRRNZKGHc+hmUyTiqFNpQCl7buWCu1c+P/IHeJs0P1pzU7dE+MM
         b4j2p8AjyHICntkiJEntFcIIdQVSxsnvDr2HIbXZNHs7kjzOeR1ILbBlYHLROtajBASp
         JPyMf3igWUY0yTpdZDDw2zczmAkGHyjLFpuD5s05WG6jG6XWqHZ3TMffl+TCnC0ga01M
         oc0c+C1UyqZ/c4aNbFCwVxDWpKH3UiqDe4Ms+yxokRe9qULNgx0PULg5/pw1LALtqe6P
         0s1yVIsLY3Zd7v1JO0jvj/0/Jm/aBdzOY5khECrlJCs/aDiVXnK5H4JTnKBRXd5Fl4jC
         tg7w==
X-Received: by 10.180.90.132 with SMTP id bw4mr3288527wib.43.1399641345567;
 Fri, 09 May 2014 06:15:45 -0700 (PDT)
Received: by 10.180.94.166 with HTTP; Fri, 9 May 2014 06:15:45 -0700 (PDT)
In-Reply-To: <536c36fc8e04c_741a161d31095@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248556>

For discussing these larger changes in the first version you may want to use
the -D option of git format-patch?

2014-05-09 4:01 GMT+02:00 Felipe Contreras <felipe.contreras@gmail.com>:
> Martin Langhoff wrote:
>> On Thu, May 8, 2014 at 8:58 PM, Felipe Contreras <felipe.contreras@gmail.com
>> > wrote:
>>
>> > Let us be honest, the vast majority of tools in 'contrib/' have no chance
>> > of
>> > ever graduating, so let's remove them.
>> >
>>
>> I am curious -- have you checked what parts of contrib downstreams
>> package&ship?
>
> I have checked a few, not throughly. From what I can see most of them
> just copy everything to /usr/share/git without much consideration to
> what is actually there.
>
> The only exception is the shell completions.
>
>> Are you planning on CC'ing the (inactive) authors/maintainers
>> so they know that if they care they should host those elsewhere?
>
> They are already Cc'ed.
>
>> My candid opinion is that you're trying to force a group of people to
>> undertake a pointless exercise. Contrib in many/most projects is uneven,
>> and folks know that. But it gives upstream a chance to push for some
>> minimal quality, and in turn it gives visibility to a bunch of sometimes
>> useful tools.
>
> Yes, but that's not what our contrib/ is supposed to be. Read
> conrib/README.
>
>> If my code was going to get the axe, I'd be rather pissed off. If Junio is
>> in agreement that code quality is bad, or tools should have unit tests,
>> then the push could be to address the problem or face removal. For example:
>> contrib maintainer, show you're responsive to bug reports on the list, or
>> face removal; add unit tests (or explain why they aren't needed) or face
>> removal.
>
> That's right, and they are Cc'ed so they can respond.  Some tools have
> only one commit or two, and in those I didn't even bother Cc'ing anyone.
>
> Moreover, it's not enough that they are actively maintained. Accoding to
> Junio they need to show that they can't work properly out-of-tree, and
> thus there's a need for them to be in contrib/. Or they are temporarily
> in contrib/ so they can become part of the core. That doesn't apply to
> the tools I proposed to remove here.
>
> --
> Felipe Contreras
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
