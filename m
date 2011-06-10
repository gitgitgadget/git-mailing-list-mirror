From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Fri, 10 Jun 2011 20:35:41 +0200
Message-ID: <201106102035.42525.jnareb@gmail.com>
References: <201106051311.00951.jnareb@gmail.com> <201106101844.16146.jnareb@gmail.com> <4DF25D50.5020107@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Jun 10 20:35:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QV6Yp-0006K6-79
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 20:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757903Ab1FJSfx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2011 14:35:53 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56061 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757746Ab1FJSfw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2011 14:35:52 -0400
Received: by bwz15 with SMTP id 15so2408060bwz.19
        for <git@vger.kernel.org>; Fri, 10 Jun 2011 11:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=3YjGOjQJFWJeSCk4/jZqYUoSyQKbirvJTljas2OszYQ=;
        b=uf9q9qFQN1VGDTnAZ86R1STUU9BCJUMGMz0VHXeXLTqEYZ0rdlZnap6zgAnhgoCkFe
         2/GoNo9hCaJzQfSYJGcbKaq8w7Ja/vN8sD52ITpCBrMIA6qWEZmSWvwL7qJvhbyQicYE
         arj2mDcO5yvZEb1ptiQ8b86WUKVoyE6xBcv6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=OnrK+bkXvAOMqvw5ogksra79zDRWuQK8+xfnB8XgkGDZ52/iGtTMZUMGSzFZqj7lW3
         B6Kn4uRaxFNBEZJyTt5AKNsYlaVoH8TzGQvDsU/fn2lBvYqGaNljEf7VSv/VPd6RmFCd
         9fUb/rVJSTlsVutzDDC+b1drN0t+FIuHmuhpc=
Received: by 10.204.170.193 with SMTP id e1mr1986995bkz.136.1307730951185;
        Fri, 10 Jun 2011 11:35:51 -0700 (PDT)
Received: from [192.168.1.15] (abvz126.neoplus.adsl.tpnet.pl [83.8.223.126])
        by mx.google.com with ESMTPS id j7sm2817027bka.20.2011.06.10.11.35.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Jun 2011 11:35:50 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4DF25D50.5020107@ira.uka.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175615>

Dnia pi=B1tek 10. czerwca 2011 20:07, Holger Hellmuth napisa=B3:
> On 10.06.2011 18:44, Jakub Narebski wrote:
> > On Thu, 9 Jun 2011, Holger Hellmuth wrote:
> >> Also there are no good words for what someone wants to see in this=
 case.
> >> At least I would assume the git project would have found them if t=
hey
> >> existed. '--cached' is definitely not one of them. But we have fit=
ting
> >> and widely known names for the targets, i.e 'working tree', 'index=
' and
> >> 'head'.
> >
> > "I want to see if there are any remiaining changes", "I want to see=
 what
> > 'git commit' would bring", "I want to see what 'git commit -a' woul=
d bring".
> > Neither of those is about targets for diff.
>=20
> Are you proposing a command "git=20
> --I-want-to-see-if-there-are-any-remaining-changes" ? ;-). I was look=
ing=20
> for short command or parameter names that are easy to remember, not f=
or=20
> definitions of the output of cryptic commands.
>=20
> But lets see. If I didn't know much git, where would I look for the=20
> right command for your three needs? Where would I expect the solution=
?=20
> (note I'm not proposing any of these commands)
>=20
> "I want to see if there are any remaining changes"?
> git status
> git status --full
> git status --detailed

"Any differences"?

git diff


"I want to see what I staged"

git diff --staged


Isn't it simpler than "I want to see the changes between what I already
staged, which is put in place called index, but must refer to it by NEX=
T,
and the changes I didn't staged, in my working area, which I refer to b=
y
WORK... no, it is TREE... oh, wait, it is WTREE" :-)  I am exaggerating
much here, but I think you can see what I want to point out.

> Now I'll add a question I would want to ask:
> "I want to see the changes between what I have in my working tree and=
=20
> what I already added to the index"

That's not a beginner question.

> git diff WTREE INDEX
           ^^^^^^^^^^^ --- reverse to "git diff"

In this direction it is surely suprising... you see, how again and agai=
n
having to explicitely state what to compare with which leads to mistake=
s
such like this one, and the one in few mails earlier.
=20
>=20
> Btw. even the 'git diff' man page emphasizes that diff is about a=20
> comparision between two things. Citation: "Show changes *between* two=
=20
> trees, a tree and the working tree, a tree and the index file,...".
=20
That's more about explaining result of command.  Besides manpages are
reference documentation; new users should start with user's manual, or
tutorial (or "Pro Git"), not manpages.
=20
> > [...]
> >>> The "git diff NEXT WTREE" looks like training wheels to me.  And =
like
> >>> training wheels they could become obstacles and not help to learn=
ing
> >>> git.  Neverthemind they can snag on sharp corners^W corner-cases.=
 ;-)))
> >>
> >> If your goal is that anyone who uses git is a git expert, they may=
 be a
> >> hindrance (as are all the porcelain commands really). If you also =
want
> >> to make git friendly to people who will never get past intermediat=
e or
> >> beginner stage or will only use a small part of git or use git sel=
domly,
> >> training wheels are good.
> >
> > Those "training wheels" are useless for beginner, and might be not =
very
> > useful to middle expert user either, depending on corner cases.
>=20
> "useless for beginner". No reasoning, just a fat road block for my op=
inion?
> As git expert you are so far removed from any beginner status. Are yo=
u=20
> sure you still know how a beginner thinks?

Well, that depends by what you mean by beginner.  Beginner to git, but
not beginner to version control knows about "<scm> diff" form to check
for one's changes, for example.

But I don't think that beginner knows that there is such thing like the
index, and know that he/she has to compare the index to the working are=
a.
When he/she starts to use the index, probably he/she isn't a beginner
anymore.

--=20
Jakub Narebski
Poland
