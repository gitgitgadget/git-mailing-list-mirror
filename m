From: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH 7/8] gitweb: Use different colors to present marked
 changes
Date: Mon, 13 Feb 2012 07:46:09 +0100
Message-ID: <20120213074609.2222bd6a@mkiedrowicz.ivo.pl>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1328865494-24415-8-git-send-email-michal.kiedrowicz@gmail.com>
	<m3pqdksyg1.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 07:46:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rwpg2-00029I-Vb
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 07:46:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683Ab2BMGqO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Feb 2012 01:46:14 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43528 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822Ab2BMGqN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2012 01:46:13 -0500
Received: by eaah12 with SMTP id h12so1676542eaa.19
        for <git@vger.kernel.org>; Sun, 12 Feb 2012 22:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=fWTZax1ARp+GNBBii0OZ3gXpQ6rRogzRhsiAynQQDqQ=;
        b=opFo0KLVL03bOpJHiQMPTTx9nhfGWeLm6pIY7NCKyaSdlHhOa5TXqEe+q4f7KxoeKy
         J9rypA3wQRTYu6x3rtlzLJ3DW6QC4HOx8s9OjZBFde536Yp0X3/nhK/9BTLgaBcpLXO0
         NptmQMQhHx08WchupYe5SE+rxgDQscZsL6cqA=
Received: by 10.213.2.74 with SMTP id 10mr2506822ebi.11.1329115572107;
        Sun, 12 Feb 2012 22:46:12 -0800 (PST)
Received: from mkiedrowicz.ivo.pl (pc10.ivo.park.gdynia.pl. [153.19.128.10])
        by mx.google.com with ESMTPS id o49sm57807483eei.0.2012.02.12.22.46.11
        (version=SSLv3 cipher=OTHER);
        Sun, 12 Feb 2012 22:46:11 -0800 (PST)
In-Reply-To: <m3pqdksyg1.fsf@localhost.localdomain>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190612>

Jakub Narebski <jnareb@gmail.com> wrote:

> Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
>=20
> > This makes use of the highlight diff feature.
> >=20
> > Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> > ---
> > I decided to split mechanism (generate HTML page with <span>
> > elements that mark interesting fragments of diff output) from
> > politics (use these particular colors for this <span> elements),
> > but otherwise this commit may be squashed with the previous one.
> > These colors work for me but if someone comes out with better ones,
> > I'd be happy.
>=20
> I think it would be better squashed with previous patch, otherwise it
> is a bit not visible change...

OK, but please note that since previous patch HTML contains <span>
elements around differing segments of diff so the change exists. It
just isn't reflected by CSS.

> =20
> >  gitweb/static/gitweb.css |    8 ++++++++
> >  1 files changed, 8 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
> > index c7827e8..4f87d16 100644
> > --- a/gitweb/static/gitweb.css
> > +++ b/gitweb/static/gitweb.css
> > @@ -438,6 +438,10 @@ div.diff.add {
> >  	color: #008800;
> >  }
> > =20
> > +div.diff.add span.marked {
> > +	background-color: #77ff77;
> > +}
> > +
> >  div.diff.from_file a.path,
> >  div.diff.from_file {
> >  	color: #aa0000;
> > @@ -447,6 +451,10 @@ div.diff.rem {
> >  	color: #cc0000;
> >  }
> > =20
> > +div.diff.rem span.marked {
> > +	background-color: #ff7777;
> > +}
> > +
> >  div.diff.chunk_header a,
> >  div.diff.chunk_header {
> >  	color: #990099;
> > --=20
>=20
> I'd have to see those colors in use. =20

Then why don't you try it?

> BTW what colors other
> highlighting diff GUIs use?
>=20

AFAIK they just use darker red/green background than for the rest of
line.
