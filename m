From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] git-svn: follow revisions of svm-mirrored repositories
Date: Mon, 16 Jun 2008 09:30:29 +1200
Message-ID: <485589F5.6020409@vilain.net>
References: <7bf6f1d20806132102x71422617s26260fdc348a7c04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Jo=E3o_Abecasis?= <joao@abecasis.name>
X-From: git-owner@vger.kernel.org Sun Jun 15 23:31:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7zox-0006Ny-T2
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 23:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677AbYFOVai convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Jun 2008 17:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752673AbYFOVai
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 17:30:38 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:58695 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752659AbYFOVah (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 17:30:37 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id BD5AA21C6AF; Mon, 16 Jun 2008 09:30:36 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=5.0 tests=AWL,BAYES_00 autolearn=ham
	version=3.2.3
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 2BFE121C158;
	Mon, 16 Jun 2008 09:30:29 +1200 (NZST)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <7bf6f1d20806132102x71422617s26260fdc348a7c04@mail.gmail.com>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85123>

Jo=E3o Abecasis wrote:
> Hi,
>=20
> When using an svk mirror repository as the source for git-svn,
> find-rev and rebase don't work.
>=20
> find-rev takes a while, while it traverses and processes commit logs
> for the branch, and ultimately fails with the error message: "Unable
> to determine upstream SVN information from git-svn history". This
> happens because find-rev doesn't relate information in the commit
> messages to the internal svm-source revision maps.
>=20
> Similarly, rebase is faster but still exits with the message "Unable
> to determine upstream SVN information from working tree history".
>=20
> The attached patch fixes a couple of underlying issues to get at leas=
t
> these two commands working. AFAICT it still works well with plain svn
> repositories.
>=20
> Can this be merged upstream? Any comments are welcome.

Can you give an approximate series of commands that led to this not
working?  Just to clarify what happened.  Ideally, it would be a test
case; see if you can add it to the existing SVM test case.  In fact thi=
s
might be a regression compared to the original support, due to lack of
tests - in which case it would be good to fix this "for good".

Also, please try to send your patches inline if possible, or at least
try to get them to be Content-Disposition: inline, it makes review
easier for casual list subscribers.

Thanks,
Sam.
