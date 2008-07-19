From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH] Rename ".dotest/" to ".git/rebase" and ".dotest-merge"
 to "rebase-merge"
Date: Sat, 19 Jul 2008 21:49:33 +0200
Message-ID: <4882454D.2080500@free.fr>
References: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com> <20080715212211.GL6244@leksak.fem-net> <487D1B3D.70500@lsrfire.ath.cx> <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness> <20080716012619.GM8185@mit.edu> <7viqv5r637.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Theodore Tso <tytso@mit.edu>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Stephan Beyer <s-beyer@gmx.net>,
	Joe Fiorini <joe@faithfulgeek.org>, git@vger.kernel.org,
	Jari Aalto <jari.aalto@cante.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 21:50:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKIRz-0001gH-2c
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 21:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbYGSTtg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jul 2008 15:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752182AbYGSTtg
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 15:49:36 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:42301 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752143AbYGSTtf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 15:49:35 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id C94A412B6C2;
	Sat, 19 Jul 2008 21:49:34 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 1EC1512B6F0;
	Sat, 19 Jul 2008 21:49:33 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <7viqv5r637.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89129>

Junio C Hamano a =E9crit :
> Theodore Tso <tytso@mit.edu> writes:
>=20
>> While you have "git am" open, how about adding an "git am --abort"
>> which nukes the .dotest aka .git/rebase directory, and resets HEAD
>> back to the original position?
>=20
> This does not seem to have reached the list nor its archives.  I cann=
ot
> say I have really looked at it deeply but it may be a good starting
> point.  It needs docs ;-)

Thinking about the way "git am" works:

It tries to apply patches even on a dirty tree which makes difficult
to automatically do a "git reset --hard" with --skip or --abort and
forces the user to clean the index by hand if last patch failed with
unmerged files.

So, do some people still use "git am" with a dirty tree or will a
patch that make it work like "git rebase" be accepted?

I think users can use "git stash" and "git stash pop" today. Did I
miss something?

Note: the version that use "git sequencer" seems to work like I want
      but I do not know if it is a side effect or not.

Olivier.
