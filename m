From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Removing options from build
Date: Tue, 13 Jan 2009 22:55:50 +0100
Message-ID: <20090113215550.GE30404@atjola.homenet>
References: <1231883002.14181.27.camel@starfruit>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 22:57:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMrG9-0005ll-1L
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 22:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758218AbZAMVzz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Jan 2009 16:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758205AbZAMVzz
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 16:55:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:43121 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758197AbZAMVzy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 16:55:54 -0500
Received: (qmail invoked by alias); 13 Jan 2009 21:55:52 -0000
Received: from i577B816A.versanet.de (EHLO atjola.local) [87.123.129.106]
  by mail.gmx.net (mp008) with SMTP; 13 Jan 2009 22:55:52 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+dEbNx51ydcYPLyFt22MbOxpIBTevY9lC2zYab2R
	S+//HDUwPuiFAr
Content-Disposition: inline
In-Reply-To: <1231883002.14181.27.camel@starfruit>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105544>

On 2009.01.13 13:43:22 -0800, R. Tyler Ballance wrote:
> One of our developers "discovered" the --force option on `git push` a=
nd
> used it without taking the appropriate care and hosed one of the proj=
ect
> branches we have running around in our central repository.
>=20
> Besides a vigorous flogging, we're looking at other ways to prevent t=
his
> sort of thing from happening again; the option we've settled on is to
> remove the "--force" flag from our internal build of v1.6.1
>=20
> I'm wondering if somebody could point me in the right direction to
> remove "--force" (safely) from the builtin-push.c and removing the
> "rebase" command (we've got no use for it, and would prefer it gone).

git help config

receive.denyNonFastForwards (to refuse non-fast-forwards, even with -f)
receive.denyDeletes (to stop users from working around the non-ff using
                     a delete + recreate operation)

Bj=F6rn
