From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Rebase/cherry-picking idea
Date: Wed, 28 Nov 2007 11:04:58 +0100
Message-ID: <1570EAD5-9F47-4105-B3DA-49CA6FA57369@wincent.com>
References: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com> <C3971B37-F75A-40EE-B30A-E88E5DAFAD55@lrde.epita.fr> <D21294CA-6FD0-40F5-B0D6-5155865DA69A@wincent.com> <CDF48716-F198-4B33-A5F5-8A2DE1F177EB@wincent.com> <474AC136.8060906@viscovery.net> <451492C9-F3EA-4C37-A1AD-59FC72E0A0A2@wincent.com> <Pine.LNX.4.64.0711261340470.27959@racer.site> <97F6E8DE-4022-4458-B6A9-C644A6EDC1E3@wincent.com> <7vir3m94ku.fsf@gitster.siamese.dyndns.org> <50645A3B-C5F0-4A99-A2B8-AD9251024244@wincent.com> <7v1waa7lcv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 12:37:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from [129.240.10.42] (helo=mail-forward.uio.no)
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxKJD-0000zi-Ij
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 11:38:23 +0100
Received: from mail-mx8.uio.no ([129.240.10.38])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxJpE-00014j-Sz
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 11:07:24 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx8.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxJoz-00068D-7Z
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 11:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722AbXK1KFV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Nov 2007 05:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755431AbXK1KFU
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 05:05:20 -0500
Received: from wincent.com ([72.3.236.74]:44470 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754685AbXK1KFU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Nov 2007 05:05:20 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lASA4xKI001713;
	Wed, 28 Nov 2007 04:05:00 -0600
In-Reply-To: <7v1waa7lcv.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.1, required=5.0, autolearn=disabled, AWL=2.875,RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: CED74461609D402390786E0A1BE26366AFF71400
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -40 maxlevel 200 minaction 2 bait 0 mail/h: 14 total 724316 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66288>

El 28/11/2007, a las 10:47, Junio C Hamano escribi=F3:

> I think _GIT_FOO vs GIT_FOO is an important detail, not at all a
> bikeshed color, to make things consistent.  "export VAR=3DVAL" also i=
s a
> valid concern (you said in a separate message you only know about =20
> bash,
> and I later asked people if they use shells that get affected with it
> but we happily run otherwise.  I personally do not think the latter =20
> is a
> problem, but since somebody already raised it as a potential issue, i=
t
> gave us a good chance to hear from people on minority platforms, if =20
> only
> to build confidence in us to use that POSIX form.

I'm still a little concerned that nobody commented when I pointed out =20
that export VAR=3DVAL is used elsewhere in Git, especially in git-=20
clone.sh, which is very commonly-used porcelain. Is it a problem?

> If these details (I do not think the overridability is a minor detail=
,
> though) look like bikeshedding to you, that is somewhat sad.  You see=
m
> to be very capable of producing usable code, but these details
> (consistency and flexibility) matter for longer term stability, and I
> would really want to see capable people pay attention to such details=
,
> especially I sometimes fail to do so myself.


I think the *key* difference between our patches was the refactoring =20
that you did (extracting into a separate function and at the same time =
=20
making the entire message customizable rather than just the end). I =20
think that's easily explained by the fact that as a new contributor I =20
am pretty much always going to err on the side of the most minimal =20
change possible (minimum number of lines, and changes kept as local as =
=20
possible), even if it isn't the best or most well-engineered one. Your =
=20
patch is more invasive, but it's better too, and I think it's more =20
invasive precisely because your knowledge of the codebase and your =20
track record gives you the confidence to make non-minimal changes when =
=20
you think they're better. With time I imagine I'll evolve away from =20
such defensive, minimal patches as the one I sent.

Cheers,
Wincent
