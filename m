From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 16 Jan 2008 08:46:29 -0800 (PST)
Message-ID: <m33asxn2gt.fsf@roke.D-201>
References: <478E1FED.5010801@web.de>
	<alpine.LSU.1.00.0801161531030.17650@racer.site>
	<427BE4FD-6534-4CB2-91F8-F9014DC82B54@sb.org>
	<alpine.LSU.1.00.0801161629580.17650@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-14
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevin Ballard <kevin@sb.org>, Mark Junker <mjscod@web.de>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 16 17:47:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFBPt-0001FD-92
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 17:47:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbYAPQqd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jan 2008 11:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752184AbYAPQqd
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 11:46:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:10572 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164AbYAPQqc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 11:46:32 -0500
Received: by ug-out-1314.google.com with SMTP id z38so232910ugc.16
        for <git@vger.kernel.org>; Wed, 16 Jan 2008 08:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        bh=kmpOOdD+IBnjcaAqbPlcFS8Da7t6mCNwhhVNNKjXkzc=;
        b=QJ9EgsYMiXv8xfXmayybplIi5nSq3DQfR5bqdQ0l5DDgqopqLCg5tc0GqjGbwEk/oiiQa/IBoXxnkKvObqkjvgLp/C2CJ9xlh/n319KH7/fh6f9zf9WfcqGTJD0ar+AZUzDYu0+vI7HlMfSL54pRfniRI0jx7novIWgk6W5jlKA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        b=e0HT8lzm5J2KmnvVQNB3GiTh0WH1HgAiNaFDR4zRajEmPO5GZH7iRxNYIw5Xe1McZC3lSGUAtOLXIipHAieGHNTEQIPq5560VampUvEGGZ0+Ur5KWTg8dvIdpbokaWuC+O1cCoLRBEqaYVb6wmbC/RZm7K7UfV0+r7UPeTBMcfw=
Received: by 10.66.221.18 with SMTP id t18mr2267443ugg.80.1200501990588;
        Wed, 16 Jan 2008 08:46:30 -0800 (PST)
Received: from roke.D-201 ( [83.8.213.34])
        by mx.google.com with ESMTPS id j34sm1957224ugc.66.2008.01.16.08.46.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Jan 2008 08:46:29 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id m0GGkMTi020345;
	Wed, 16 Jan 2008 17:46:22 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m0GGjt5R020336;
	Wed, 16 Jan 2008 17:45:55 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <alpine.LSU.1.00.0801161629580.17650@racer.site>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70701>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 16 Jan 2008, Kevin Ballard wrote:
>=20
> > On Jan 16, 2008, at 10:34 AM, Johannes Schindelin wrote:
> >=20
> > > On Wed, 16 Jan 2008, Mark Junker wrote:
> > >=20
> > > > I have some files like "L=FCftung.txt" in my repository. The st=
range=20
> > > > thing is that I can pull / add / commit / push those files with=
out=20
> > > > problem but git-status always complains that thoes files are=20
> > > > untraced (but not missing).
> > >=20
> > > This is a known problem.  Unfortunately, noone has implemented a =
fix,=20
> > > although if you're serious about it, I can point you to threads w=
here=20
> > > it has been hinted how to solve the issue.
> > >=20
> > > FWIW the issue is that Mac OS X decides that it knows better how =
to=20
> > > encode your filename than you could yourself.
> >=20
> > More like, Mac OS X has standardized on Unicode and the rest of the=
=20
> > world hasn't caught up yet. Git is the only tool I've ever heard of=
 that=20
> > has a problem with OS X using Unicode.
>=20
> No.  That's not at all the problem.  Mac OS X insists on storing _ano=
ther_=20
> encoding of your filename.  Both are UTF-8.  Both encode the _same_=20
> string.  Yet they are different, bytewise.  For no good reason.

To be more exact encoding used to _create_ file differs from encoding
returned when _reading directory_...=20
=20
> Stop spreading FUD.  Git can handle Unicode just fine.  In fact, Git =
does=20
> not _care_ how the filename is encoded, it _respects_ the user's choi=
ce,=20
> not only of the encoding _type_, but the _encoding_, too.

=2E..which means that sequence of bytes differ. And Git by design is
(both for filenames and for blob contents) encoding agnostic.

HFS+ is just _stupid_. And unfortunately Git doesn't support stupid
filesystems (e.g. case insensitive filesystems) well.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
