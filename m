From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Fix 'git help help'
Date: Fri, 22 Aug 2008 06:40:09 +0200
Message-ID: <200808220640.10993.chriscool@tuxfamily.org>
References: <1219328508-11561-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 06:37:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWOOo-0007WV-W0
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 06:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058AbYHVEgT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Aug 2008 00:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752050AbYHVEgT
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 00:36:19 -0400
Received: from smtp7-g19.free.fr ([212.27.42.64]:41932 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045AbYHVEgS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Aug 2008 00:36:18 -0400
Received: from smtp7-g19.free.fr (localhost [127.0.0.1])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 40FDCB012F;
	Fri, 22 Aug 2008 06:36:17 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp7-g19.free.fr (Postfix) with ESMTP id DA872B0111;
	Fri, 22 Aug 2008 06:36:16 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1219328508-11561-1-git-send-email-vmiklos@frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93252>

Le jeudi 21 ao=FBt 2008, Miklos Vajna a =E9crit :
> git help foo invokes man git-foo if foo is a git command, otherwise i=
t
> invokes man gitfoo. 'help' is not a git command, but the manual page =
is
> called git-help, so add this special exception.
>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>

Acked-by: Christian Couder <chriscool@tuxfamily.org>

> ---
>
> On Thu, Aug 21, 2008 at 04:51:11AM +0200, Christian Couder=20
<chriscool@tuxfamily.org> wrote:
> > But unfortunately it seems that your patch hasn't been merged into
> > master,
> > so "git help help" is still broken there and in git 1.6.0.
>
> Here is a patch for 'maint'.

It works fine.

Thanks,
Christian.
