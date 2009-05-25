From: Johan Herland <johan@herland.net>
Subject: Re: git submodule update --merge (Was: What's cooking in git.git (May 2009, #02; Sun, 17))
Date: Mon, 25 May 2009 13:59:37 +0200
Message-ID: <200905251359.37619.johan@herland.net>
References: <7vab5ci281.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0905191348460.4266@intel-tinevez-2-302> <200905191526.40471.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, markus.heidelberg@web.de,
	Peter Hutterer <peter.hutterer@who-t.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 14:00:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8YqX-0002nE-QY
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 14:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbZEYL74 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 May 2009 07:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbZEYL74
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 07:59:56 -0400
Received: from sam.opera.com ([213.236.208.81]:55255 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751367AbZEYL7z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 07:59:55 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id n4PBxbk1010415
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 25 May 2009 11:59:47 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <200905191526.40471.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119927>

On Tuesday 19 May 2009, Johan Herland wrote:
> On Tuesday 19 May 2009, Johannes Schindelin wrote:
> > On Tue, 19 May 2009, Johan Herland wrote:
> > > I still don't see any reason why one should be added (--rebase),
> > > and not the other (--merge).
> >
> > When you rebase, you see your personal stuff (i.e. stuff that you
> > do not want to submit, or not in its current form, or that you
> > submitted and it waits for inclusion) on top of things right away.
>
> But if there are developers downstream whose work is based on your
> submodule branch, the rebase will disrupt _their_ work, in the same
> way that rebasing any other public branch would disrupt people's
> work.
>
> > In contrast, if you merge, you will have a different state from the
> > upstream _forever_.  Even if your stuff gets included.
>
> Correct, but there are cases where reconciliation with the upstream
> repo is less important than not disrupting downstream developers (see
> below).
>
> > Needless to say, I do not see much use for the latter case, but
> > tons for the former.
>
> I fully agree that for a regular downstream (or "leaf") developer,
> there is not much use for git submodule rebase --merge.
>
> But not all developers fit nicely into your scenario above.
>=20
> [Workflow description in which "git submodule update --merge" would
>  be a helpful addition]
>
> I understand that the above scenario is not common in the free
> software world, but I believe it is much more common in an
> enterprise/company setting. Therefore, the support of such workflows
> is important to companies that are currently considering (or have
> already chosen) Git. I believe there is value in supporting such
> workflows, especially when doing so is as straightforward as my patch
> shows.

I haven't received any replies to my attempt to describe the context in=
=20
which "git submodule update --merge" is useful. A hint as to whether my=
=20
argument is valid, or just crap, would be nice.

In any case, even if we don't include "git submodule update --merge",=20
could we _please_ consider changing the associated config variable from

=A0 submodule.<name>.rebase =3D true/false (false if unset)

to something like

=A0 submodule.<name>.update =3D checkout/rebase (checkout if unset)

or (Junio's suggestion)

  submodule.<name>.rebind =3D never/rebase (never if unset)

so that we at least have the _option_ of adding other alternatives in=20
the future?


Have fun! :)

=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
