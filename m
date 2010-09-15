From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH 1/2] po/de.po: add German translation
Date: Wed, 15 Sep 2010 09:33:13 +0200
Message-ID: <20100915093313.44396t6yr62ixccg@webmail.tu-harburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: trast@student.ethz.ch, jk@jk.gs, avarab@gmail.com
X-From: git-owner@vger.kernel.org Wed Sep 15 09:46:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvmhP-00025Z-V4
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 09:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062Ab0IOHnf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Sep 2010 03:43:35 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:58545 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813Ab0IOHne (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Sep 2010 03:43:34 -0400
X-Greylist: delayed 616 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Sep 2010 03:43:34 EDT
Received: from mail.tu-harburg.de (mail.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id o8F7XDBi022365
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 15 Sep 2010 09:33:13 +0200
Received: from webmail.tu-harburg.de (webmail.rz.tu-harburg.de [134.28.202.69])
	(user=alucst mech=PLAIN bits=0)
	by mail.tu-harburg.de (8.13.8/8.13.8) with ESMTP id o8F7XDvt002382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 15 Sep 2010 09:33:13 +0200
Received: from hansjoerg.sick.de (hansjoerg.sick.de [91.207.92.112]) by
 webmail.tu-harburg.de (Horde Framework) with HTTP; Wed, 15 Sep 2010
 09:33:13 +0200
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.3.7)
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156226>

Dear Thomas, Jan, et al.,

thanks for the discussion of an initial git translation to German. I =20
appreciate the efforts to translate not only the gui tools of git, but =
=20
also the command line commands as well. I completely agree with =20
Thomas' proposal to discuss and agree on a glossary of terms *first*, =20
and *secondly* preparing the actual translation - otherwise it will be =
=20
impossible to create a consistent translation.

As you might guess, as the (initial) translator of git-gui I've been =20
through this discussion before [1] and as you have noticed, I have =20
decided to take a translation approach different from what you have =20
recently discussed here. I deliberately tried to translate as much of =20
the terms into German as possible. I do not agree about the importance =
=20
of statements on this mailing list like "This translation translates =20
too much terms - I cannot find the commands I'm used to". The point of =
=20
a translation is to enable the usage of a program to people who do =20
*not* know the original language. This is the target audience. By =20
definition, this excludes anyone who participates on *this* mailing =20
list from the target audience: Obviously you not only speak English =20
very well, but you are daily familiar with the English git wording for =
=20
the concepts inside this VCS. Then let me repeat: A translation is not =
=20
for you. You know, the bait and the fisherman and the fish and such. =20
Instead, a translation is for people who do neither know nor =20
understand the English wording for the git concepts. For this target =20
audience, the goal is to find a set of terms for the different git =20
concepts which makes the concepts most easily accessible for their =20
language. This may or may not include terms which are left at English =20
words.

Having said that, I would also take the following inspiration with a =20
grain of salt:

> You said on IRC that you left all English terms that
> are also used on
> http://de.wikipedia.org/wiki/Versionskontrolle

Wikipedia is a bad reference for measuring the importance of certain =20
things. I (or you) could have easily adapted that article to my point =20
of view before continuing the discussion. However, in this particular =20
case that article doesn't even mention many of the terms which need to =
=20
be discussed in a git glossary.

Having said that as well, I admit the translation of the command line =20
tools is somewhat more difficult than a GUI tool, because many of the =20
git concepts appear as English words in the command itself. Hence, I =20
admit it is much more difficult to decide on a non-English =20
translation, but having to mention the English term all the time =20
because that's the command which needs to be used. And for sure we =20
won't want to translate the (main porcelain) command names. Hence, the =
=20
decision on terms which are left in English can surely be decided =20
differently here than in the GUI tools.

After this introduction, I would like to comment on a few of the =20
proposed German glossary translations; the IMHO easier ones first:

>  branch                Branch (m.)

I'd go for "Zweig". It's even on the wikipedia page and it perfectly =20
represents the concept.

>  index                 Index

I'd strongly vote for not using "Index". The "Index" is where the =20
"Bundespr=FCfstelle f=FCr jugendgef=E4hrdende Schriften" puts the =20
Ballerspiele on. Don't let the identical word fool you into thinking =20
this is a worthwhile translation. Also, the English term is a bad =20
naming anyway IMHO. I'd use git-gui's replacement (staging area) and =20
use "Bereitstellung" here as well. Feel free to propose something =20
different, but please not "Index". Git isn't FSK18.

>  commit (noun, verb)                Commit/committen

That's a hard one. It sounds terrible to use "committen" in German. I =20
would strongly vote for not using this word directly, but I admit I =20
also don't have a completely convincing alternative.

>  revision              Revision

Die "Revision" kommt ins Haus, um die B=FCcher zu pr=FCfen. Honestly, =20
please don't use that word in German. Why not "Version"?

>  tag                   Tag

Der heutige Tag oder der morgige Tag? What's the problem with =20
"Markierung"? This is exactky the git concept which is meant.

>  tree                  Tree

I would not understand what the "Tree" in German should be. Any German =
=20
word instead?

Many other of the proposals are just fine and very good. Keep up the =20
good work!

Regards,

Christian Stimming


[1] http://article.gmane.org/gmane.comp.version-control.git/58315
