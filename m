From: Caleb Thompson <caleb@calebthompson.io>
Subject: Re: [PATCH v4 1/4] commit test: Use test_config instead of git-config
Date: Thu, 12 Jun 2014 14:23:40 -0500
Message-ID: <20140612192340.GA44281@sirius.local>
References: <1402511079-17735-1-git-send-email-caleb@calebthompson.io>
 <1402511079-17735-2-git-send-email-caleb@calebthompson.io>
 <20140612084152.GA6095@hudson.localdomain>
 <20140612135051.GA35824@sirius.local>
 <20140612180459.GA15556@hudson.localdomain>
 <20140612180830.GB15556@hudson.localdomain>
 <20140612182341.GA42013@sirius.local>
 <20140612184637.GA16641@hudson.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
To: Jeremiah Mahler <jmmahler@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 21:23:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvAbE-0007Ic-40
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 21:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbaFLTXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 15:23:44 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:58892 "EHLO
	new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750886AbaFLTXn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jun 2014 15:23:43 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 8CD244EE;
	Thu, 12 Jun 2014 15:23:42 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 12 Jun 2014 15:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=calebthompson.io;
	 h=date:from:to:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=mesmtp; bh=frZL7cm2pBtkXM6rwaPpwNSz
	LSA=; b=Q6WfKnpKnkckwLcPUtVgfno9+KOuxj7xrNK7/tv+lFkp9hlt7jQGaNNl
	gDq4iLYHg7hEpJu4fTb4grtkJAJ31ApCJw3IvH0WdCOjCQ/2dOTkE0IBAxGXLT4h
	6x8/99cbh3Eu3ebiIXxhAEQcfY45Acwnon9rSqUT70nYc1PMfxo=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:to:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=smtpout;
	 bh=frZL7cm2pBtkXM6rwaPpwNSzLSA=; b=P42i4MHBE02vrNxh6MnEgzgGUYm+
	8lY8l2azh30UN8L1RvWa6vmgeqae65lqG3V2AqrJXg8N307Wu+Z9Bz2KMzE46gge
	AyvBspmFusOzwSeBMVABT+Av3RNapREPqOBGr5SMColJUo/iHUD6ptPBIgO6vkuj
	umSrBYST6/BS4HA=
X-Sasl-enc: 5gso50asBCsP1hPBQHmTlKJexeJyVH6aUJelrGWI0kAX 1402601021
Received: from localhost (unknown [67.78.97.126])
	by mail.messagingengine.com (Postfix) with ESMTPA id EA22968011C;
	Thu, 12 Jun 2014 15:23:41 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20140612184637.GA16641@hudson.localdomain>
X-PGP-Key: fp="B432 C068 2FD1 C2D0 6A8B 3951 1621 ADC2 A0AC E70A";
 id="0xA0ACE70A"; get=<http://calebthompson.io/pubkey.asc>;
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251482>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Jeremiah,

That looks great. Since I'm not seeing any more feedback on the code for this
set of patches, I'll go ahead and send up another set.

Thank you for those pointers.

Caleb Thompson

On Thu, Jun 12, 2014 at 11:46:37AM -0700, Jeremiah Mahler wrote:
> Caleb,
>
> On Thu, Jun 12, 2014 at 01:23:41PM -0500, Caleb Thompson wrote:
> > Jeremiah,
> >
> > On Thu, Jun 12, 2014 at 11:04:59AM -0700, Jeremiah Mahler wrote:
> > >
> ...
> > >
> > > How are you preparing your patches.  'git format-patch' with a 'git
> > > send-email'?
> >
> > I'm so glad you asked, because I've just been muddling through this.
> >
> > I've been generating the cover page variously with request-pull or diff
> > --stat, then running a command like this, with --cc arguments added from
> > a list I've been keeping of people who respond to the threads:
> >
> >     git send-email --compose --to=git@vger.kernel.org --thread \
> >         [--cc ...] --no-chain-reply origin/master...
> >
> > Then I manually edit the subjects to add the version to the [PATCH N/M]
> > portions. I haven't been using format-patch.
> >
> > It's interesting that only the first patch isn't applying. I'd love to
> > hear a better way.
> >
> > Caleb
>
> It sounds like you are doing too much work.
>
> After I make a series of commits I run format-patch.  This example has 2
> patches (-2).  I like --thread, although it seems to work fine without
> it.  And --reroll-count will automatically do your N/M numbering for
> you.  It also generates a cover letter which you can then edit by hand.
> All the patches will be named v3-* in this case.
>
>   git format-patch --reroll-count=3 --cover --thread -2
>
> Then I can send the whole patch series using send-email.
>
>   git send-email --to=caleb --cc=git --cc=junio v3-*
>
> Felipe Contreras has a good writeup [1] on how to setup aliases with Mutt so
> you don't have to type the full email every time.
>
> [1]: http://felipec.wordpress.com/2009/10/25/git-send-email-tricks/
>
> I recently setup Mutt with Offlineimap [2] and Msmtp.  This is an
> awesome setup too.  Not patch related, but it makes the email part
> easier.
>
> [2]: https://wiki.archlinux.org/index.php/OfflineIMAP
>
> --
> Jeremiah Mahler
> jmmahler@gmail.com
> http://github.com/jmahler

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJTmf48AAoJEBYhrcKgrOcKEHUH/jkI694ax/JuFYK/rEffvHmt
5YZ3dtmDeH/dVtnQ8r4H9BmEv7tIUcSqdU/uoAVVE+flHwzyE+eCEQOu5COWbILl
EeIwvz7r4V19ng0mf+NDNAPWUNsXLT09b93pZghIB7XROGmBcbOJ997Bv54NmF8h
+RIBV+bWI9JVUZzrUZmmRTmawnTJ8segPZkek5jUYSCLRtapY+QbEiASjC4DefbZ
57589o9B2JkDLqDi1zZN8kn6/9HU4w0coN0le+EZ99XyA5Xr+FhXiVoQnq463CMh
SKl+X72cVr01WBoMGHc4StDTlwkFqJSSc99N+MAsrsd3EEsdRac6YeRuziM7QHA=
=If1m
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
