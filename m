From: Ulrich =?utf-8?B?U3DDtnJsZWlu?= <uqs@spoerlein.net>
Subject: Re: git merge commits are non-deterministic? what changed?
Date: Fri, 9 Nov 2012 16:42:45 +0100
Message-ID: <20121109154245.GP69724@acme.spoerlein.net>
References: <20121109133132.GK69724@acme.spoerlein.net>
 <m2y5iarf5s.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 16:43:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWqjW-0001Vq-Ct
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 16:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754316Ab2KIPmt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Nov 2012 10:42:49 -0500
Received: from acme.spoerlein.net ([88.198.49.12]:61752 "EHLO
	acme.spoerlein.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754215Ab2KIPms (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 10:42:48 -0500
Received: from localhost (acme.spoerlein.net [IPv6:2a01:4f8:131:23c2::1])
	by acme.spoerlein.net (8.14.5/8.14.5) with ESMTP id qA9FgjtR012138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 9 Nov 2012 16:42:45 +0100 (CET)
	(envelope-from uqs@spoerlein.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=spoerlein.net;
	s=dkim200908; t=1352475766;
	bh=QXxpHZDATnxT9Sytkts0c0GcSrgAojPo1v2e/iczsVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TthVEDe52vWiXoIHVshXtKBnBCpsQDBWJiHjOaNVtIkjVPNcvLqcfkTMTLEfhajf4
	 IdU945wCRc6bEVq4TVIffbKh6JXOsmibJx0HFqQRbqZXjSJilDlvwGUHc0/YgI2jJI
	 bb/uTMdppLP+RRDAsMDOyuSgNtOV0gMZNG0cQg8M=
Content-Disposition: inline
In-Reply-To: <m2y5iarf5s.fsf@igel.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209223>

On Fri, 2012-11-09 at 16:04:31 +0100, Andreas Schwab wrote:
> Ulrich Sp=C3=B6rlein <uqs@spoerlein.net> writes:
>=20
> > Two questions:
> > 1. Can we impose a stable ordering of the commits being recorded in=
 a
> > merge commit? Listing parents in chronological order or something l=
ike
> > that.
>=20
> The order is determined by the order the refs are given to git merge =
(or
> git commit-tree when using the plumbing).
>=20
> > 2. Why the hell is the commit hash dependent on the ordering of the
> > parent commits? IMHO it should sort the set of parents before
> > calculating the hash ...
>=20
> What would be the sort key?

Trivially, the hash of the parents itself. So you'd always get

=2E..
parent 0000
parent 1111
parent aaaa
parent ffff

hth
Uli
