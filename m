From: Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: update_linked_gitdir writes relative path to
 .git/worktrees/<id>/gitdir
Date: Sun, 07 Feb 2016 20:04:38 -0500
Message-ID: <1454893478.2511.5.camel@mattmccutchen.net>
References: <1454789548.23898.223.camel@mattmccutchen.net>
	 <xmqqlh6w9isp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 02:04:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSaG1-0000Rf-9M
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 02:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660AbcBHBEp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Feb 2016 20:04:45 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:44060 "EHLO
	homiemail-a61.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752591AbcBHBEl convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 7 Feb 2016 20:04:41 -0500
Received: from homiemail-a61.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a61.g.dreamhost.com (Postfix) with ESMTP id B19F5578077;
	Sun,  7 Feb 2016 17:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=
	mattmccutchen.net; bh=qazgo4W0dpJEQzeym8hj7J4njAc=; b=DRRTZ1e9xK
	M3GQaMWk4xAA82TYp5oP6jsBANZO2Rovphnk+3d+KZt+zTMx2bJD1zB0PKoRrR/V
	LWsgbi+t3qxon+5usGXwzKDEIFOXZFHavGif8OvZwYikQSZ+0qatr8NQxS6JSs1Z
	wjLFZNCF+zMyQO9iT9kdEdiKqkQL18oi4=
Received: from main (c-71-233-157-193.hsd1.ma.comcast.net [71.233.157.193])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: matt@mattmccutchen.net)
	by homiemail-a61.g.dreamhost.com (Postfix) with ESMTPSA id 2A84C578059;
	Sun,  7 Feb 2016 17:04:40 -0800 (PST)
In-Reply-To: <xmqqlh6w9isp.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.18.4 (3.18.4-1.fc23) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285742>

On Sun, 2016-02-07 at 15:56 -0800, Junio C Hamano wrote:
> Matt McCutchen <matt@mattmccutchen.net> writes:
>=20
> > I noticed that when update_linked_gitdir chooses to update
> > .git/worktrees/<id>/gitdir, the path it writes is relative, at
> > least
> > under some circumstances. =C2=A0This contradicts the gitrepository-
> > layout
> > man page, which says:
>=20
> Duy, is it safe to say that the fix has already been cooking in
> 'next' as nd/do-not-move-worktree-manually topic,

Yes, looks like that topic removes the buggy functionality.

> it is very much
> appreciated when reporting bugs people check if a presumed fix is
> already cooking in 'next', try it to verify if it really fixes their
> problem, and send in a "OK fix is good" / "No that does not fix my
> case"?

Sorry to waste your time. =C2=A0This wasn't documented where I looked,
namely the "Bug Reporting" section on=C2=A0http://git-scm.com/community=
=C2=A0.
=C2=A0Here's a straw-man proposed update to that page:

https://github.com/mattmccutchen/git-scm.com/compare/master...bug-repor=
ting-next

If you like it, I will submit it as a pull request. =C2=A0I can propose=
 a
similar update to the "REPORTING BUGS" section of the git(1) man page
if you like.

Matt
