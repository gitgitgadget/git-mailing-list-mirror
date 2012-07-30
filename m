From: Thomas Badie <thomas.badie@gmail.com>
Subject: Re: A new way to get a sha1?
Date: Mon, 30 Jul 2012 18:40:12 +0200
Message-ID: <CAFjFENqGTumBRkDX4vJjQhGz0CrEC1VU1cDHWCERywa8vjVbRw@mail.gmail.com>
References: <jv5tln$96e$1@dough.gmane.org>
	<alpine.LNX.2.01.1207301426090.25013@frira.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@inai.de>
X-From: git-owner@vger.kernel.org Mon Jul 30 18:40:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svt13-0007tw-IJ
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 18:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740Ab2G3QkO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jul 2012 12:40:14 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:48111 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439Ab2G3QkN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jul 2012 12:40:13 -0400
Received: by qcro28 with SMTP id o28so3095185qcr.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 09:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=zg56PPwu6KZCk4XXAn3xK+2Ig+E+/rA2QEACXDJMqoA=;
        b=pqtU8MiR6HLf9T0rVaqPi+UskrXp4r86qI+Ytjn7aAQ+DR6H/GLJ0WSlXa5oF1KLdX
         API78pVpGNonCMlAmkfdj9OQRqJ7KqTbjORnHn/6bV6p7M54WeOSi4YqZHrMoL1ibXJS
         8Dek7E2js0/RPsd2iCONeEEp3agjV7IQ3sgBv7SeaDLLh5Jl7JQJXwoSa8goq6avA7C8
         BKSYBtjjJrlb8gN3y+sJ0lNbVcOzHJHIO/HOH7gCNP4E76Oqokwoe4X8QScbt6l8c+8X
         ZCkFSfyawLSoaFhkBBNoLoxa7T8BHz9bRYLaszDZQoOIgT/NRANv8t4S148VDRFk4b5p
         XnmQ==
Received: by 10.224.32.205 with SMTP id e13mr24393666qad.69.1343666412711;
 Mon, 30 Jul 2012 09:40:12 -0700 (PDT)
Received: by 10.224.128.211 with HTTP; Mon, 30 Jul 2012 09:40:12 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.01.1207301426090.25013@frira.zrqbmnf.qr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202577>

2012/7/30 Jan Engelhardt <jengelh@inai.de>:
> On Monday 2012-07-30 14:11, Thomas Badie wrote:
>
>>Hi all,
>>
>>When I should fixup or squash a commit, I nearly never
>>remember how to get the sha1 of the commit I want to fixup.
>>Because sometimes HEAD~n is not enough, I make `git log`,
>>copy the sha1 of the right commit and paste it in my git
>>fixup command. So I wrote a perl script to avoid the usage
>>of the mouse.
>
> If you use screen(1), you can use the keyboard as well; it offers ^A =
[
> and ^A ] for copy, and then paste. tmux and all those screen clones
> probably have something similar. Maybe ratpoison-like WMs do as well.
> Or, you can use `git log --oneline`, look for the commit and then
> type the (usually) 6-char part of the hash manually, which may be fas=
ter
> than ^A[, moving the cursor to the copy position, marking it, etc.
>
>>So, what is your opinion?
>
> IMO, I thus never needed an extra tool to find and specify the hash f=
or
> `git re -i hash^`..
>
> my =A52

I understand your opinion. My solution was a easier way to make your
proposition about `git log --oneline`, because I don't want to copy the=
se
6 numbers by hand. I'd prefer select the right line simply.

My solution is intended for people who just use git, and whatever their
environment (Unix, Windows...) because all is contained in git.

But I clearly agree that there is a lot of other solutions by using ext=
ernal
tools.  But IMHO, it is preferable that I just have to add a `-i' to a =
command
to make this choice simply, and not having to use my WM for this kind o=
f task.

My real proposal is to integrate this way of choice into git instead of=
 having
to use external tools, or writting the part of the sha1 by hand.

Thanks for answering, your answer confirms that this kind of tools is r=
eally
not wanted by everyone.

I will take a look at screen, it can be useful for a lot of thing. Than=
ks for
your advice.

--=20
Thomas "Enki" Badie
