From: Henrik =?utf-8?b?R3J1YmJzdHLDtm0=?= <grubba@grubba.org>
Subject: Re: merging branches with separate but identical history
Date: Wed, 1 Sep 2010 12:35:41 +0000 (UTC)
Message-ID: <loom.20100901T142437-744@post.gmane.org>
References: <AANLkTikoDkhKTRmob=B_NYJSYoby0J3Zo-Qp43AU9WfZ@mail.gmail.com> <AANLkTikTzZe=c=RaEYSr_wjfHht4PZihggnV9vEOehvy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 01 14:36:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqmXt-0007lQ-Fw
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 14:36:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032Ab0IAMf5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 08:35:57 -0400
Received: from lo.gmane.org ([80.91.229.12]:38001 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753636Ab0IAMf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 08:35:56 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OqmXe-0007ao-3n
	for git@vger.kernel.org; Wed, 01 Sep 2010 14:35:50 +0200
Received: from shipon.roxen.com ([212.247.28.156])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 14:35:50 +0200
Received: from grubba by shipon.roxen.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 14:35:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 212.247.28.156 (Mozilla/5.0 (X11; U; SunOS i86pc; en-US; rv:1.9.2) Gecko/20100117 Firefox/3.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155041>

Craig de Stigter <craig.destigter <at> koordinates.com> writes:

> Hi list

Hi.

> I have two branches which start with the same commits, and I want to =
merge
> them.
> I believe the two branches were individually pulled from the same SVN
> repo, so they look like this:
>=20
> branch1: a--b--c--d--e--f--1--3--5
> branch2: a--b--c--d--e--f--2--4--6
[...]
> Is there a way to do this without the duplicates? (perhaps a way to
> mark the branch as merged up to 'f', without actually performing a
> merge?)

Yes, you can use grafts (cf gitrepository-layout(5)) to rewrite the par=
ent
pointer for eg commit 2 from f(2) to f(1).

> Thanks
> Craig de Stigter

--=20
Henrik Grubbstr=C3=B6m                                         <grubba@=
grubba.org>
Roxen Internet Software AB                                <grubba@roxen=
=2Ecom>
