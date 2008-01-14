From: Jan Hudec <bulb@ucw.cz>
Subject: Re: How to bypass the post-commit hook?
Date: Mon, 14 Jan 2008 18:59:51 +0100
Message-ID: <20080114175951.GA5527@efreet.light.src>
References: <46dff0320712300712l78c1cdaeya5fa105be01f6b74@mail.gmail.com> <20071230215008.GB20098@efreet.light.src> <4778BB63.6080908@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ping Yin <pkufranky@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Mon Jan 14 19:00:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JETbu-0002p0-GO
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 19:00:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbYANSAE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jan 2008 13:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbYANSAE
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 13:00:04 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:48990 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751291AbYANSAB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 13:00:01 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 0C62257262;
	Mon, 14 Jan 2008 19:00:00 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id EC-VRBqbhsBD; Mon, 14 Jan 2008 18:59:57 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id A1FCE573F0;
	Mon, 14 Jan 2008 18:59:56 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1JETbD-0000CS-Nd; Mon, 14 Jan 2008 18:59:51 +0100
Content-Disposition: inline
In-Reply-To: <4778BB63.6080908@obry.net>
User-Agent: Mutt/1.5.17 (2007-12-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70467>

On Mon, Dec 31, 2007 at 10:50:27 +0100, Pascal Obry wrote:
> Jan Hudec a =C3=A9crit :
> > By the way, what is your post-commit hook doing anyway? Modifying t=
he work
> > tree *after* a commit does not sound like a common thing to do.
>=20
> Or just trigger a build via a built robot or record a commit informat=
ion
> into an issue tracker...

That's not a case of "modifying a work tree *after* a commit".

There are many valid uses for post-commit hook and this is one of them.=
 But
like the others it does not modify versioned files. That was the issue
discussed (and pre-commit indeed turned out a better match).

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
