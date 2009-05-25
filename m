From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git-ls-files --added?
Date: Mon, 25 May 2009 09:46:06 +0200
Message-ID: <20090525074606.GA30061@atjola.homenet>
References: <2cfc40320905240054j2c08da8bt4df95c6f1bc9e254@mail.gmail.com> <m3fxeudhho.fsf@localhost.localdomain> <2cfc40320905240212jc111b1xfeb39b1851c606d3@mail.gmail.com> <7vmy921i3j.fsf@alter.siamese.dyndns.org> <7vws85y9n7.fsf@alter.siamese.dyndns.org> <85647ef50905250031m375a14d9y252444a8bdc250b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jon Seymour <jon.seymour@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 25 09:47:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Utj-0001jw-SQ
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 09:47:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732AbZEYHqN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 May 2009 03:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbZEYHqN
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 03:46:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:42800 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750883AbZEYHqM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 03:46:12 -0400
Received: (qmail invoked by alias); 25 May 2009 07:46:13 -0000
Received: from i59F55D76.versanet.de (EHLO atjola.local) [89.245.93.118]
  by mail.gmx.net (mp034) with SMTP; 25 May 2009 09:46:13 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18u+EVfKBsuWLk4SCCNwZR1K80X6427djKdCrmwRN
	1QlxgCXP7QMKqH
Content-Disposition: inline
In-Reply-To: <85647ef50905250031m375a14d9y252444a8bdc250b5@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119896>

On 2009.05.25 11:31:42 +0400, Constantine Plotnikov wrote:
> BTW git-diff won't work in situation when the directory was just
> initialized and there were no commit. In that case added file =3D sta=
ged
> file and it is possible to use git-ls-files.

You can use the object name of the empty tree with diff-* in that case,
that's what the pre-commit.sample hook does.

Bj=F6rn
