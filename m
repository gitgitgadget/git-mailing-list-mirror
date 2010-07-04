From: Sam Vilain <sam@vilain.net>
Subject: Re: [WIP/PATCH] Teach fast-import to print the id of each imported
 commit
Date: Sun, 04 Jul 2010 12:02:40 +1200
Message-ID: <1278201760.9701.39.camel@denix>
References: <20100701031819.GA12524@burratino>
	 <20100701054849.GA14972@burratino> <20100702051201.GC7209@burratino>
	 <AANLkTintWyhcx9pURSqxs3e9BBkPx9KSPPYh4UOU7kv6@mail.gmail.com>
	 <20100702154028.GB2287@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 04 02:06:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVCiw-0006O1-Gy
	for gcvg-git-2@lo.gmane.org; Sun, 04 Jul 2010 02:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756172Ab0GDACW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Jul 2010 20:02:22 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:49773 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755265Ab0GDACV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jul 2010 20:02:21 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 10CF621C3E6; Sun,  4 Jul 2010 12:02:20 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 610EB21C35E;
	Sun,  4 Jul 2010 12:02:15 +1200 (NZST)
In-Reply-To: <20100702154028.GB2287@burratino>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150212>

On Fri, 2010-07-02 at 10:40 -0500, Jonathan Nieder wrote:
> Sverre Rabbelier wrote:
> > On Fri, Jul 2, 2010 at 07:12, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
>=20
> >> A =E2=80=98cat=E2=80=99 command (suggested by David) would also be=
 useful, so the
> >> caller can read trees and blobs before they are accessible through
> >> the object db.  The svn importer would use this when applying
> >> (svndiff0-format) deltas to import changes to regular files.
> >
> > How would the output be delimited? The same way fast-import expects
> > its blob input?
>=20
> Right.  I was imagining something like
>=20
>  <blob hash> blob <size>
>  ... content ...
>  <blank line>
>=20
> =C3=A0 la cat-file --batch.  Hopefully by the end of this weekend, if=
 no
> one else gets to it first.

It should be very simple to implement --batch-verify as well, which is
essentially the same thing, just only printing the header and not the
contents.

How hard do you think it would be to implement a 'rev-parse' command?
Perhaps you can see where this is going... :-)

Sam
