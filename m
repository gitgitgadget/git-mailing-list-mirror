From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] rev-parse: Add support for the ^! and ^@ syntax
Date: Sat, 26 Jul 2008 18:54:06 +0200
Message-ID: <20080726165406.GA26378@atjola.homenet>
References: <20080726163756.GA25103@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 26 18:55:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMn31-00030i-3z
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 18:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047AbYGZQyL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jul 2008 12:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752838AbYGZQyK
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 12:54:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:59715 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751946AbYGZQyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 12:54:09 -0400
Received: (qmail invoked by alias); 26 Jul 2008 16:54:07 -0000
Received: from i577BB289.versanet.de (EHLO atjola.local) [87.123.178.137]
  by mail.gmx.net (mp023) with SMTP; 26 Jul 2008 18:54:07 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+jlH8hmvWjGJJlF4mJwWPXEuKDsrNZOQLFk99WsL
	+8zeeVjy4f/Vxu
Content-Disposition: inline
In-Reply-To: <20080726163756.GA25103@atjola.homenet>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90259>

On 2008.07.26 18:37:56 +0200, Bj=F6rn Steinbrink wrote:
> Those shorthands are explained in the rev-parse documentation but wer=
e not
> actually supported by rev-parse itself.
>=20
> Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
> ---

Ah crap, forgot to say that I wrote this because I wanted gitk to
support the ^! syntax and that uses rev-parse to parse its revision
arguments. My use-case with gitk is to quickly verify a bunch of grafts
I used to fixup the history in a git-svn repo.

Bj=F6rn
