From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stgit: lost all my patches again
Date: Wed, 28 Nov 2007 07:32:45 +0100
Message-ID: <20071128063245.GA11163@diana.vm.bytemark.co.uk>
References: <9e4733910711271417l32ed9a77p9915aa34a780665b@mail.gmail.com> <7vr6ibb3x7.fsf@gitster.siamese.dyndns.org> <9e4733910711271859w7b7dc141q93e3c9f67693a54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 14:02:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxKvj-0004Hz-0E
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 12:18:11 +0100
Received: from mail-mx3.uio.no ([129.240.10.44])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxGZg-0002VN-An
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 07:39:08 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx3.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxGZR-0003dJ-6B
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 07:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbXK1Gcy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Nov 2007 01:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbXK1Gcy
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 01:32:54 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1331 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbXK1Gcx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 01:32:53 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IxGTV-00030H-00; Wed, 28 Nov 2007 06:32:45 +0000
Content-Disposition: inline
In-Reply-To: <9e4733910711271859w7b7dc141q93e3c9f67693a54@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: 57A2BC20F3773BFFECBA9A08DAC6A7EA55469561
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -69 maxlevel 200 minaction 2 bait 0 mail/h: 52 total 723967 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66314>

On 2007-11-27 21:59:00 -0500, Jon Smirl wrote:

> Karl, Catalin, can stgit install a pre-rebase hook and disable 'git
> rebase' when stg is active on the branch? This would keep me from
> destroying my patch stack when my fingers get ahead of me. Might be
> good to disable anything else that can cause damage too.

Mmmm. We'd have to define "damage"; "stg repair" can take care of
quite a lot of things nowadays. Committing new stuff on top of a patch
series is no problem, for example, and "git reset --hard HEAD^ && stg
repair" is equivalent to "stg pop". I can see how "git rebase" would
still be a nuisance, though.

Patch? :-)

Presumably, we'd want the hook to be a Python script, so as to

  * not make it more difficult to port StGit to Windows someday;

  * make it possible for the hook to call StGit functions; and

  * not force the project's contributors to learn more shell scripting
    than they have to. :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
