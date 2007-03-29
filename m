From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: tar commit header names
Date: Thu, 29 Mar 2007 12:55:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0703291234090.6485@iabervon.org>
References: <Pine.LNX.4.64.0703261230420.6485@iabervon.org>
 <460BE44B.8090301@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-1040180282-1175187330=:6485"
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Mar 29 18:55:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWxuR-0003Hk-Jb
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 18:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030449AbXC2Qzc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 12:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030453AbXC2Qzc
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 12:55:32 -0400
Received: from iabervon.org ([66.92.72.58]:4448 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030449AbXC2Qzb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 12:55:31 -0400
Received: (qmail 9080 invoked by uid 1000); 29 Mar 2007 12:55:30 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Mar 2007 12:55:30 -0400
In-Reply-To: <460BE44B.8090301@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43456>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-1040180282-1175187330=:6485
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 29 Mar 2007, Ren=E9 Scharfe wrote:

> Daniel Barkalow schrieb:
> > I'm entirely ignorant of pax header stuff, but would it be possible to=
=20
> > have the pax header specify which project this commit is from (which ha=
s=20
> > to come from a git-archive option, clearly).
>=20
> Technically, yes.  The commit ID is stored in a comment, more info could
> appended to it.  Adding more stuff there would necessitate an ordering
> scheme, though.  I'm not sure this is useful enough.  There already is a
> nice convention on where to store the project name, description and URL:
> in a file named 'README'. :)

Ah, and the comment applies until the next comment, so the common prefix=20
of the files in the area with the comment explains it. I was missing what=
=20
the rules for regions of applicability of pax global headers are. Now, if=
=20
I could convince... something... to report what comments apply to what=20
files, I'd be set. And that's clearly beyond the scope of git. (Although=20
maybe git-get-... should know how to invoke some other utility on a=20
multiple-project archive once some such tool is known.)

=09-Daniel
*This .sig left intentionally blank*
--1547844168-1040180282-1175187330=:6485--
