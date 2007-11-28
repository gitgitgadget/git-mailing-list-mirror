From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Wed, 28 Nov 2007 09:18:18 +0100
Message-ID: <20071128081818.GA16825@efreet.light.src>
References: <20071127150229.GA14859@laptop> <20071127160423.GA22807@laptop> <Pine.LNX.4.64.0711271617350.27959@racer.site> <20071128000731.GD9174@efreet.light.src> <7v8x4jb295.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWk=?= Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 14:28:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxKv2-00048M-E2
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 12:17:28 +0100
Received: from mail-mx3.uio.no ([129.240.10.44])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxIEw-00036F-Fd
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 09:25:50 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx3.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxIEn-0004bx-Mk
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 09:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbXK1ISa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Nov 2007 03:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752132AbXK1IS3
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 03:18:29 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:50962 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751709AbXK1IS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 03:18:29 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 0990D575FF;
	Wed, 28 Nov 2007 09:18:27 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id gJsf74UXUpzs; Wed, 28 Nov 2007 09:18:24 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 44258575E4;
	Wed, 28 Nov 2007 09:18:23 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1IxI7f-0004Oo-1f; Wed, 28 Nov 2007 09:18:19 +0100
Content-Disposition: inline
In-Reply-To: <7v8x4jb295.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: 4EE05048AB56AAA462B733BDA5C4806294D3A5A6
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -69 maxlevel 200 minaction 2 bait 0 mail/h: 41 total 724112 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66327>

On Tue, Nov 27, 2007 at 17:13:58 -0800, Junio C Hamano wrote:
> Jan Hudec <bulb@ucw.cz> writes:
> > On Tue, Nov 27, 2007 at 16:18:01 +0000, Johannes Schindelin wrote:
> >> On Tue, 27 Nov 2007, Nguy=E1=BB=85n Th=C3=A1i Ngoc Duy wrote:
> >>=20
> >> >  Both configure and make-only ways should work now
> >>=20
> >> I thought your plan was to put the non-porcelain into the libexecd=
ir only?
> >
> > I had the impression that deprecating the dash notation for /all/ u=
se was
> > approved some time ago. Though I don't want to search through the l=
ist
> > archives this late in the night to check it.
>=20
> [...]
>
> In case somebody is thinking about 36e5e70e0f40 (Start deprecating
> "git-command" in favor of "git command"), that is a somewhat differen=
t
> issue.  What Linus suggested is not installing git-foo link for built=
-in
> commands _anywhere_ on the filesystem.  Not just "out of user's PATH"=
=2E
> That is not deprecating dash form but removing the support for it.  W=
e
> need to give ample time for users to adjust to such a change.

Yes, that is what I said I recall seeing. Installing out of user's PATH=
 is
a step towards not installing at all and the change suggests it has bee=
n
already accepted as a general direction for future. Or not?

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
