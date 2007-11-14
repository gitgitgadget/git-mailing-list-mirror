From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare repositories?
Date: Wed, 14 Nov 2007 21:30:46 +0100
Message-ID: <14F93E86-32FA-41AD-BB02-256A599C82E0@wincent.com>
References: <86k5on8v6p.fsf@lola.quinscape.zz> <20071112131927.GA1701@c3sl.ufpr.br> <Pine.LNX.4.64.0711121355380.4362@racer.site> <200711121719.54146.wielemak@science.uva.nl> <Pine.LNX.4.64.0711121624330.4362@racer.site> <vpq3avbv2ju.fsf@bauges.imag.fr> <Pine.LNX.4.64.0711121715090.4362@racer.site> <18232.35893.243300.179076@lisa.zopyra.com> <Pine.LNX.4.64.0711121727130.4362@racer.site> <vpq7iknqrtp.fsf@bauges.imag.fr> <Pine.LNX.4.64.0711121755460.4362@racer.site> <vpqy7d3pck0.fsf@bauges.imag.fr> <Pine.LNX.4.64.0711121804400.4362@racer.site> <vpqoddzpc88.fsf@bauges.imag.fr> <7v4pfr2kmh.fsf@gitster.siamese.dyndns.org> <87myth58r5.fsf@osv.gnss.ru> <7vfxz8hbcf.fsf@gitster.siamese.dyndns.org> <18235.22445.16228.535898@lisa.zopyra.com>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Sergei Organov <osv@javad.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 21:33:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsOv6-0003fP-Qv
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 21:33:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760414AbXKNUcu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Nov 2007 15:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759960AbXKNUcu
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 15:32:50 -0500
Received: from wincent.com ([72.3.236.74]:38203 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754606AbXKNUct convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Nov 2007 15:32:49 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAEKUlLM000489;
	Wed, 14 Nov 2007 14:30:48 -0600
In-Reply-To: <18235.22445.16228.535898@lisa.zopyra.com>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65011>

El 14/11/2007, a las 21:16, Bill Lear escribi=F3:

> % mkdir new_repo
> % cd new_repo
> [add content]
> % git commit -a -m "Initial stuff"
> % git config remote.origin.url git://host/new_repo
> % git push
> [ach! fails!  what's up??]
> [poke, read, poke some more, try other things..]
> [try setting the remote.origin.fetch?  No, that doesn't work]
> [try setting branch.master.remote?  Just edit by hand??]
> % git push master
> [fails again; read some more; think, think, think...]
> % git push origin master
> [aha! finally it works]


Instead of using git-config I think the following would have worked:

git remote add origin git.example.com:/pub/git/path_repositories/=20
repo.git
git push --all

I guess it is not necessarily obvious the first time, which more than =20
anything makes this a documentation issue. I now can't remember how I =20
learnt this; probably by reading this list.

Cheers,
Wincent
