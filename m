From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Terminology question: "tracking" branches
Date: Tue, 28 Oct 2008 09:01:02 +0100
Message-ID: <20081028080102.GL3612@atjola.homenet>
References: <48F8AA5E.6090908@drmicha.warpmail.net> <48F8ECA2.3040208@xiplink.com> <48FC8624.9090807@fastmail.fm> <48FCB6B8.6090708@xiplink.com> <48FDA5A0.8030506@drmicha.warpmail.net> <48FDF28A.9060606@xiplink.com> <48FF3FEE.8020209@drmicha.warpmail.net> <20081022161302.GC16946@atjola.homenet> <490030AB.8090207@drmicha.warpmail.net> <20081027162840.GK3612@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Peter Harris <git@peter.is-a-geek.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Oct 28 09:02:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KujWz-00014U-5h
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 09:02:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308AbYJ1IBK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Oct 2008 04:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752120AbYJ1IBJ
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 04:01:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:36802 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751955AbYJ1IBI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 04:01:08 -0400
Received: (qmail invoked by alias); 28 Oct 2008 08:01:05 -0000
Received: from i577BB324.versanet.de (EHLO atjola.local) [87.123.179.36]
  by mail.gmx.net (mp005) with SMTP; 28 Oct 2008 09:01:05 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18BV30rVGoBz31lzikK/frU96/Ut0h4K2xgjyaPYR
	i3ZfBlcD8I5gj/
Content-Disposition: inline
In-Reply-To: <20081027162840.GK3612@atjola.homenet>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99279>

On 2008.10.27 17:28:40 +0100, Bj=F6rn Steinbrink wrote:
> On 2008.10.23 10:07:07 +0200, Michael J Gruber wrote:
> > That leaves open:
> >=20
> > - What does "remote branch" mean, if it means anything at all? It c=
ould
> > be used for a branch in a remote repository, i.e. the other side of
> > fetch/push refspec (remote branch:tracking branch).
>=20
> I prefer to say "the branch on the remote" there, but that's just to
> avoid confusion with "remote tracking branch".

So I just happened to use "git remote show origin" and that uses "remot=
e
branch" as you described it:

* remote origin
  URL: git://git.kernel.org/pub/scm/git/git.git
  Remote branch merged with 'git pull' while on branch master
    master
  Tracked remote branches
    html
    maint
    ...

JFYI
Bj=F6rn
