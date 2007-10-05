From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: stgit: editing description of patch
Date: Fri, 5 Oct 2007 09:16:17 +0000 (UTC)
Message-ID: <fe4vd1$4s2$1@sea.gmane.org>
References: <9e4733910710031626kff59666y77ba9001c0fef907@mail.gmail.com>
	<9e4733910710031914r766efa88pad9f55f9495d127e@mail.gmail.com>
	<20071004082624.GA17778@diana.vm.bytemark.co.uk>
	<9e4733910710040616l5358099dj1b65b47cf94cf031@mail.gmail.com>
	<20071004154836.GB21717@diana.vm.bytemark.co.uk>
	<9e4733910710040945l2335f3d7le6f45510640d3a6e@mail.gmail.com>
	<20071004173929.GD21717@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 11:26:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdjRv-0003uD-M5
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 11:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755686AbXJEJ0N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Oct 2007 05:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755003AbXJEJ0N
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 05:26:13 -0400
Received: from main.gmane.org ([80.91.229.2]:38938 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754864AbXJEJ0M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 05:26:12 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IdjJc-00085z-QD
	for git@vger.kernel.org; Fri, 05 Oct 2007 09:17:48 +0000
Received: from fw-nat.cambridge.arm.com ([193.131.176.54])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 Oct 2007 09:17:48 +0000
Received: from catalin.marinas by fw-nat.cambridge.arm.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 Oct 2007 09:17:48 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: fw-nat.cambridge.arm.com
User-Agent: pan 0.120 (Plate of Shrimp)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60060>

(for whatever reason, gnus decided that it no longer likes the
authenticated SMTP server, so I'm trying to post via gmane).

On Thu, 04 Oct 2007 19:39:29 +0200, Karl Hasselstr=C3=B6m wrote:

> On 2007-10-04 12:45:17 -0400, Jon Smirl wrote:
>=20
>> Why are the patch name and the short description independent
>> variables? Wouldn't it make more sense to treat these as a single
>> unified item? If I rename the patch it would automatically edit the
>> first line of the description, etc...
>=20
> I guess Catalin would have to answer that -- it's "always" been like
> that. But one obvious problem are patches with identical messages --
> just today I created a series of seven patches that all had "debug"
> for a message. Another is that you usually want descriptive commit
> messages, but may want short and easy-to-type patch names.

That's pretty much the case. There are also the historical reasons (qui=
lt
does the same) plus the fact the exporting should really generate short=
er
and simpler file names rather than name with capitals and spaces. I've
also seen people writing a single paragraph over several lines without =
a
short description. You wouldn't really want a patch name that long.

Anyway, 'stg series -d' would show the patch name together with the sho=
rt
description.

>> When importing a patch from a saved email, stg should strip all the
>> email headers out of the description. I have to manually fix that
>> up.
>=20
> Do you do "stg import -M"? That's for importing one or more patches
> contained in an mbox. Without the -M, I think the default is to expec=
t
> plain diff input.

There is also 'stg import -m' for single e-mails rather than mbox. StGI=
T
should be able to cope with attachments as well.

Catalin
