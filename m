From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Print last time and committer a file was touched by for a
	whole repo
Date: Thu, 1 Jul 2010 14:40:36 -0700
Message-ID: <20100701214035.GA2969@dcvr.yhbt.net>
References: <AANLkTikRElk07ZqK0TOM2WD31t-H5RVngvHNU9KM7e9D@mail.gmail.com> <20100701200525.GA3686@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tim Visher <tim.visher@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 01 23:41:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OURVQ-0006iq-Vx
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 23:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933143Ab0GAVkk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 17:40:40 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:43672 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758902Ab0GAVkh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 17:40:37 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 340361F511;
	Thu,  1 Jul 2010 21:40:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20100701200525.GA3686@burratino>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150089>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi Tim,
>=20
> Tim Visher wrote:
>=20
> > I need to get a listing of the entire contents of my current repo (=
as
> > in, I don't need deleted files or anything like that, just the curr=
ent
> > snapshot) with the time the file was committed and who committed it=
=2E
>=20
> You might be able to adapt Eric=E2=80=99s set-file-times script from =
[1].
>=20
> The set-file-times script was designed to produce consistent
> Last-Modified headers when serving static content from a cluster of
> HTTP servers.  It does not do the right thing for merges (it is
> missing at least =E2=80=98-c=E2=80=99), though it will at least produ=
ce consistent
> results in that case.  See the wiki page for details.

Yes, "git log -c" is more correct, thanks.

I've brought http://yhbt.net/git-set-file-times back up and updated it.
(I changed servers for yhbt.net around 1.5 years ago and broke
a bunch of links I forgot existed).

Since the rsync developers distribute an outdated (and missing
disclaimer) version of this, perhaps we should just include this in the
contrib/ section of git.git...

--=20
Eric Wong
