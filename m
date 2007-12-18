From: "=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>
Subject: Re: git-stash: RFC: Adopt the default behavior to other commands
Date: Tue, 18 Dec 2007 21:32:36 -0200
Message-ID: <b8bf37780712181532q5d05615bh78c99c80a87c2169@mail.gmail.com>
References: <20071217110322.GH14889@albany.tokkee.org>
	 <506C6191-655D-46AE-A5C2-1335A9044F44@lrde.epita.fr>
	 <7vk5nd53lp.fsf@gitster.siamese.dyndns.org>
	 <57F403E7-AF5B-40F1-AE9D-8EA036675A67@lrde.epita.fr>
	 <7vfxy04ze7.fsf@gitster.siamese.dyndns.org>
	 <20071218154211.GB12549@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?J=F6rg_Sommer?=" <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Wed Dec 19 00:33:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4lvp-0002TO-Bn
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 00:33:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754268AbXLRXcj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Dec 2007 18:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754223AbXLRXcj
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 18:32:39 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:2048 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800AbXLRXci convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Dec 2007 18:32:38 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1486585nfb.21
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 15:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Qgw1V3jbjL3NSSO2Auf4bCb9I23XaazmFHtstAOfRfM=;
        b=G/YaJcN6yKYTQ+9oH0ZwoISx+Iac3+iOlmCOuoHNBPmna6zVD0YZ6ceXcgSKyWBCWQggwm4PJ7JCo31l5J8jv2QN+no2F8AZSxa5t7PiM+0PK1cjdCZHWFPdKJzteJDzSrPRpn6JUBaU5+wbJBaNA6zKwX5j6T43pvG5SYaeB9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rSlMf+6Bwq8f2Dgx86nX6IUE4HUUgzmN2qrSUF3aZ9DS/ViZrSveIsgSyIzHiKBythR0cqfTEM6cB7qgCIfjGYLkkxi2gyMKHmDeJyA6JIL47rBj+fCHM3SAZxYv2tXBXkdh/bfUcfRp/mHkHSTTWMiKk+uUbB7Ub4cjGVHtqcs=
Received: by 10.78.137.7 with SMTP id k7mr11284431hud.68.1198020756389;
        Tue, 18 Dec 2007 15:32:36 -0800 (PST)
Received: by 10.78.100.6 with HTTP; Tue, 18 Dec 2007 15:32:36 -0800 (PST)
In-Reply-To: <20071218154211.GB12549@alea.gnuu.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68848>

On Dec 18, 2007 1:42 PM, J=F6rg Sommer <joerg@alea.gnuu.de> wrote:
> Hi,
>
> Junio C Hamano schrieb am Mon 17. Dec, 16:31 (-0800):
> > Benoit Sigoure <tsuna@lrde.epita.fr> writes:
> >
> > >> Benoit Sigoure <tsuna@lrde.epita.fr> writes:
> > >>
> > >>> ...  The current behavior of git stash is very
> > >>> dangerous ...
> > > ...
> > >> This is a plain FUD, isn't it?  The first Oops should not happen=
 these
> > >> days.
> >
> > But the original point by Sebastian hasn't been answered.  He wante=
d to
> > make the command list the stash without arguments.
> >
> > This was discussed already in the early days of stash and there ind=
eed
> > was a suggestion to do so (I think I sided with that), but the user=
s did
> > not want it.  IIRC, the argument went like: "when I say 'stash', th=
at is
> > because I want a quick and immediate way to stash, and I do not wan=
t a
> > list.  If I do not have to have a quick way, I would create a tempo=
rary
> > commit on the current branch, or switch to a temporary branch and c=
ommit
> > there."
>
> When it should go quick why don't use an alias. git stash can print t=
he
> list and everyone who wants a quick stash can create an alias for thi=
s.
>
> I vote for stash print the list, because I dropped in the pitfall.
>

I got caught by this default too. One vote more!

Regards,
--=20
[]s,
Andr=E9 Goddard
