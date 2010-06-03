From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 5/8] revert: allow cherry-picking more than one commit
Date: Thu, 3 Jun 2010 06:18:26 +0200
Message-ID: <201006030618.26838.chriscool@tuxfamily.org>
References: <20100531193359.28729.55562.chriscool@tuxfamily.org> <20100601083549.GA28377@progeny.tock> <7vwruh9fbj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 06:18:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OK1tD-0003hu-3j
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 06:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840Ab0FCESi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jun 2010 00:18:38 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:40264 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767Ab0FCESh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jun 2010 00:18:37 -0400
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 9EB0281807C;
	Thu,  3 Jun 2010 06:18:29 +0200 (CEST)
User-Agent: KMail/1.12.2 (Linux/2.6.31-20-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <7vwruh9fbj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148289>

On Thursday 03 June 2010 01:37:20 Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> > As a side effect, this unfortunately changes the meaning of
> > =E2=80=98git log --oneline --decorate --no-walk -5 --all=E2=80=99: =
instead of listing
> > five refs, after this patch that command would list the five most
> > recent commits.
>=20
> It indeed is a change in behaviour, but in this case it is probably n=
ot
> such a big deal.
>
> The order "--all" (or "--branches" for that matter) lists refs doesn'=
t
> have any logical relationship with the order of importance from the e=
nd
> user's point of view (they're just alphabetical), and asking for "fir=
st
> five" won't make much sense unless you are learning or testing the
> combinations of options, i.e. not in real life, I think.

I agree and I think Jonathan's patch would be nice to have.

Thanks both,
Christian.
