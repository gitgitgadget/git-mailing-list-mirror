From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] tcsh-completion re-using git-completion.bash
Date: Fri, 16 Nov 2012 22:03:41 +0100
Message-ID: <CAMP44s2UVGKa7XkqPxdxQ2ueSMn=Xn4qihy5JWbDovH85n8BwQ@mail.gmail.com>
References: <CAFj1UpHgPvdDeKZ-Ap7-aVx6p_pxT4a2F01ajmNa00txPyS=Qw@mail.gmail.com>
	<1352980269-15569-1-git-send-email-marc.khouzam@gmail.com>
	<CAMP44s0Guq0nYJEfbvNDyt8Oqaux-cXbTsyro6pxUnEpA4+XOw@mail.gmail.com>
	<CAFj1UpEdft+L5KW+tMy6Lqm1eUkHQgwWuXaC0UTUdqwW=ohk-Q@mail.gmail.com>
	<CAMP44s1RtOj6LKCNJ8SX8KSA8eNCMZ+4D-VfQ+WtXju-KhG8ng@mail.gmail.com>
	<CAFj1UpHLf2je_+b1e5B_5thZ03UYVmW=CWhAh63kNRCbke0kQw@mail.gmail.com>
	<CAMP44s1RvMSBu2RJqKw9ne4cJyMO4dbFc-gW2HgsN2-uviv=fA@mail.gmail.com>
	<CAFj1UpHMc-bHJgSZKY13YH_69TXkz-50g5xpLA6C+Eh0aqcN9A@mail.gmail.com>
	<CAMP44s3S4c7ciJNurxGdS2o_TDJJDkGK73dtCGji+C1NoV+Jvw@mail.gmail.com>
	<20121116204017.GX12052@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Khouzam <marc.khouzam@gmail.com>, git@vger.kernel.org
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Nov 16 22:03:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZT4u-0000fl-6R
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 22:03:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404Ab2KPVDm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Nov 2012 16:03:42 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:49002 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867Ab2KPVDm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Nov 2012 16:03:42 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so3218163oag.19
        for <git@vger.kernel.org>; Fri, 16 Nov 2012 13:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ubPVwUg0iMp+x7T5TIkFN2eHwXg4NhzWe7fKOhkdU0o=;
        b=lJoBDn6l6TM8wqh1iVu05A20pcS5z7Aq87agVcivIoRBRX3KsJSZ0L0/cJbS8r8Yy5
         yYtdmhU98pyv7JfNGG2uB9l4z6UZgYKUA2cZ6qMnYD+ycCWNC/WtrZWo032fmqORE5fT
         rlcJHYQmYv+teOemKnNgLs88G6u1bTmSrPQsii8kQQXtby4paE1irCmW8vZ3IFPf+zIv
         9GHpHlVRyQPbDPRqfEpIpov3Do7r6YlW8i9yjBjFo/GXM6fLXso7VgG6kvcwurJucWIT
         F+O1GaSKRe0o4UxNzZlCFWjKbbb6HgqtXbNMIXwba3XJTDy9mjrYrIwjKKc6dQozshc5
         keZw==
Received: by 10.60.12.233 with SMTP id b9mr5053667oec.95.1353099821617; Fri,
 16 Nov 2012 13:03:41 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Fri, 16 Nov 2012 13:03:41 -0800 (PST)
In-Reply-To: <20121116204017.GX12052@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209910>

On Fri, Nov 16, 2012 at 9:40 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
> On Fri, Nov 16, 2012 at 09:04:06PM +0100, Felipe Contreras wrote:
>> > I agree, and this is why I made the proposed
>> > __git_complete_with_output () generic.  That way it could be
>> > used by other shells or programs.  But at this time, only tcsh
>> > would make use of it.
>> >
>> > If you think having __git_complete_with_output () could
>> > be useful for others, I think we should go with solution (A).
>> > If you don't think so, or if it is better to wait until a need
>> > arises first, then solution (C) will work fine.
>
> I think it would be useful.

=46or what?

>> I don't see how it could be useful to others, and if we find out tha=
t
>> it could, we can always move the code.
>
> For zsh, perhaps?

Nope.

> As I understand the main issues with using the completion script with
> zsh are the various little incompatibilities between the two shells
> and bugs in zsh's emulation of Bash's completion-related builtins.
> Running the completion script under Bash and using its results in zsh
> would solve these issues at the root.  And would allow as to remove
> some if [[ -n ${ZSH_VERSION-} ]] code.

We can remove that code already, because we now have code that is
superior than zsh's bash completion emulation:

http://article.gmane.org/gmane.comp.version-control.git/208173

This is the equivalent of what Marc is doing, except that zsh has no
problems running bash's code. Note there's a difference with zsh's
emulation bash (or rather bourne shell, or k shell), and zsh's
emulation of bash's _completion_. The former is fine, the later is
not.

Of course, people might not be aware of this new script, and would
expect sourcing the bash one to work right away. Maybe at some point
we might throw a warning to suggest them to use my new script. But I
think we should wait a few releases just to make sure that people test
it and nothing is broken.

Cheers.

--=20
=46elipe Contreras
