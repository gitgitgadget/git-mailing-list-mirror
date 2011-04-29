From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] lookup_object(): Speed up 'git gc' by 12%, by reducing
 hash chain length
Date: Fri, 29 Apr 2011 11:50:45 +0200
Message-ID: <20110429095045.GA22919@elte.hu>
References: <20110427213502.GA13647@elte.hu>
 <7vtydh1r3q.fsf@alter.siamese.dyndns.org>
 <20110429072604.GA16371@elte.hu>
 <20110429073825.GA16941@elte.hu>
 <BANLkTinGn0WFNm805PeWuTp+71yby1ySNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 11:50:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFkLj-0002pJ-8B
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 11:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758158Ab1D2Jux convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Apr 2011 05:50:53 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:34394 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757972Ab1D2Juw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 05:50:52 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1QFkLY-0004Tm-1c
	from <mingo@elte.hu>; Fri, 29 Apr 2011 11:50:49 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 11EBC3E2516; Fri, 29 Apr 2011 11:50:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTinGn0WFNm805PeWuTp+71yby1ySNw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Received-SPF: neutral (mx2.mail.elte.hu: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.3.1
	-2.0 BAYES_00               BODY: Bayes spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172444>


* Sverre Rabbelier <srabbelier@gmail.com> wrote:

> Heya,
>=20
> On Fri, Apr 29, 2011 at 09:38, Ingo Molnar <mingo@elte.hu> wrote:
> > =A0 16: =A0 =A0 =A09,402,077,866 cycles:u =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 # =A0 =A02.987 GHz =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( +-=
 =A00.20% )
> >
> > They are utterly unconvincing - there seems to be no improvement, i=
t's all
> > within noise.
>=20
> Is this in a different repository from the one you ran the numbers on
> initially, or did something else change to negate that 12.2% decrease=
?

Yes, a newer Git repository with more objects in it.

Thanks,

	Ingo
