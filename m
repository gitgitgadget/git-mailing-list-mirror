From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to hierarchically merge from the root to the leaf of a branch tree? (Patch stack management)
Date: Thu, 1 Aug 2013 07:28:08 +0000 (UTC)
Message-ID: <loom.20130801T092209-291@post.gmane.org>
References: <ktc2sl$d4f$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 01 09:28:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4nJJ-0007o1-3d
	for gcvg-git-2@plane.gmane.org; Thu, 01 Aug 2013 09:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532Ab3HAH23 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Aug 2013 03:28:29 -0400
Received: from plane.gmane.org ([80.91.229.3]:42128 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750756Ab3HAH22 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Aug 2013 03:28:28 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1V4nJB-0007iS-Tu
	for git@vger.kernel.org; Thu, 01 Aug 2013 09:28:26 +0200
Received: from dcf151.neoplus.adsl.tpnet.pl ([83.23.57.151])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Aug 2013 09:28:25 +0200
Received: from jnareb by dcf151.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Aug 2013 09:28:25 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 83.23.57.151 (Mozilla/5.0 (X11; Linux i686) AppleWebKit/537.22 (KHTML, like Gecko) Ubuntu Chromium/25.0.1364.160 Chrome/25.0.1364.160 Safari/537.22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231485>

Jens M=C3=BCller <blog <at> tessarakt.de> writes:

>=20
> Hi all!
>=20
> I mainly use Git for version control, but have also tried out Mercuri=
al.
> While I don't really like Mercurial in general, the idea of maintaini=
ng
> clearly separated patches with Mercurial Queues (MQ) is quite appeali=
ng.
> Therefore, I am looking for something similar (but easier to use, mor=
e
> "gitty" and maybe even more powerful) in Git.

On Git Homepage and on Git Wiki you can find a (partial) list of Git
tools.  Among those there are patch-management interface tools, such
as Guilt (formerly Git Queues (GQ), inspired by Mercurial Queues (MQ))
and StGit.

There is also TopGit, which is feature-branch management tools (which
seems like what you want, from what you written below).


Unfortunately I don't know which of those projects are actively
maintained...

> So I will first explain what I have in mind:
>=20
> As an example, let's say I am doing test-driven development. My maste=
r
> branch follows the main repository of the software. Branched out from
> that, I have a branch called "feature-test", and branched out from th=
at,
> "feature-implementation":
>=20
>     master
>     |_ feature-test
>        |_ feature-implementation
>=20
> For each branch, I remember the parent branch.
>=20
> Implementation would then work like this: I checkout feature-test and
> write some test. Then I checkout feature-implementation, rebase it to
> the current status of feature-test and write the implemenation. And s=
o on.
[...]
