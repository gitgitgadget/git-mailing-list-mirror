From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Multiple user questions
Date: Sat, 24 May 2008 14:33:42 +0200
Message-ID: <200805241433.42954.jnareb@gmail.com>
References: <200805231327.41216.devurandom@gmx.net> <m3zlqg32w9.fsf@localhost.localdomain> <200805241113.57848.devurandom@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dennis Schridde <devurandom@gmx.net>
X-From: git-owner@vger.kernel.org Sat May 24 14:35:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzsxl-0004yI-D3
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 14:35:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbYEXMd6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 May 2008 08:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790AbYEXMd6
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 08:33:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:25692 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbYEXMd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 08:33:57 -0400
Received: by nf-out-0910.google.com with SMTP id d3so536139nfc.21
        for <git@vger.kernel.org>; Sat, 24 May 2008 05:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=KShXkSVE/JAXrCriIlWm/ls/aNHrykPiO6+TUZTV+z4=;
        b=kTJMM/1oWvV3GhpHEO8Pdrn8sOmJ9rpp8GamFH2IkoAspBZK0XQaPquT+OLTsEoeW2ey+K67w86xyF1ZIv0Qh0O6adAflNxsCShRqhfzhcZtUKXNUp4slnc+O8lKRe2K3FtduFaRYFOFSiJrzJqkacxJ4IUVSggCLytq7AJpjvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=eQ6RLQAfxvDTkU2DpMZE6qcQOfxTeViKg1e1rZkLD7cMsMVkIBvCz1tbxoA/Y9n5Ak+WD0Io3sgb8gA7cPVZehjpP6NBtrGZ0W9RX4N4tWCv/wXayf6xwC4jeM4OF4a7ZL6WV4rfYMpZqzcqzL8rviQdtKBHbFXxmKG97iqQDbk=
Received: by 10.210.63.5 with SMTP id l5mr2041817eba.85.1211632431701;
        Sat, 24 May 2008 05:33:51 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.233.1])
        by mx.google.com with ESMTPS id 6sm9649950nfv.36.2008.05.24.05.33.49
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 May 2008 05:33:50 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200805241113.57848.devurandom@gmx.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82810>

Dnia sobota 24. maja 2008 11:13, Dennis Schridde napisa=B3:
> Thanks for your answers!

You are welcome.
=20
> Am Samstag, 24. Mai 2008 03:30:43 schrieb Jakub Narebski:
>> Dennis Schridde <devurandom@gmx.net> writes:
>>> 2) Can I make format-patch include the full commit message, date, a=
uthor,
>>> stats in the patches? (To mimic what git-show would show me.)
>>> Will this be sent via send-email, too?
>>
>> Errr... git-format-patch output _does_ include full commit message,
>> author, author date and diffstat.
>>
> For me only the first line of the commit message is printed in the su=
bject,=20
> all other lines are missing.

What version of git do you use? If I remember correctly this area
was worked on some time ago, so git-format-patch takes now whole first
paragraph as a subject of email, folding it using appropriate RFC
style.

Note though that git-am migh convert this first paragraph to single
line, losing formatting in the progress.  I think there is some option
to preserve formatting.

> If I want a message to appear in the body at all, I need a special wa=
y to=20
> format my commit messages: 1 line summary, 1 empty line, description.
> Only the description is then shown in the email.
> This seems inconvenient, especially for smaller changes.

What do you think this commit message convention git uses is from?
It stems from exchanging patches by email, where you had to put short,
single line description in the email subject, and describe change in
more detail in message (email) body.  If you don't follow this
commit message convention many git tools (tig, gitk, git-shortlog, etc.=
)
will not work as expected.

> Further, attachments do not at all contain any information like that.
> See the attached example.

Errr... I just tried "git format-patch --attach"[1] and it creates by
default multi-part attachement, first part is commit message, second
is patch itself.  The commit message contains diffstat.

This is if I remember correctly quite new thing, so it might need
some polishing.

[1] I use git version 1.5.5

>>> 4) Can I make format-patch output one deletion and one insertion fo=
r a
>>> complete rewrite of a function, instead of multiple deletes/inserts=
?
>>
>> Try git-format-patch with -B option, or -B<num>.
>>
> I tried that already.  Whether I specified -B or not, it always gave
> the exact same output (says diff).

Ah, I'm sorry.  The -B is to recognize total rewrite, i.e. such a chang=
e
that is best represent as delete old contents and create new one.

If I remember correctly there was some work lately, I think by Linus,
to join together neighbour chunks to make diff more readable.  But
I think there were no configurable parameters... I also don't remember
if it hit released version...

> The <num> parameter to -B is not mentioned or explained in the manpag=
es.

It is explained in diffcore, which in future version of git would be
in manpage, and not only as HTML / text documentation.

--=20
Jakub Narebski
Poland
