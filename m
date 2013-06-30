From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] completion: add completer for status
Date: Sun, 30 Jun 2013 13:00:36 +0200
Message-ID: <20130630110036.GA2294@goldbirke>
References: <1372094575-20799-1-git-send-email-artagnon@gmail.com>
 <20130628102936.GA16562@goldbirke>
 <20130628105601.GB16562@goldbirke>
 <20130628112631.GC16562@goldbirke>
 <CALkWK0=pyzcx-rB9gjRecoD1MFkHrSdYwLurD8y805O3FwT4Cg@mail.gmail.com>
 <CALkWK0=RZbZxSzCFNAPqzcpnnC_Tak+isESmFiEyLMgcu3vV1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 30 13:01:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtFNM-0003Pq-RU
	for gcvg-git-2@plane.gmane.org; Sun, 30 Jun 2013 13:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632Ab3F3LAm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Jun 2013 07:00:42 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:55719 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408Ab3F3LAm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jun 2013 07:00:42 -0400
Received: from localhost6.localdomain6 (f051032128.adsl.alicedsl.de [78.51.32.128])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0MIAjy-1Ux57j09vS-003Mu8; Sun, 30 Jun 2013 13:00:37 +0200
Content-Disposition: inline
In-Reply-To: <CALkWK0=RZbZxSzCFNAPqzcpnnC_Tak+isESmFiEyLMgcu3vV1Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:EWMI+mFXuObv8pFrl+MrZljZZWzjrMdIaaSdtVbckT2
 iQG4zkTc4rxFA4iduellMqH0A0fONSJIPa7h/qBsPpY6oinFeR
 ZItveu/XdxmpbG2qKH/mDPWzeKIZ9q0vfKtEV/F3XxsmeRQalg
 jWBQJt42ue4SrNL1Jbxf9rOEZY4xVtYBVGRRdjE5io/g7M1V/E
 440qKq24AjTPqwZkvSe82vqtEYbBGenbQdOKR/2ZMyUjDZWMpe
 1wP+olTC2ROyPl2KbNLjb7Wvl263O4yIPbiab28wF3REmXLNHX
 tfToFhaAK+PAfUHiMs81gLJ57iqusgoZ9T68PfkOwQ6PoQleIV
 T105MoLKFpUSqv3VadUI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229265>

On Fri, Jun 28, 2013 at 07:33:21PM +0530, Ramkumar Ramachandra wrote:
> Ramkumar Ramachandra wrote:
> >> +       __git_complete_index_file "--with-tree=3DHEAD --cached --d=
eleted"
> >
> > Might as well go all the way with  "--cached --deleted --unmerged
> > --others" no?  What is the point of --with-tree=3DHEAD?
>=20
> Ugh, --deleted doesn't work as advertised (terrible documentation).

Why not?  In my experiments it worked well, as you can see in my
previous emails.  What behavior did you observe which differs from the
advertised?

> The minimally correct combination we need seems to be
> "--with-tree=3DHEAD --cached --others".

Yeah, once we use '--with-tree=3DHEAD' we don't need '--deleted'
anymore.


G=E1bor
