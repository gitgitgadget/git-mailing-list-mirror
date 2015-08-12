From: sivno.20.toranaga-san@spamgourmet.com
Subject: Git stash behavior
Date: Wed, 12 Aug 2015 16:57:25 +0200
Message-ID: <55CB5ED5.5020908@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 12 16:57:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPXTL-0003C8-J7
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 16:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700AbbHLO5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 10:57:37 -0400
Received: from gourmet.spamgourmet.com ([216.75.62.102]:35623 "EHLO
	gourmet8.spamgourmet.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932080AbbHLO5e (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Aug 2015 10:57:34 -0400
Received: from spamgourmet by gourmet7.spamgourmet.com with local (Exim 4.80)
	(envelope-from <sivno.20.toranaga-san@spamgourmet.com>)
	id 1ZPXTB-00086A-Uo
	for git@vger.kernel.org; Wed, 12 Aug 2015 14:57:33 +0000
Received: from mout.gmx.net ([212.227.15.15])
	by gourmet7.spamgourmet.com with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <sivno.20.toranaga-san@spamgourmet.com>)
	id 1ZPXTB-00085S-DW
	for sivno.Toranaga-san.429b71dd90.git#vger.kernel.org@ob.0sg.net; Wed, 12 Aug 2015 14:57:33 +0000
Received: from [130.149.15.205] ([130.149.15.205]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0LwaQZ-1Yk5Uy17ap-018JPL for
 <sivno.Toranaga-san.429b71dd90.git#vger.kernel.org@ob.0sg.net>; Wed, 12 Aug
 2015 16:57:31 +0200
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
X-Provags-ID: V03:K0:wQrCu7gnBrmnrmQiGinYflK21+JXU+eXmwz6XnwX6uU8N62l9wA
 5qZwvncfRPlFH3jltLIjYa30w1KteVM5YTxbc7s+PaO0IIQNKzxoEgGh7x0yXHnl8fTgZN0
 x0rZlC6HudvQ2kJZT2kWLrNrKPnwYi/N9bDtyxLMZmXp9kLrz/t0oaaomZcPZMxU2iq1Mfq
 lhfDhTWxpGXwpJYS+K7Vg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+4swZcfoTE8=:vi6x6TRSpGLjmmzUHFlQ8k
 ak1m5g8MOKN076CN6wRKSYY3lLwKvLFkzEZ62sOhvimXxYSlIDxQu1DrwEsQ2vOQoASMMg4W3
 QubptDn2R+IIm+x7MP/q3S37l6CcRvfTmFLf0RYMmWnTWPeoPwAnil1seJfNAH9JAKOlkxKfm
 rnE2FhH9dMsKKsGmqlvHeZzf8c5Pj4Rfe2h1Enjr+e2h70hGl8FtUSKumsLqUjfKdq0TwKuvX
 HC7QPWjXY+fb6BrobQGPU/cry3XQzlXQWpjwvmwaTfhpap1MC3H69ospKy5GrD+IymuIRbeKY
 8Ser5HymFOSfImlSIbVdgYVqY0758A6VZlIyKaw6rEQ6SCvLIFPXnDSO/U9xO7SL7Tnh9ms0Y
 7TGE12djAA7Qd13FJPq9mmSh3AsmL3OJ/JiwxlxlsOXKSoyb49TPJ5ohU3hJj2eXYrpsMsMZE
 Is0ifIpHMfYGfmXEJ5SWksBzCWe9G+kJ5ayTUbvW6z27zeptEjgkGTP/ZRagiFa6h7mh8qee9
 tUKlrfn9loPtMikrxiwLkwcXzRDlxrGe1qkM8jq8ijXZU49bZLK9WHRAnR7pzj0w6vKJk/Uei
 Sjp+0KbO1UJbUQcBqqw3UxLdD0prfvaqHI0JgEoK8iWCokBlwQrr995zZH7a9ZlxQB+jdml7h
 zvRTPWYyDQphi7lKE8OFNQ7uQfw0uPTXaUAqSTZpxzuyXXJ/TmWxviYJ9vGGOlZqJY6SVFkdu
 m99yPxINhKX17B6fsePesJJijj14ylLaw6Lxew==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275770>

Hello all,

I am using git stashes to ensure that my source builds and tests
correctly. My general work flow is this: Before committing I create a
stash and clean everything:

    git stash save -q --keep-index --include-untracked

Then I perform some tests (mvn compile test), after that I restore
everything:

    git stash pop -q

I am using this from a pre-commit hook so I really need this to work
reliably. The problem is that I think that it really doesn't. I created
a small gist to show the problem here:

https://gist.github.com/x2b/3cc3d8aa8979561de4b5

There are actually multiple problems here:

1.

If an untracked file already exists then git refuses to pop the stash.
This is certainly the desired behavior in most cases. However, I would
appreciate a "--force" option to override it.

2.

As you can see the content of the "untracked" file in the gist is the
same in the stash and the working directory. Is it really necessary to
abort the operation in this case??

3.

The most severe problem is that after unsuccessfully trying to pop the
stash the "first_untracked" file is restored while the "untracked" file
is not. The stash is *partially* applied to the working directory. It
seems like git restores some files before giving up after encountering
the first file which can't be restored. I think this behavior is not
generally what is expected. Git should either fail and leave the working
directory as-is or succeed and change the directory's content.
Since there is no "--force" option (see 1.) it is necessary to remove
the already restored untracked files by hand before attempting to pop
the stash once more (this is really inconvenient to me).

While these are not technically bugs I would appreciate it if you could
address these issues all the same.

x2b
