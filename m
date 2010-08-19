From: Eric Wong <normalperson@yhbt.net>
Subject: Re: t9155 fails since "git-svn: fix fetch with deleted tag" with
	svn < 1.5
Date: Thu, 19 Aug 2010 12:14:25 -0700
Message-ID: <20100819191425.GA1543@dcvr.yhbt.net>
References: <4C6D6274.90009@web.de> <AANLkTiky8qn_PSgXSn=0h07cb4VmCFiFXmD9WrpO1z6z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	"David D. Kilzer" <ddkilzer@kilzer.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Aug 19 21:14:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmAZM-0004oO-Cf
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 21:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754488Ab0HSTO1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 15:14:27 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57733 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753319Ab0HSTO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 15:14:26 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D7C71F4FC;
	Thu, 19 Aug 2010 19:14:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <AANLkTiky8qn_PSgXSn=0h07cb4VmCFiFXmD9WrpO1z6z@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153948>

=C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> wrote:
> On Thu, Aug 19, 2010 at 16:57, Jens Lehmann <Jens.Lehmann@web.de> wro=
te:
> > t9155 fails on current next when running the testsuite on a Fedora
> > Core 7 system. The reason is that FC7 comes with svn 1.4.4, while
> > in commit 3235b70 the --parents option was introduced into t9155
> > which was added in svn 1.5.

The --parents option appears completely unnecessary in this case,
so removing it should be safe.  Patch coming...

> > What minimum svn version is required for git svn? I didn't find any
> > information about that, but I might have overlooked something ...
>=20
> We currently require >=3D 1.1.0 of SVN::Core for the git-svn tests at=
 least.

That's still the only hard requirement I know of.  While I haven't had =
a
1.1.x installation in years, reports of incompatibility have been few.
So either people find it easier to upgrade to newer versions of SVN,
don't care, or there just aren't that many incompatibilities.

I'd say we will continue to do our best to support whatever versions
people care to report (preferably with patches :) incompatibilities for=
=2E

--=20
Eric Wong
