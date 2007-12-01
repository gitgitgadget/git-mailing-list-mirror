From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: how to create v2 patch
Date: Sat, 1 Dec 2007 15:14:10 +0100
Message-ID: <20071201141410.GA4430@atjola.homenet>
References: <47515693.9070405@imap.cc> <m3r6i6wm1g.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tilman Schmidt <tilman@imap.cc>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 01 15:14:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyT76-0007Iy-SZ
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 15:14:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbXLAOOO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Dec 2007 09:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbXLAOOO
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 09:14:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:60130 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751380AbXLAOOO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 09:14:14 -0500
Received: (qmail invoked by alias); 01 Dec 2007 14:14:11 -0000
Received: from i577AF8FB.versanet.de (EHLO localhost) [87.122.248.251]
  by mail.gmx.net (mp003) with SMTP; 01 Dec 2007 15:14:11 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/ye0Zx7hvyM0+3tpC0f+PXmJHHhfG01WsiVK7cb4
	4qRnxQKcsr4Qtc
Content-Disposition: inline
In-Reply-To: <m3r6i6wm1g.fsf@roke.D-201>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66721>

On 2007.12.01 06:02:23 -0800, Jakub Narebski wrote:
> Tilman Schmidt <tilman@imap.cc> writes:
>=20
> > Let's say that following the scheme laid out in
> > "Everyday GIT ...", chapter "Individual Developer (Participant)".
> > I have produced a patch, submitted it to LKML, received a few
> > comments, committed appropriate changes to my local git tree,
> > and now want to submit a revised patch. How do I do that?
>=20
> If you have original commit and commit with corrections on top of it,
> do a squash rebase using "git rebase -i" (interactive), or do a squas=
h
> merge.
>=20
> In the future it would be better to just amend ("git commit --amend")
> original commit (or if you are using StGIT, "stg refresh" it).

=46or completeness:
To use "git commit --amend" for any but the latest commit, you use
rebase -i, too. Just change the "pick" for the commit you want to amend
to "edit". Rebasing will stop _after_ applying that commit and you can
amend it.

Bj=F6rn
