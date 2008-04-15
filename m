From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [new tool] git-project-version.sh
Date: Tue, 15 Apr 2008 13:55:29 +0200
Message-ID: <20080415115529.GA3595@atjola.homenet>
References: <20080415113629.GA17459@denkbrett.schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nico -telmich- Schottelius <nico-git-20080415@schottelius.org>
X-From: git-owner@vger.kernel.org Tue Apr 15 13:56:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jljlp-0002W4-Vj
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 13:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764690AbYDOLzd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Apr 2008 07:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764680AbYDOLzd
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 07:55:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:55145 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1764535AbYDOLzc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 07:55:32 -0400
Received: (qmail invoked by alias); 15 Apr 2008 11:55:30 -0000
Received: from i577AD265.versanet.de (EHLO atjola.local) [87.122.210.101]
  by mail.gmx.net (mp048) with SMTP; 15 Apr 2008 13:55:30 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+Uj55duSCUA6khoFckMQ+c3ukIO0QdNi1q9ByrI6
	u2MbL8xLdpf1LQ
Content-Disposition: inline
In-Reply-To: <20080415113629.GA17459@denkbrett.schottelius.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79589>

On 2008.04.15 13:36:29 +0200, Nico -telmich- Schottelius wrote:
> Hello!
>=20
> As I want to use the latest commit id in all my projects, so I know
> which commit the version is based on, I wrote an extremly simple scri=
pt
> that is based on git-show to display only the version named
> git-project-version.sh.
>=20
> You can find it in
>    http://unix.schottelius.org/git/git-tools.git/.git/
>    http://unix.schottelius.org/cgi-bin/gitweb.cgi?p=3Dgit-tools.git/.=
git;a=3Dsummary
> and more information is available on
>    http://nico.schottelius.org/notizbuch-blog/archive/2008/04/15/git-=
project-version-sh-written-versions-with-git/

Hm, except for the three trailing dots that you get with
--abbrev-commit, you can get the same results with rev-parse

$ git rev-parse  HEAD
8a18e8fe4e0e64222de6b063a976d0fe24955ddb

$ git rev-parse --short HEAD
8a18e8f

Bj=F6rn
