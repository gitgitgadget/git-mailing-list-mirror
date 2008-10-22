From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Terminology question: "tracking" branches
Date: Wed, 22 Oct 2008 18:13:02 +0200
Message-ID: <20081022161302.GC16946@atjola.homenet>
References: <48F7BBAC.2090907@xiplink.com> <48F83FD0.90606@drmicha.warpmail.net> <48F8A4E8.8070008@xiplink.com> <48F8AA5E.6090908@drmicha.warpmail.net> <48F8ECA2.3040208@xiplink.com> <48FC8624.9090807@fastmail.fm> <48FCB6B8.6090708@xiplink.com> <48FDA5A0.8030506@drmicha.warpmail.net> <48FDF28A.9060606@xiplink.com> <48FF3FEE.8020209@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Peter Harris <git@peter.is-a-geek.org>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Oct 22 18:16:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsgLt-0002GC-Hu
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 18:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753066AbYJVQNQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Oct 2008 12:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752950AbYJVQNQ
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 12:13:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:44552 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751290AbYJVQNP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 12:13:15 -0400
Received: (qmail invoked by alias); 22 Oct 2008 16:13:13 -0000
Received: from i577AD8B4.versanet.de (EHLO atjola.local) [87.122.216.180]
  by mail.gmx.net (mp012) with SMTP; 22 Oct 2008 18:13:13 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19LvBwcjNpL3Jsf3Q3f6VCISsLRB2RRVjMOf+BZo9
	ta3z5g9Vax0YdT
Content-Disposition: inline
In-Reply-To: <48FF3FEE.8020209@drmicha.warpmail.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98882>

On 2008.10.22 16:59:58 +0200, Michael J Gruber wrote:
> - a remote branch (a branch in your local repo which is a copy of a
> branch in a remote repo; stored under refs/remotes, never to be modif=
ied
> locally)
> - a (remote) tracking branch (a local branch which is set up to pull
> from a remote branch by default)

(Remote) tracking branches are actually what you called remote branches=
,
at least according to the git glossary. But I wonder, what is the right
term for a branch that has the --track setup for pull?

On #git I usually fall back to some variation of "a branch that is
configured for 'git pull'" or something similarly verbose (and maybe
that's even partially wrong/inaccurate/incomplete?). And I always try t=
o
stick to saying "remote tracking branch" and not just "tracking branch"
(as the glossary does) to avoid confusion as best as I can. But that
feels quite suboptimal.

So, is there some term that describes a local branch that has been
configured for "git pull"?

Thanks,
Bj=F6rn
