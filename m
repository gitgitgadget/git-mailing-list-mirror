From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Rollback of git commands
Date: Wed, 28 Nov 2007 10:22:34 +0100
Message-ID: <20071128092234.GA12977@diana.vm.bytemark.co.uk>
References: <9e4733910711271523p3be94010jac9c79e6b95f010d@mail.gmail.com> <7vmyszb39s.fsf@gitster.siamese.dyndns.org> <9e4733910711271733r6f280618pbb14095aebba3309@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 12:18:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from [129.240.10.42] (helo=mail-forward.uio.no)
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxKJa-00014q-Ul
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 11:38:46 +0100
Received: from mail-mx8.uio.no ([129.240.10.38])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxJGS-0001tO-EQ
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 10:31:28 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx8.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxJGD-0000Gu-9c
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 10:31:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717AbXK1JYA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Nov 2007 04:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754708AbXK1JYA
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 04:24:00 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3423 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754685AbXK1JX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 04:23:59 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IxJ7q-0003XI-00; Wed, 28 Nov 2007 09:22:34 +0000
Content-Disposition: inline
In-Reply-To: <9e4733910711271733r6f280618pbb14095aebba3309@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: 370AA3DEC335BC8739C30E2DEDEFD9755F36507D
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -69 maxlevel 200 minaction 2 bait 0 mail/h: 69 total 724237 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66285>

On 2007-11-27 20:33:27 -0500, Jon Smirl wrote:

> Let's take my recent problem as an example. I typed 'git rebase
> linus/master' instead of 'stg rebase linus/master'. Then I typed
> 'stg repair'. The repair failed and left me in a mess. Both of these
> are easy to rollback except for the fact that stg has stored a bunch
> of state in .git/*.
>
> After doing the commands I located my last commit before the rebase
> and edited master back to it. But my system was still messed up
> since moving master got me out of sync with the state stg stored in
> .git/*. The 'stg repair' command had changed the stored state.

How exactly did repair mess up? Did it crash, produce a broken result,
an unreasonable but technically valid result, or just not the result
you wanted?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
