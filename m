From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git rebase -i onto HEAD~n
Date: Tue, 3 Feb 2009 16:44:57 +0100
Message-ID: <20090203154457.GA6859@atjola.homenet>
References: <C5E2CAEE4A87D24DAB5334F62A72D1F43ADC9D@ELON17P32001A.csfb.cs-group.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Bisani, Alok" <alok.bisani@credit-suisse.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 16:47:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUNTr-0004Fq-FH
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 16:46:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620AbZBCPpE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Feb 2009 10:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752260AbZBCPpE
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 10:45:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:57752 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752485AbZBCPpC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 10:45:02 -0500
Received: (qmail invoked by alias); 03 Feb 2009 15:44:59 -0000
Received: from i577B9B17.versanet.de (EHLO atjola.local) [87.123.155.23]
  by mail.gmx.net (mp043) with SMTP; 03 Feb 2009 16:44:59 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/FKflG1vDFWbTrd+uQ/NJYXLd2MGCAUzUFevM8KY
	e8qiKP+4oRLW0W
Content-Disposition: inline
In-Reply-To: <C5E2CAEE4A87D24DAB5334F62A72D1F43ADC9D@ELON17P32001A.csfb.cs-group.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108202>

On 2009.02.03 15:32:35 -0000, Bisani, Alok wrote:
> Hi,
>=20
> Is it possible to use git rebase -i for the following use case, in a
> local branch?
>=20
> $ git reset --soft HEAD~3
> $ # magically squash HEAD~2 & HEAD, ignoring HEAD~1 (which should be
> discarded)
> $ git commit -m "new commit replacing current HEAD~2 HEAD, without th=
e
> commit HEAD~1 (to be discarded)"
>=20
> I get the error below.
>=20
>     grep: /home/user/project/.git/rebase-merge/done: No such file or
> directory
>     Cannot 'squash' without a previous commit

It would be helpful if you told us what command you used, and what you
changed in the editor.

This should do:
git rebase -i HEAD~3

And in the editor:
pick HEAD~2
squash HEAD

Bj=F6rn
