From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git status options feature suggestion
Date: Sun, 12 Oct 2008 12:47:11 +0200
Message-ID: <971DCAD3-3274-4507-AE3D-5BDCEDB8513C@wincent.com>
References: <81bfc67a0810082234p55e2fb9jb2a10f837eea7de0@mail.gmail.com> <20081009061136.GA24288@coredump.intra.peff.net> <81bfc67a0810082327p421ca4e9v84f4b33023bc6fe6@mail.gmail.com> <81bfc67a0810082327q71b9d6apf2787eb8519031bb@mail.gmail.com> <alpine.DEB.1.00.0810091101230.22125@pacific.mpi-cbg.de.mpi-cbg.de> <48EE1F58.2060707@drmicha.warpmail.net> <20081012044900.GA27845@coredump.intra.peff.net> <7vwsgegvsh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Caleb Cushing <xenoterracide@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 12 12:50:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoyX1-0002s7-IQ
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 12:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbYJLKrY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Oct 2008 06:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbYJLKrY
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 06:47:24 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:34092 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbYJLKrX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Oct 2008 06:47:23 -0400
Received: from cuzco.lan (5.pool85-53-7.dynamic.orange.es [85.53.7.5])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m9CAlCxi006821
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 12 Oct 2008 06:47:14 -0400
In-Reply-To: <7vwsgegvsh.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98011>

El 12/10/2008, a las 8:41, Junio C Hamano escribi=F3:

> Jeff King <peff@peff.net> writes:
>
>> So I think it is probably reasonable to think about a new command =20
>> (which
>> would not be called status) that shows this information.
>
> I was going to suggest the same.  "git st" for people who come from =20
> "svn st"
> so that "git status" can be kept as traditional "preview of 'git =20
> commit'".
>
> And just make it mimic whatever folks accustomed to "svn st" would =20
> expect,
> modulo we would need two status letters to signal difference between
> (HEAD, index), and (index, worktree).  Perhaps three if you want to =20
> show
> difference between (HEAD, worktree) while at it.

One of the first aliases I set up when I started using git was "st" =20
for status, and I'd imagine that's a pretty common thing for people =20
coming from other SCMs like svn and cvs. But I very quickly became =20
used to git's notion of what "status" means and I wouldn't want "git =20
st" to start giving me a different behaviour.

I think if you're introducing a different command then you should make =
=20
sure it doesn't happen to be an abbreviation of an existing one. It =20
would be better to give it some other name (info, foo, whatever). If =20
svn people then want to make an "st" alias pointing to it they're free =
=20
to do so.

Just my 2c.

Cheers,
Wincent
