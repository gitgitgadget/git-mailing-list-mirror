From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Clarification on Submodule/Subproject naming
Date: Wed, 7 Oct 2015 09:37:00 +0200
Message-ID: <5614CB9C.2010701@web.de>
References: <CAGZ79kYyagjxyV0Da3FW3zWuJ+wD=FTPvzYebV7ER4TjTnMXpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Oct 07 09:37:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjjHn-0004g4-Rf
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 09:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbbJGHhK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Oct 2015 03:37:10 -0400
Received: from mout.web.de ([212.227.17.11]:62232 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750973AbbJGHhI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2015 03:37:08 -0400
Received: from [192.168.178.41] ([79.211.106.13]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0Lhev7-1aNVwX1jfN-00mpoR; Wed, 07 Oct 2015 09:37:04
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CAGZ79kYyagjxyV0Da3FW3zWuJ+wD=FTPvzYebV7ER4TjTnMXpg@mail.gmail.com>
X-Provags-ID: V03:K0:xxE8lEUUnMt7gFAu69Wb4GHSdBQeFHf3ciIDYQhwzvIc7mPpNNY
 IoIxhdwS+sxucHdx4NX10E6ns5ScdreZG7bd8WOw+WQp1HnBv875O1WSzTF4NRmM4EYG57c
 hrhpvXUhfD9x6H8MifHS2CwDx9TCLFpD9E6bTlR5ShQ1fA9ZXGzs+lQJIxjwGNoiBVKYPBd
 MC6e7ybVlrR/RUR124veA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Q7+ohyz7DO4=:4IlxfVJZx0G8v+1YGxkU8g
 Ilf5XSFjFQ72FiHQYVD9M4p31NE9pxwRqCK7Qf/7m/0O+9Pi3bV2SPvAeGywi43yH/U+tdU0L
 1IZ8uOuS2VtU9ega7eHpfXfSdxkmcwslXaq6dM1RHKlawKytBc+WnJ28ACOF4+/3AdJq3/+oi
 SmNxfGOVE1471p/CNw6hJkqMvMcC4Mipd/LvhhY04SSDDquEoyk0VPslDv3c7cHaomQdaQmq2
 JedCzc8fAasfxgq62UsF+P0Gv8CFNMbTAw6n9KA/TiW8aI+qfz7YoP+PHL6LHdUn1PJqlX2Sg
 I43TcLv7JPAq3QWThpoWZI0sr4a2MAJ9FjH2c6k2Hr5P5fqDrUp5hTxLwF6KERCyZZ8OQKQso
 psKnnbjz9dB6QPENgAPTj8osCGjy3rVPlAGjemypynZBMiuy0+43lusEmZ6+AbHFF8d6+wbLX
 NTiezaO+eBVGekIKnWyQ+cy4eR439te1L11MZUto09IqmstutlpyNowjFax0iQumup4QfoV3b
 Rb9UGex2JOQHZTCxqT/OR5ET8fqk/wTOgJi8EVcmHzQ1I3+kby+KsPYRoPZJPTa5ISUFtMbwc
 sdPb4wSIhSa1O1lJnWepXuYBdTXrxK/acxYs+NfKg4tPjq4/d7pEAbDeDH1heidxXHqs0HKnd
 PToSM6gWvRrcMDXySkIRjDGkD3psYiQamIi+o7C1EAWp/Tr3cHFE6UuJvP3uCWQHTUeRUrgYn
 C6z7G/C/IqP21I/lvvRWbGFpmMykQ0nhg0tA/riuClS0DcjGvSFx51w2iHS38Z5Kl4XCZWL/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279174>

Am 07.10.2015 um 00:00 schrieb Stefan Beller:
> So a discussing started in a Gerrit change [1] if we want to name it
> submodule or subproject.
> We decided to stick with the git core convention of naming it
> subproject for now.

What convention? Isn't diff output the only place where we talk
about subprojects?

> But that lead me to the question: What is the difference of a
> submodule and a subproject?

A submodule is a certain kind subproject (using a GITLINK and a
=2Egitmodules entry), but e.g. a GITLINK could be used by other
tooling to represent subprojects without using a .gitmodules
file. So submodules are one in-core specialization of subprojects,
the other is git subtree (which doesn't even use GITLINKs).

> As far as I can tell they are synonyms (internally also called
> GIT_LINK, but we never expose that to the users), where the term
> submodule was coined later in the game, subproject being there as the
> first term introduced in version 1.5.
>
> So is it worth to unify that same concept hiding between two names?

I doubt that, as one is a subset of the other.

> Looking through the code we cannot switch to submodule as the literal
> string "subproject"
> is used for diffs in the plumbing layer.

Exactly, we cannot change that easily because of compatibility issues.

> But getting rid of submodule is also not easy, as there is
> git-submodule.sh as a direct command.

Yup, that would confuse lots of users and break tons of scripts.

> So then there is also git subtree, which "allow subprojects to be
> included within a subdirectory of the main project, optionally
> including the subproject=E2=80=99s entire history." (the man page)
>
> So can I understand a subproject as either a submodule or a subtree ?

Or even some other method of embedding another repo.

> If so would it make sense to add an entry to gitglossary to state tha=
t
> subprojects are generic term for
> having some kind of structure? (a subdirectory containing independent
> stuff could be considered a
> subproject. i.e. We could make contrib/examples the historic-git subp=
roject ?)

Better documenting that is a good idea (though I'm not sure what you
mean by making "contrib/examples the historic-git subproject").
