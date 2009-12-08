From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 0/3] Add a "fix" command to "rebase --interactive"
Date: Tue, 8 Dec 2009 14:51:14 +0100
Message-ID: <fabb9a1e0912080551s32295cfahf05bdc715360360@mail.gmail.com>
References: <cover.1259934977.git.mhagger@alum.mit.edu> <4B192701.4000308@drmicha.warpmail.net> 
	<vpqfx7qocwl.fsf@bauges.imag.fr> <7vws12r5v2.fsf@alter.siamese.dyndns.org> 
	<alpine.DEB.1.00.0912041945161.21557@intel-tinevez-2-302> 
	<20091205062708.6117@nanako3.lavabit.com> <7vd42t6f9i.fsf@alter.siamese.dyndns.org> 
	<20091208121314.6117@nanako3.lavabit.com> <7viqchhl7h.fsf@alter.siamese.dyndns.org> 
	<20091208093515.GA32655@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 08 14:51:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI0Tb-00039T-TM
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 14:51:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755110AbZLHNv3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Dec 2009 08:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755029AbZLHNv2
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 08:51:28 -0500
Received: from mail-vw0-f197.google.com ([209.85.212.197]:44232 "EHLO
	mail-vw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754881AbZLHNv1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Dec 2009 08:51:27 -0500
Received: by vws35 with SMTP id 35so2450120vws.4
        for <git@vger.kernel.org>; Tue, 08 Dec 2009 05:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=zg+d0zd1uoivE0bqJQaHFFLDL3zmrmip9dTp3pyRTbA=;
        b=qEjHEoRTmNXpzPNi9es8tk+aOR9aT9ZzBS2eL+C68Wde9Zpt2AfVsBLD7kEnvxZ177
         pgiw+fsNMilDn0KBlrK9jU+1g3qO3dxC6cqN8zhvJGOOHMg33PWROBRHTbLZmwUAE31u
         Tw1W94LcU5GzsjxAnqnEqZ5Jx2rkEIo7G37rA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=vrtmswayaTFJ7Tv32flsZnT4SKpezc4C0j7HJhgm5bpkEYLhc+2vuKF6oSdv0Pqxdm
         SqyfYrM+QEqTDtIW+KveLtjJPk8RE28AomSEVXaTSjJwOowz1twUxNCi3ujdatTgctjN
         Ts8MG5NDmcWhN5jTUGVrNz4FUdSXCtPyn4vC0=
Received: by 10.220.123.167 with SMTP id p39mr1684084vcr.22.1260280294089; 
	Tue, 08 Dec 2009 05:51:34 -0800 (PST)
In-Reply-To: <20091208093515.GA32655@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134872>

Heya,

On Tue, Dec 8, 2009 at 10:35, Jeff King <peff@peff.net> wrote:
> =A0$ bash
> =A0$ echo "!fixup commit"
> =A0bash: !fixup: event not found
> =A0$ echo "fixup! commit"
> =A0fixup! commit

Speaking of which, must we use that annoying bang? I hate how bash
gets in my way when I try to write a commit message with a a bang in
it, I'd much rather use a different character that is not in risk of
being mistreated by my shell. (Although it seems that bash does do TRT
in the 'fixup!' case.)

--=20
Cheers,

Sverre Rabbelier
