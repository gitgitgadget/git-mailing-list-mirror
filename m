From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] tcsh-completion re-using git-completion.bash
Date: Fri, 16 Nov 2012 18:18:50 +0100
Message-ID: <CAMP44s1RvMSBu2RJqKw9ne4cJyMO4dbFc-gW2HgsN2-uviv=fA@mail.gmail.com>
References: <CAFj1UpHgPvdDeKZ-Ap7-aVx6p_pxT4a2F01ajmNa00txPyS=Qw@mail.gmail.com>
	<1352980269-15569-1-git-send-email-marc.khouzam@gmail.com>
	<CAMP44s0Guq0nYJEfbvNDyt8Oqaux-cXbTsyro6pxUnEpA4+XOw@mail.gmail.com>
	<CAFj1UpEdft+L5KW+tMy6Lqm1eUkHQgwWuXaC0UTUdqwW=ohk-Q@mail.gmail.com>
	<CAMP44s1RtOj6LKCNJ8SX8KSA8eNCMZ+4D-VfQ+WtXju-KhG8ng@mail.gmail.com>
	<CAFj1UpHLf2je_+b1e5B_5thZ03UYVmW=CWhAh63kNRCbke0kQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: szeder@ira.uka.de, git@vger.kernel.org
To: Marc Khouzam <marc.khouzam@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 18:19:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZPZJ-0006Uq-PP
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 18:19:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668Ab2KPRSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 12:18:52 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:42371 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184Ab2KPRSv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 12:18:51 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so3005145oag.19
        for <git@vger.kernel.org>; Fri, 16 Nov 2012 09:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hSOVeTKQllbDIstY+AkXaZJg2T6+o5lnLnjD1sB8ixU=;
        b=o/FtLGjH64Q9mpDsKSlqMWUlSz+W8FO1DA+jzUJhRgBhtC9MMbe0r7h+lO7SJ4btFR
         JpNr7oWg4/UlAyuR+bkUefh90r0daXXC34Xhw1JnBKX4GC9vDuQjvpdJHRdpCB6JrQix
         7oW1AlJF4ZnetOVdrVhg0p5Nw6fzTwOOD2dR6sRE/kP2IwyLLdANtGVAGIq16u1rNCXD
         svFrHNzqnLRZO6njNXmdracKTJyTfncdNVDQOtkz/rXTeEnLMazsz04wWgAh+55j3KsT
         /bXSM2dACcwMbgwCxg/S/W6b9HvuQ5d77+AR/o5cvy56XcEmpLkkmgg0CreER2dyfQu1
         Ir7g==
Received: by 10.60.12.225 with SMTP id b1mr4451428oec.96.1353086330864; Fri,
 16 Nov 2012 09:18:50 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Fri, 16 Nov 2012 09:18:50 -0800 (PST)
In-Reply-To: <CAFj1UpHLf2je_+b1e5B_5thZ03UYVmW=CWhAh63kNRCbke0kQw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209885>

On Fri, Nov 16, 2012 at 4:48 PM, Marc Khouzam <marc.khouzam@gmail.com> wrote:
> On Fri, Nov 16, 2012 at 10:33 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:

>> Is it possible to just check if this is a login shell?
>
> I think it would be nice to allow the user to manually
> source git-completion.tcsh, in case they want to make
> manual modifications to it.

Yeah, they could still do that... because they would be running in a
login shell.

What I meant is that if the user does: tcsh
my_script_that_has_nothing_to_do_with_completion.sh, they would not be
executing this whole script.

> I think the most user-friendly option is to actually re-generate the
> script each time.  It feels wrong, but it works well :)

I'm not too strongly opposed to add that function to the bash
completion, but to do it only for tcsh doesn't sound right, specially
when there are other alternatives. Correct me if I'm wrong, but very
few people use tcsh.

-- 
Felipe Contreras
