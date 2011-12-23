From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: Gitk: shortcut to jump to the current HEAD (yellow spot)?
Date: Fri, 23 Dec 2011 19:54:56 +0100
Message-ID: <4EF4CE80.8090502@dirk.my1.cc>
References: <4EF3517A.8030108@dirk.my1.cc> <874nwslayi.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Dec 23 19:55:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ReAGp-00072b-G8
	for gcvg-git-2@lo.gmane.org; Fri, 23 Dec 2011 19:55:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757597Ab1LWSzD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Dec 2011 13:55:03 -0500
Received: from smtprelay04.ispgateway.de ([80.67.31.42]:57993 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852Ab1LWSzB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2011 13:55:01 -0500
Received: from [217.87.111.219] (helo=[192.168.2.100])
	by smtprelay04.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1ReAGg-0002Ge-4z; Fri, 23 Dec 2011 19:54:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <874nwslayi.fsf@fox.patthoyts.tk>
X-Df-Sender: NzU3NjQ2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187637>

Am 22.12.2011 19:26 schrieb Pat Thoyts:
> Dirk S=FCsserott <newsletter@dirk.my1.cc> writes:
>=20
>> Hi!
>>
>> Does anybody know about a shortcut in gitk to "jump to the yellow sp=
ot"?
>>
>> I often use cmdline and gitk at the same time, switch branches, stas=
h,
>> rebase and so on from bash. When hitting [Ctrl-]F5 in gitk, the last
>> highlighted commit is focused again and my HEAD is far off the scree=
n.
>>
>> Is there a way to jump to the HEAD (the yellow bubble in gitk) with =
a
>> fingertip?
>>
>> TIA
>>    Dirk
>=20
> Hit the Home key. The binding for that takes you to the first commit.
> End to the last (oldest) commit.

Hi Pat,

thank you, but I almost always run gitk with the '--all' parameter.
Actually, I have a function in my .bashrc for this:

  # calls gitk from the top-level directory:
  function gkup()
  {
      (cd "./$(git rev-parse --show-cdup)"; gitk --all "$@" &)
  }

That's because gitk behaves odd (at least to me) when not run from the
top-level directory. E.g. the "touching paths" box won't find files in
the top dir if you don't prefix them with a slash. It's all relative to
the directory gitk was started in. To get predictable behavior, I wrote
this function and garnished it with '--all'.

Thus, my current HEAD is not always on the top of the history but
somewhere in between. However, typing "HEAD" (or "head" in the SHA1
field works for me.

Cheers
    Dirk
