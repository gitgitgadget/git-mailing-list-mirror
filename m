From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH 3/3] git-push: make git push --dry-run --porcelain exit
 with status 0 even if updates will be rejected
Date: Fri, 26 Feb 2010 23:01:30 -0500
Message-ID: <20100227040130.GA11517@cthulhu>
References: <cover.1267216808.git.larry@elder-gods.org>
 <6d253d15b5174c3982bcc434b7c2b361712d20cb.1267216808.git.larry@elder-gods.org>
 <be6fef0d1002261844u5082b5bv90d46852218f632e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 05:01:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlDs0-0003zk-1H
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 05:01:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967790Ab0B0EBb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Feb 2010 23:01:31 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:33824 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967767Ab0B0EBb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 23:01:31 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 9FED7822014; Fri, 26 Feb 2010 23:01:30 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <be6fef0d1002261844u5082b5bv90d46852218f632e@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141176>

* Tay Ray Chuan (rctay89@gmail.com) [100226 21:44]:
> Hi,
>=20
> On Sat, Feb 27, 2010 at 4:44 AM, Larry D'Anna <larry@elder-gods.org> =
wrote:
> > The script calling git push --dry-run --porcelain can see clearly f=
rom the
> > output that the updates will be rejected. =A0However, it will proba=
bly need to
> > distinguish this condition from the push failing for other reasons,=
 such as the
> > remote not being reachable.
> >
> > Signed-off-by: Larry D'Anna <larry@elder-gods.org>
>=20
> I thought that in the previous iteration, the status won't be touched
> anymore? You agreed too:
>=20
>   <20100210055529.GA1566@cthulhu>

fixed.

        --larry
