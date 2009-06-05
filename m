From: Shakthi Kannan <shakthimaan@gmail.com>
Subject: Re: di-git-ally managing love letters - a Git presentation
Date: Fri, 5 Jun 2009 10:22:31 +0530
Message-ID: <d16b1c80906042152r77006c77lceb90ec616836ba3@mail.gmail.com>
References: <d16b1c80906040441n7ad549eay83a6ccfd5db09fb3@mail.gmail.com>
	 <m3oct46oji.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 06:52:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCRQ3-0002LY-0H
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 06:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbZFEEwb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2009 00:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbZFEEwb
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 00:52:31 -0400
Received: from mail-gx0-f214.google.com ([209.85.217.214]:53012 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbZFEEwa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2009 00:52:30 -0400
Received: by gxk10 with SMTP id 10so2339117gxk.13
        for <git@vger.kernel.org>; Thu, 04 Jun 2009 21:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=4KIOukzfJbW/9fK8R8wK0MaXzSwJJ+XlJZ+fQ6WMvjI=;
        b=S+aFh5GuKiSxnrz+4T5ckUnd4jtqAPfrxw22cKyzLZKLd0ZEsuMZDHQVsevxVSjayp
         bckFTNsePGKmICOtnfISUt1wyMWI5ayc1O/saT37BcPXNT8lnl5DLT8GN0cZMWbRaf1V
         vWKwySaXrENVK8Jbtm8/KPQ8jGQUAriTFdDjM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=Q+hBQVPf/ALP+w+/CYhQBt6rsQ5D5BHok9NhUXAf88P3axg/8K3cQ8bfa18dkQZF8V
         U6OQUegUd8L1e7PA6Nxr9BN453GnQR3GUBQKo+NwznbAOgS3fvI3yZ8t3p1gD9+5EgQ5
         EL0G6iKZnHe8EbjsLYta4wzVPPkNeVuT20TtI=
Received: by 10.90.87.5 with SMTP id k5mr2531771agb.86.1244177551756; Thu, 04 
	Jun 2009 21:52:31 -0700 (PDT)
In-Reply-To: <m3oct46oji.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120739>

Hi,

=46irstly, thanks for your reply! This is the feedback I was hoping to
hear. My replies below:

--- On Thu, Jun 4, 2009 at 8:21 PM, Jakub Narebski<jnareb@gmail.com> wr=
ote:
| Why don't you use git to manage LaTeX sources, using for example one
| of free git hosting sites (repo.or.cz, GitHub, Gitorious)?
\--

Practice what you preach :) Sure, could. Will look into it.

---
| A few comments:
| =C2=A0* For which git version do you write your presentation?
\--

On Fedora 10, git 1.6.0.6.

---
| Modern
| =C2=A0 git (which might mean just released version, and perhaps even
| =C2=A0 yet-to-be-released version) has:
| =C2=A0 =C2=A0 - git log --oneline =3D=3D git log --pretty=3Doneline -=
-abbrev-commit
\--

Will remember that.

---
| =C2=A0* Nitpick: git index (also known as staging area) does not cont=
ain
| =C2=A0 objects itself. =C2=A0They are put in objects database. =C2=A0=
The index
| =C2=A0 contains references to those objects (so they can be found).
\--

I can mention it as "object ref" or "object(s) ref".

---
| =C2=A0* Suggestion: When showing "git diff", "git diff --cached" and
| =C2=A0 "git diff HEAD" output you might want to show which parts
| =C2=A0 in the diagram below you compare.
\--

Will do.

---
| =C2=A0* Why there is no diagram / graph for tagging?
\--

Will do. I guess it should be a tag symbol pointing to the recent commi=
t?

---
| =C2=A0* Nitpick: you have spelled 'git-format-patch' by mistake
| =C2=A0 instead of modern 'git format-patch'.
\--

Ohh! In git 1.6.0.6, I had git-format-patch. I will keep up with the
modern git releases.

---
| =C2=A0* I would personally use "git rm -f <file>", but it might be ea=
sier
| =C2=A0 tu add '-f' at the end of line.
\--

Will change it.

---
| =C2=A0* I would guess that this usage ("git reset HEAD <file>") is qu=
ite
| =C2=A0 rare,
\--

I see. I just used it to show it because git printed it in the output,
and someone new to using git should know as to what the output meant.

---
| =C2=A0* I think that actual usage of "git reset --soft" is pretty pre=
tty
| =C2=A0 rare since we have "git commit --amend".
\--

Ohh! I just mentioned it to show the difference between --soft and --ha=
rd.

---
| I don't know if presentation is not too long. On the other hand it
| doesn't cover situations such as non fast-formard merge...
\--

Yes. I don't yet have many use-cases, but, I guess it is a reasonable
start. Will work on these use cases.

Thanks again!

SK

--=20
Shakthi Kannan
http://www.shakthimaan.com
