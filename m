From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: git help broken
Date: Thu, 21 Aug 2008 04:51:11 +0200
Message-ID: <200808210451.12795.chriscool@tuxfamily.org>
References: <C0DB03B0-8AF5-4B6A-A9DB-16608128EB31@sb.org> <200808010628.52875.chriscool@tuxfamily.org> <20080801144121.GU32057@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Aug 21 04:48:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW0Dp-000299-CJ
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 04:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753123AbYHUCrV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Aug 2008 22:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752807AbYHUCrU
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 22:47:20 -0400
Received: from smtp8-g19.free.fr ([212.27.42.65]:55211 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752751AbYHUCrU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Aug 2008 22:47:20 -0400
Received: from smtp8-g19.free.fr (localhost [127.0.0.1])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 41B7532A789;
	Thu, 21 Aug 2008 04:47:18 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp8-g19.free.fr (Postfix) with ESMTP id DAE0B32A775;
	Thu, 21 Aug 2008 04:47:17 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080801144121.GU32057@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93091>

Le vendredi 1 ao=FBt 2008, Miklos Vajna a =E9crit :
> On Fri, Aug 01, 2008 at 06:28:52AM +0200, Christian Couder=20
<chriscool@tuxfamily.org> wrote:
> > I didn't realize that the function "is_git_command" would not work
> > for "help".
>
> Is there any reason why help is not a builtin? I think that would sol=
ve
> the problem.
>
> I'm willing to do such a patch, I just asked in case that would be
> no-go for some - for me - unknown reason.

Sorry I didn't answer before. I was really busy during my vacation ;-P

I think you are right, and in "next" where your patch has been merged, =
"git=20
help help" works fine.

But unfortunately it seems that your patch hasn't been merged into mast=
er,=20
so "git help help" is still broken there and in git 1.6.0.

Thanks,
Christian.
