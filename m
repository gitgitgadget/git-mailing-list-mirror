From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Rebase/cherry-picking idea
Date: Wed, 28 Nov 2007 09:52:08 +0100
Message-ID: <50645A3B-C5F0-4A99-A2B8-AD9251024244@wincent.com>
References: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com> <C3971B37-F75A-40EE-B30A-E88E5DAFAD55@lrde.epita.fr> <D21294CA-6FD0-40F5-B0D6-5155865DA69A@wincent.com> <CDF48716-F198-4B33-A5F5-8A2DE1F177EB@wincent.com> <474AC136.8060906@viscovery.net> <451492C9-F3EA-4C37-A1AD-59FC72E0A0A2@wincent.com> <Pine.LNX.4.64.0711261340470.27959@racer.site> <97F6E8DE-4022-4458-B6A9-C644A6EDC1E3@wincent.com> <7vir3m94ku.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 14:38:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxKuf-000418-Tn
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 12:17:05 +0100
Received: from mail-mx8.uio.no ([129.240.10.38])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxIjZ-0001UG-3x
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 09:57:29 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx8.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxIjQ-0003wr-JZ
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 09:57:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478AbXK1IwW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Nov 2007 03:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752722AbXK1IwW
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 03:52:22 -0500
Received: from wincent.com ([72.3.236.74]:44332 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752369AbXK1IwV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Nov 2007 03:52:21 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAS8q9qc032332;
	Wed, 28 Nov 2007 02:52:10 -0600
In-Reply-To: <7vir3m94ku.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.8, required=5.0, autolearn=disabled, AWL=3.163,RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: 4908B2017303774CE6EEC978888917D1B21B27FC
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -37 maxlevel 200 minaction 2 bait 0 mail/h: 95 total 724166 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66333>

El 28/11/2007, a las 9:06, Junio C Hamano escribi=F3:

>> Once I get a clear idea of what kind of change is likely to actually
>> get accepted I'll submit a proper patch.
>
> Too often, people disappear with a patch that is basically good but =20
> has
> room for improvements this way.  I really do not have time nor =20
> bandwidth
> to keep bugging them for updates, and often end up cleaning up on my =
=20
> own
> instead.

The problem in this case was that my patch didn't receive any =20
meaningful feedback (ie. suggestions for improvement), only a lot of =20
bikeshed stuff about whether the environment variable should have an =20
underscore prefix or not, whether or not I should use "export FOO=3D...=
" =20
or not etc. So I didn't know what was necessary in order to get it =20
accepted.

> This is such a patch, and without acks or comments, it is also very
> likely to be lost.

Ok, please disregard the resend that I just posted a few minutes ago =20
(hadn't seen your new patch yet).

Cheers,
Wincent
