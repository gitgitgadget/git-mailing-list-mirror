From: Alexey Shumkin <zapped@mail.ru>
Subject: Re: Special characters in file name
Date: Sun, 4 Sep 2011 00:09:33 +0400
Message-ID: <20110904000933.195d5bf4@zappedws>
References: <4E60C6D0.7090609@intland.com>
	<loom.20110902T143646-347@post.gmane.org>
	<20110903144617.GA17893@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Tajti =?UTF-8?B?w4Frb3M=?= <akos.tajti@intland.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 03 22:20:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzwhE-0005lh-NQ
	for gcvg-git-2@lo.gmane.org; Sat, 03 Sep 2011 22:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071Ab1ICUTy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Sep 2011 16:19:54 -0400
Received: from fallback3.mail.ru ([94.100.176.58]:48822 "EHLO
	fallback3.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017Ab1ICUTx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Sep 2011 16:19:53 -0400
X-Greylist: delayed 610 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Sep 2011 16:19:53 EDT
Received: from smtp9.mail.ru (smtp9.mail.ru [94.100.176.54])
	by fallback3.mail.ru (mPOP.Fallback_MX) with ESMTP id 015CC80B1E3F
	for <git@vger.kernel.org>; Sun,  4 Sep 2011 00:10:19 +0400 (MSD)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date; bh=y/Awkgio9et9aGAd5zMtjsKtWEftWNAv7NNuLY9VfMs=;
	b=pab6DqEXdHd1n+ZDSyxcSr2wVUFJ08iUdmwRDgRJRDf1yZplA0owCmVS4GxUGoDL9rEkzyPi9hk3iAztR77S79flopXWl2jFUhY7PJIfB1O8dqnOBI0DJdzD6V/WDfKx;
Received: from [91.77.24.67] (port=56950 helo=zappedws)
	by smtp9.mail.ru with psmtp 
	id 1QzwX8-0008Mt-00; Sun, 04 Sep 2011 00:09:42 +0400
In-Reply-To: <20110903144617.GA17893@elie>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; i386-redhat-linux-gnu)
X-Spam: Not detected
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180664>

> Hi Alexey,
>=20
> Alexey Shumkin wrote:
> > Tajti =C3=81kos writes:
>=20
> >> I have a file named "=C3=A1rv=C3=ADz.txt" in my repository. When m=
odify that
> >> file and execute git diff, the first line looks like this:
> >> diff --git "a/\303\241rv\303\255z.txt" "b/\303\241rv\303\255z.txt"
> >>
> >> Is there an option that (if specified) will get git to print
> >> "=C3=A1rv=C3=ADz.txt" instead of this escaped string?
> [...]
> > please, refresh your memory )))
> > http://comments.gmane.org/gmane.comp.version-control.git/177849
> >
> > see my comment
> > http://permalink.gmane.org/gmane.comp.version-control.git/177857
>=20
> Cc-ing =C3=81kos so he can actually get your message this time. :)  (=
=46WIW
> the convention on this list is always to reply-to-all.)
Yes, I know, but I replied with the gmane.org site form, and it did not
CC-ed
