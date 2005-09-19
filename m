From: =?iso-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] Added -d and -e options to the "git" script.
Date: Mon, 19 Sep 2005 16:24:10 +0200
Message-ID: <u5tvf0xb0fp.fsf@lysator.liu.se>
References: <Pine.LNX.4.58.0509181114190.26803@g5.osdl.org>
	<u5tmzm9bbrb.fsf@lysator.liu.se> <432EC7D6.6080105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Sep 19 16:31:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHMdh-0007o9-Ay
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 16:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbVISO27 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 19 Sep 2005 10:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbVISO27
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 10:28:59 -0400
Received: from main.gmane.org ([80.91.229.2]:8932 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932431AbVISO26 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 10:28:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EHMba-00079n-5S
	for git@vger.kernel.org; Mon, 19 Sep 2005 16:26:50 +0200
Received: from 212214120186-virtutech-ab.host.songnetworks.se ([212.214.120.186])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Sep 2005 16:26:50 +0200
Received: from davidk by 212214120186-virtutech-ab.host.songnetworks.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Sep 2005 16:26:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212214120186-virtutech-ab.host.songnetworks.se
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:xODJROKlt1YW8iBxEc4BvzFFznc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8864>

A Large Angry SCM <gitzilla@gmail.com> writes:

> David K=E5gedal wrote:
>> These flags override the GIT_DIR and EDITOR environment variables.
>>
> [Patch snipped]
>
> An option for GIT_DIR maybe since it's a Git environment variable but=
 a=20
> command line option to change the EDITOR _environment_ variable is NO=
T=20
> appropriate for git.

Yeah, I should have separated those two so that the GIT_DIR option
could be accepted on its own.  And it should maybe have a --git-dir=3D
log form as well.

The reason I did -e too was simply that I needed it for the same
reason I needed -d.  I wanted to run git with specific values for
GIT_DIR and EDITOR without having to setenv them in emacs.  But the
EDITOR trick I'm using is a hack and should be replaced anyway. (I use
EDITOR=3Dcat to get access to the default commit message with comments
from 'git commit').

So please disregard the -e part of my patch for now.  You are free to
disregard the -d part as well, but I think that makes some kind of
sense.

And If we go down this path, maybe flags for other GIT_* environment
variables should be settable with git command line flags too?

--=20
David K=E5gedal
