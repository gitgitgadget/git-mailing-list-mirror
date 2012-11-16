From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] tcsh-completion re-using git-completion.bash
Date: Fri, 16 Nov 2012 21:04:06 +0100
Message-ID: <CAMP44s3S4c7ciJNurxGdS2o_TDJJDkGK73dtCGji+C1NoV+Jvw@mail.gmail.com>
References: <CAFj1UpHgPvdDeKZ-Ap7-aVx6p_pxT4a2F01ajmNa00txPyS=Qw@mail.gmail.com>
	<1352980269-15569-1-git-send-email-marc.khouzam@gmail.com>
	<CAMP44s0Guq0nYJEfbvNDyt8Oqaux-cXbTsyro6pxUnEpA4+XOw@mail.gmail.com>
	<CAFj1UpEdft+L5KW+tMy6Lqm1eUkHQgwWuXaC0UTUdqwW=ohk-Q@mail.gmail.com>
	<CAMP44s1RtOj6LKCNJ8SX8KSA8eNCMZ+4D-VfQ+WtXju-KhG8ng@mail.gmail.com>
	<CAFj1UpHLf2je_+b1e5B_5thZ03UYVmW=CWhAh63kNRCbke0kQw@mail.gmail.com>
	<CAMP44s1RvMSBu2RJqKw9ne4cJyMO4dbFc-gW2HgsN2-uviv=fA@mail.gmail.com>
	<CAFj1UpHMc-bHJgSZKY13YH_69TXkz-50g5xpLA6C+Eh0aqcN9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: szeder@ira.uka.de, git@vger.kernel.org
To: Marc Khouzam <marc.khouzam@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 21:04:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZS9J-0006Ca-PX
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 21:04:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350Ab2KPUEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 15:04:08 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:63123 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739Ab2KPUEH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 15:04:07 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so3163338obb.19
        for <git@vger.kernel.org>; Fri, 16 Nov 2012 12:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pom9xDAMthw07X6yx6lGw9jHIz6tC5tquSFkBqQJQZI=;
        b=THhVneirMYzvpgjFVjf3tMpzlmoL5DWRv9OZw6EyeoYMWY8ZX9DbDql8GaLQZq+OPi
         RidUa16DE+6SrOrm41zEYMb+waD/269c461A85T+C47d5zPXCPNRr/lQAt8AV0Ex8nRZ
         RaOXmmamSOZzql8ycAUCzQqFuVrwBsY2fpuEKBsiGqTG08EY1MJmeNxCIv5v1O9BHJ5l
         jzMjfo9ke1bWx8q/7GjuYsNLbiRtZhHIFahEpG56VfVyWqaf8V/liPKa6CmgiyAYk8mI
         XBeMBMWxeqJFrXPMLSTM7+uWoJBlTMZ34GDyVZ7M8AePuSfFTWD4vqV+vqkgEW9DTdBh
         nfgQ==
Received: by 10.60.32.19 with SMTP id e19mr4990445oei.9.1353096246738; Fri, 16
 Nov 2012 12:04:06 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Fri, 16 Nov 2012 12:04:06 -0800 (PST)
In-Reply-To: <CAFj1UpHMc-bHJgSZKY13YH_69TXkz-50g5xpLA6C+Eh0aqcN9A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209903>

On Fri, Nov 16, 2012 at 7:20 PM, Marc Khouzam <marc.khouzam@gmail.com> wrote:
> On Fri, Nov 16, 2012 at 12:18 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Fri, Nov 16, 2012 at 4:48 PM, Marc Khouzam <marc.khouzam@gmail.com> wrote:
>>> On Fri, Nov 16, 2012 at 10:33 AM, Felipe Contreras
>>> <felipe.contreras@gmail.com> wrote:
>>
>>>> Is it possible to just check if this is a login shell?
>>>
>>> I think it would be nice to allow the user to manually
>>> source git-completion.tcsh, in case they want to make
>>> manual modifications to it.
>>
>> Yeah, they could still do that... because they would be running in a
>> login shell.
>>
>> What I meant is that if the user does: tcsh
>> my_script_that_has_nothing_to_do_with_completion.sh, they would not be
>> executing this whole script.
>
> Oh, I see now.
>
> I can put a check in the script for the existence of the $prompt variable.
> This will indicate if it is a login shell or not.
> However, a good .cshrc file should already have such a check to avoid
> sourcing a bunch of useless things.  So, I personally think that we
> should not add it to the git-completion.tcsh script but let the tcsh
> user decide to do it herself.  But I don't mind being overruled :)

Sounds sensible to me.

>>> I think the most user-friendly option is to actually re-generate the
>>> script each time.  It feels wrong, but it works well :)
>>
>> I'm not too strongly opposed to add that function to the bash
>> completion, but to do it only for tcsh doesn't sound right, specially
>> when there are other alternatives.
>
> I agree, and this is why I made the proposed
> __git_complete_with_output () generic.  That way it could be
> used by other shells or programs.  But at this time, only tcsh
> would make use of it.
>
> If you think having __git_complete_with_output () could
> be useful for others, I think we should go with solution (A).
> If you don't think so, or if it is better to wait until a need
> arises first, then solution (C) will work fine.

I don't see how it could be useful to others, and if we find out that
it could, we can always move the code.

>> Correct me if I'm wrong, but very few people use tcsh.
>
> Less than I originally thought, when I started working
> on this patch :-\  But I'm still hoping that the those people
> will be a little happier with their git completion.

I think they would :) But we don't need to modify bash's script for
that (for now).

Cheers.

-- 
Felipe Contreras
