From: Giuseppe Scrivano <gscrivano@gnu.org>
Subject: Re: Linus' sha1 is much faster!
Date: Mon, 17 Aug 2009 19:32:31 +0200
Message-ID: <871vnae47k.fsf@master.homenet>
References: <4A85F270.20703@draigBrady.com> <87eirbef3c.fsf@master.homenet>
	<4A88B80D.40804@draigBrady.com> <8763cmemsa.fsf@master.homenet>
	<f488382f0908170844h649126efxb27f87d7b319961b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?P=C3=A1draig?= Brady <P@draigbrady.com>,
	Bug-coreutils@gnu.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Steven Noonan <steven@uplinklabs.net>
X-From: git-owner@vger.kernel.org Mon Aug 17 19:34:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md664-0007gx-1W
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 19:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbZHQReF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 13:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757728AbZHQReF
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 13:34:05 -0400
Received: from jack.mail.tiscali.it ([213.205.33.53]:51622 "EHLO
	jack.mail.tiscali.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757700AbZHQReE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 13:34:04 -0400
Received: from master.homenet (84.222.168.55) by jack.mail.tiscali.it (8.0.022)
        id 499F036C05BAB6D6; Mon, 17 Aug 2009 19:33:54 +0200
Received: from gscrivano by master.homenet with local (Exim 4.69)
	(envelope-from <gscrivano@gnu.org>)
	id 1Md64O-0002vj-6T; Mon, 17 Aug 2009 19:32:32 +0200
In-Reply-To: <f488382f0908170844h649126efxb27f87d7b319961b@mail.gmail.com>
	(Steven Noonan's message of "Mon, 17 Aug 2009 08:44:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126243>

Hi,

These are the results I reported (median of 5 plus an additional not
considered first run) on the Steve Reid's SHA1 implementation using the
same flags to the compiler that I used for previous tests.

GCC 4.3.3:  real	0m2.627s
GCC 4.4.1:  real	0m3.742s

In both cases it showed to be slower than other implementations I have
already tried.

Additional note: as for gnulib SHA1, GCC 4.4.1 produced slower code than
GCC 4.3.3.

Cheers,
Giuseppe



Steven Noonan <steven@uplinklabs.net> writes:

>
> Interesting. I compared Linus' implementation to the public domain one
> by Steve Reid[1], which is used in OpenLDAP and a few other projects.
> Anyone with some experience testing these kinds of things in a
> statistically sound manner want to try it out? In my tests, I got
> this:
>
> (average of 5 runs)
> Linus' sha1: 283MB/s
> Steve Reid's sha1: 305MB/s
>
> - Steven
>
> [1] http://gpl.nas-central.org/SYNOLOGY/x07-series/514_UNTARED/source/openldap-2.3.11/libraries/liblutil/sha1.c
