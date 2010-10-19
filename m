From: Thore Husfeldt <thore.husfeldt@gmail.com>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Tue, 19 Oct 2010 19:30:24 +0200
Message-ID: <202EB46D-10D0-4090-A9DA-5796769F61A2@gmail.com>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com> <m3ocar5fmo.fsf@localhost.localdomain> <20101019080523.GB22067@login.drsnuggles.stderr.nl> <201010191027.44859.jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 19 19:30:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8G1F-0006WJ-2S
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 19:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755890Ab0JSRaa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Oct 2010 13:30:30 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:33398 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755596Ab0JSRa3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Oct 2010 13:30:29 -0400
Received: by ewy20 with SMTP id 20so3740939ewy.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 10:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=obBbASz9uGb6/jlk4dbqOtTXU/uD/rgxvBVBo3QvwpE=;
        b=UTHaf5G+tiaxkB8DF4ryzHq4MyEt9o05Uf2I7ZfY8DI85QLW6KK0hFTEbhnuwzDKbC
         ZJJGsnvL+EhmetB+XdPXuDE0ilrnrHc7nsImVe3eF/TcJQuG+owRyYU1WSoI4CzSnEL/
         UxvFEhOol96xbzkrxgphAIItTW9wEKpU7ELPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=IrU5yZCZ68oUFPaRLdw9dNQjWnkuJpRce34xcBZVH+qFE9BtuMiwDQdj4iqFNG5RjT
         1xFafHZFlJjQwHIy3AINWbiPNZE/1BdVAUsEaXCAbAEQVGm4BPyIds77tdGa+akNRDZ/
         BuYS51mXiTt0rIwHOiNuwzQfxaph5IR1vC32c=
Received: by 10.213.8.143 with SMTP id h15mr780195ebh.11.1287509428366;
        Tue, 19 Oct 2010 10:30:28 -0700 (PDT)
Received: from [10.0.1.4] (h51baf259.k2290.dyn.perspektivbredband.net [81.186.242.89])
        by mx.google.com with ESMTPS id q58sm4197215eeh.9.2010.10.19.10.30.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 10:30:26 -0700 (PDT)
In-Reply-To: <201010191027.44859.jnareb@gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159340>

Thank you all for your many and well-thought out replies. I learned a l=
ot.

Jonathan Nieder:

> So what would be a better term [for tracking]?

Trailing is better than tracking, since it hints at some degree of slot=
h, but I have not thought this through. (I also think that it may be a =
strategic mistake to advocate looking for a new name; as long as tracki=
ng is used consistently the problem with a misleading metaphor is not s=
o big, and the name change alienates a large group of people whose cons=
ent is important.)

> How will a person used to e.g. cvs ever adjust if they don't even rea=
lize git is different?

This comment, and similar from others, makes it clear that I made a mis=
take in taking up staging versus tracking. It sends a wrong signal abou=
t my intentions, and is only a minor detail. This was *not* so difficul=
t to understand, so I shouldn=92t have included it. My annoyance here i=
s merely aesthetic and pedagogical.

Matthiey Moy:

> Git's huge sin, after all (judging from most complaints I see about i=
t), is that It Doesn't Use Exactly The Same Model (and thus Terminology=
) That CVS Did...


My analysis of Git=92s wickedness is interestingly different. Git has a=
 clean and simple model that should be very easy to understand. Git=92s=
 rhetorical traditions prevent that understanding. Git is really, reall=
y hard to learn, no matter where you come from, but there is no inheren=
t reason for that.

The steepness of the learning curve (rather than the divergence from ot=
her systems=92s terminology) is the single biggest complaint against gi=
t, evidenced by my own anecdotal evidence from web surfing, and by the =
Git user survey. It should be viewed as Git=92s biggest current problem=
 by an order of magnitude. It makes me think twice and thrice before as=
king my colleagues to collaborate with me using Git; I will probably le=
arn Mercurial and advocate using that instead=97it=92s almost as nice, =
and I don=92t feel embarrassed advocating it. Using git for myself is g=
reat (now I understand it) but it is unclear if I should invest social =
capital to convince others to use it as well.=20

The magnitude of how bad this is, and the urgency with which this shoul=
d be fixed, is clear to everybody=97except, naturally, the denizens of =
this mailing list. Not out of malice or incompetence, but *because of* =
familiarity.

Sverre Rabbelier:


> What do you mean with the last part (about `git branch -r`)? The fact
> that 'refs/remotes' is not immutable?

Well, consider for example the simple obfuscatory mastery of the follow=
ing line in the user manual:

> $ git branch -r			# list all remote branches


Yes, I get it *now*. And I begin to feel the corruption spreading in my=
 own brain already: I myself start to think of origin/master as a =93re=
mote branch=94. Give me a few more weeks and I will be completely assim=
ilated in the mindset.

(Note to self: submit a patch about this before my assimilation is comp=
lete. I already fixed it and committed to my local branch.)

Mattiey again:

> We already came up with a better wording, namely "upstream", and used=
 in in "git push --set-upstream".=20

Oh, I didn=92t know that. I was convinced that =93upstream=94 was cruft=
 from when git was chiefly a tool to help Linus maintain the Linux kern=
el. Let=91s see if I get this right:

The remote-tracking branch =93origin/master=94 is *upstream* (the upstr=
eam?) of the local branch =93master=94, and *tracks* the remote origin=92=
s branch =93master=94? (local) =93master=94 is downstream of =93origin/=
master=94?

This would be useful. And @{u} is good. (Does it have an inverse?)

I=92m not sure I like the particular word, but that=92s a minor complai=
nt.=20

( For completeness: A small terminological quibble is that upstream doe=
sn=92t verb well. A bigger conceptual quibble is that this decision is =
not workflow-neutral. It enforces git=92s hierarchical linux-kernel dev=
elopment  tradition, rather than embracing a truly distributed model wh=
ere everybody is the same. When I think of distributed version control =
I like to think of Alice having a remote-tracking bob/master and Bob ha=
ving a remote-tracking alice/master. Of course, it is still meaningful =
for Alice to say =93the upstream of bobs_latest_crazy_ideas is bob/mast=
er=94, and for Bob to say =93the upstream of alices_inane_ramblings is =
alice/master=94. But it introduces a notion of hierarchy that is inimic=
al to the concept of distribution, and not workflow-neutral. )

Of course, upstream could be called supercalifragilistic and I would st=
ill like it. Consistency is more important than having good metaphors. =
(But good metaphors would be better, all other things being equal.)

Jakup Narebski:

> Note that it is not as easy as it seems at first glance.  There are *=
two* such options, which (as you can read in gitcli(7) manpage) have sl=
ightly different meaning:

Wow. Thanks for pointing this out, I did not know that, and it explains=
 a lot. I must say that to everybody else than a git developer, this st=
ate of affairs is a proof that something is wrong, rather than an obstr=
uction for improvement.

>  I do not think debating on changing the terminology is a particularl=
y productive use of our time. =20

I agree in the sense that *how* the words are used is more important th=
an *which* words are used, and I realise that I should not have put =93=
terminology=94 in the headline, because that makes it about words, not =
*explanations* or terminological *discipline*. 