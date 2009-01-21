From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@strlen.de>
Subject: Re: [PATCH] [TOPGIT] make tg remote idempotent
Date: Wed, 21 Jan 2009 12:06:28 +0100
Message-ID: <20090121110628.GA9415@strlen.de>
References: <1231968443-13960-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "martin f. krafft" <madduck@debian.org>, Petr Baudis <pasky@ucw.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 21 12:07:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPaw3-0002h2-Vu
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 12:07:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763986AbZAULGa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jan 2009 06:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756506AbZAULGa
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 06:06:30 -0500
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:33903 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755877AbZAULG3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jan 2009 06:06:29 -0500
Received: id: ukleinek by Chamillionaire.breakpoint.cc with local
	(easymta 1.00 BETA 1)
	id 1LPaui-0002Si-5E; Wed, 21 Jan 2009 12:06:28 +0100
Content-Disposition: inline
In-Reply-To: <1231968443-13960-1-git-send-email-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106594>

Hello,

On Wed, Jan 14, 2009 at 10:27:22PM +0100, Uwe Kleine-K=F6nig wrote:
> -git config --add "remote.$name.fetch" "+refs/top-bases/*:refs/remote=
s/$name/top-bases/*"
> -git config --add "remote.$name.push" "+refs/top-bases/*:refs/top-bas=
es/*"
> -git config --add "remote.$name.push" "+refs/heads/*:refs/heads/*"
> +git config --replace-all "remote.$name.fetch" "+refs/top-bases/*:ref=
s/remotes/$name/top-bases/*" "+refs/top-bases/*:refs/remotes/$name/top-=
bases/*"
> +git config --replace-all "remote.$name.push" "+refs/top-bases/*:refs=
/top-bases/*" "+refs/top-bases/*:refs/top-bases/*"
> +git config --replace-all "remote.$name.push" "+refs/heads/*:refs/hea=
ds/*" "+refs/heads/*:refs/heads/*"
It seems I sent an old version of this patch.  Actually in the last
argument '+' and '*' have to be quoted to work.

I fixed this in my repo.  Should I resend the fixed patch?

Best regards
Uwe
