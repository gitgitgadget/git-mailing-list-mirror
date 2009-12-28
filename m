From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: immutable tags?
Date: Mon, 28 Dec 2009 22:21:25 +0100
Message-ID: <87d41yvlpm.fsf@krank.kagedal.org>
References: <92c9564e0912281204h13c6a566w95069023e6909eda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 28 22:22:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPN2Z-0002ZE-7M
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 22:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbZL1VWB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Dec 2009 16:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbZL1VWA
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 16:22:00 -0500
Received: from lo.gmane.org ([80.91.229.12]:60540 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbZL1VWA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 16:22:00 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NPN2G-0002Qt-Hs
	for git@vger.kernel.org; Mon, 28 Dec 2009 22:21:52 +0100
Received: from 87.96.142.66 ([87.96.142.66])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Dec 2009 22:21:52 +0100
Received: from davidk by 87.96.142.66 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Dec 2009 22:21:52 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 87.96.142.66
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:25IL6Czs3MYUwIHM9qJM6tO0P44=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135764>

Carlos Santana <neubyr@gmail.com> writes:

> I would like to know if there is any difference between branches and
> tags. Is it only conceptual - convention to be followed by a develope=
r
> or some technical difference?  e.g. : Is it possible to create
> immutable tags so that nothing can be checked in to that 'tagged
> directory'?

You are always in full control of your own repository, and have no
control over what other people do with their's. So you can't prevent
other people from changing the tags in their private repos, but you can
prevent them from propagating these changes back to you, or to a centra=
l
repository you control.

But perhaps there is nothing to worry about. I think the git commands
won't modify a tag unless you force it.

Also, if you use signed tags, you can be sure that they are not silentl=
y
replaced while still claiming to be tagged by you.

--=20
David K=C3=A5gedal
