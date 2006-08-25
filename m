From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Problem with pack
Date: Fri, 25 Aug 2006 12:41:00 +0200
Organization: At home
Message-ID: <ecmk3o$sbs$1@sea.gmane.org>
References: <44EECBE2.7090801@arces.unibo.it> <44EECEDC.7090608@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Aug 25 12:41:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGZ80-0001IF-MI
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 12:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbWHYKlY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 25 Aug 2006 06:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWHYKlY
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Aug 2006 06:41:24 -0400
Received: from main.gmane.org ([80.91.229.2]:44463 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932418AbWHYKlX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Aug 2006 06:41:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GGZ7h-0001ET-DO
	for git@vger.kernel.org; Fri, 25 Aug 2006 12:41:13 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 Aug 2006 12:41:13 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 Aug 2006 12:41:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25996>

Andreas Ericsson wrote:

>>> BTW I'd recommend not syncing with unison, but with the git=20
>>> transports: If your PC and Laptop are connected, you could do=20
>>> something like
>>>
>>> =A0 =A0 git pull laptop:my_project/.git
>>> =A0=20
>> Actually, the project, including the git archive gets syncronized as=
 a=20
>> part of a syncronization process including all my Documents director=
y=20
>> (the project is in fact a LaTeX manual with somehow complex LaTeX=20
>> packages and classes). Syncronizing in this way actually worked very=
=20
>> well so far, because at once I was getting in sync all my working tr=
ees=20
>> and all my repos...
>>=20
>=20
> The largest benefit of using git's synchronization methods is that yo=
u=20
> immediately get a pack-file verification, and also that you never ris=
k=20
> overwriting anything in either repo if you've forgotten to sync betwe=
en=20
> the two (say you've made changes on your laptop, forgot to send them =
to=20
> your workstation, then made changes on your workstation and then you =
try=20
> to sync them). It's possible to recover from such a situation using t=
he=20
> lost-found tool, but it can be cumbersome, and uncommitted changes, a=
s=20
> well as changes to the working tree, are lost forever.

Unison (which if I remember correctly uses rsync, or rsync over ssh) de=
tect
such case and ask user what to do if both sides changed a file (copy fr=
om
one side, copy from second side, view diff, merge,...).

But you can always tell unison to ignore git object database
  ignore =3D Name .git
and perhaps also ignore working directories under git control
  ignore =3D Path path/to/working/dir/
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
