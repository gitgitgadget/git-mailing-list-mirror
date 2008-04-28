From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Simple problem
Date: Mon, 28 Apr 2008 18:49:45 +0200
Message-ID: <20080428164945.GA14445@atjola.homenet>
References: <fv4u49$oks$1@ger.gmane.org> <18453.64747.540905.586259@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Kenneth P. Turvey" <kt-usenet@squeakydolphin.com>,
	git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 18:50:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqWYo-0002cR-Jf
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 18:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936819AbYD1Qtv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2008 12:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936818AbYD1Qtv
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 12:49:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:52266 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S936817AbYD1Qtt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 12:49:49 -0400
Received: (qmail invoked by alias); 28 Apr 2008 16:49:47 -0000
Received: from i577B85F9.versanet.de (EHLO atjola.local) [87.123.133.249]
  by mail.gmx.net (mp013) with SMTP; 28 Apr 2008 18:49:47 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+wy9gaRtqwW3T+ZgnHlyhJ2RzUVmsqF10k9+b7SJ
	CLTmYOuOlEDY9A
Content-Disposition: inline
In-Reply-To: <18453.64747.540905.586259@lisa.zopyra.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80564>

On 2008.04.28 11:35:55 -0500, Bill Lear wrote:
> On Monday, April 28, 2008 at 16:31:05 (+0000) Kenneth P. Turvey write=
s:
> >I ran into an issue earlier today that I didn't know how to easily s=
olve=20
> >in git.  I'm sure it is easy to handle, but I wasn't sure how. =20
> >
> >I removed a file and then realized I'd hit the wrong one.  So all I=20
> >wanted to do was to get the file back the way it was in the last com=
mit. =20
> >
> >Basically I wanted something similar to:
> >
> >svn update myfile
> >
> >in subversion. =20
> >
> >I got it back by using a diff and just deleting all the minus signs =
at=20
> >the beginning of the lines, but I'm sure this isn't the way to handl=
e=20
> >this.  Strangely this simple case wasn't covered by any of the tutor=
ials=20
> >I looked at.=20
>=20
> % rm file
> [oops]
> % git checkout file

That restores the version from the index, so it will fail if you did
"git rm file". To get the file from HEAD use "git checkout HEAD --
file".

Bj=F6rn
