From: Matt McCutchen <matt@mattmccutchen.net>
Subject: Making the "Note from the maintainer" information discoverable
Date: Tue, 09 Feb 2016 15:30:39 -0500
Message-ID: <1455049839.2511.208.camel@mattmccutchen.net>
References: <1454789548.23898.223.camel@mattmccutchen.net>
	 <xmqqlh6w9isp.fsf@gitster.mtv.corp.google.com>
	 <1454893478.2511.5.camel@mattmccutchen.net>
	 <20160208135607.GB27054@sigill.intra.peff.net>
	 <xmqqziva6e6e.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 09 21:30:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTEvx-0002rX-2x
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 21:30:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754265AbcBIUap convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Feb 2016 15:30:45 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:36544 "EHLO
	homiemail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751802AbcBIUao convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 9 Feb 2016 15:30:44 -0500
Received: from homiemail-a3.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a3.g.dreamhost.com (Postfix) with ESMTP id 44265284081;
	Tue,  9 Feb 2016 12:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=
	mattmccutchen.net; bh=PHtNb/UeMFHiYJS/CLMC22LyBVg=; b=b4IS2pF/Am
	7/Z5g6RQYJ8/LgF0n3Et67Mex3HlYuDrViIxrbcYMOCCRLPgrXuoc7BQxWL3a/D/
	IuQYMSkk29gk45pfYbOlj3+TgMsPoebKPbUwGoVnnNLRGAQTZcpkHL6djdpa4dq8
	IQsmYcxcBPLGr4f4hIyGO+10TuaIES0V8=
Received: from main (30-9-175.wireless.csail.mit.edu [128.30.9.175])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: matt@mattmccutchen.net)
	by homiemail-a3.g.dreamhost.com (Postfix) with ESMTPSA id C303E284078;
	Tue,  9 Feb 2016 12:30:43 -0800 (PST)
In-Reply-To: <xmqqziva6e6e.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.18.4 (3.18.4-1.fc23) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285855>

On Mon, 2016-02-08 at 14:16 -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > FWIW, as the person who wrote that section, I think that is a good
> > addition.=C2=A0=C2=A0We do have a link to Simon Tatham's bug-report=
ing guide,
> > but
> > this is a good place to put project-specific advice.
> >=20
> > In addition to "try it on next" you may want to also mention "try
> > it on
> > the latest version of git". That is another frequently given
> > pointer to
> > bug reporters.=C2=A0=C2=A0Trying "next" is obviously a superset, bu=
t I
> > suspect
> > trying a released version may be an easier first step for some
> > people.
>=20
> Yes, definitely.
>=20
> I agree that testing with the latest released version would
> typically be much easier to end users than building from the source.
> It would reduce the need for "Ah, that's ancient issue, we know it
> was fixed a few releases ago." responses by us; I do not recall many
> of such responses in the recent history on the list, though.
>=20
> For the ones who are more into the spirit of helping each other who
> can build from the source to help us even more, checking 'master'
> and finding regressions before it gets too late is a very good
> thing.=C2=A0=C2=A0Checking 'next' and confirming an upcoming fix is e=
qually
> valuable.

While researching an unrelated issue, I stumbled upon
http://marc.info/?l=3Dgit&m=3D142714670111063&w=3D2, which seems to hav=
e even
more valuable information about community processes.=C2=A0=C2=A0Is ther=
e any
interest in making this information discoverable from
https://git-scm.com/community and/or the man pages? =C2=A0I'm happy to =
file
an issue or to write a patch that adds a link, but I don't see myself
spending more time on it than that.

Matt
