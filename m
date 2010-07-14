From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH v3] add configuration variable for --autosquash
	option of interactive rebase
Date: Wed, 14 Jul 2010 13:54:22 +0200
Message-ID: <20100714115422.GB15316@book.hvoigt.net>
References: <20100709124659.GA17559@book.hvoigt.net> <m27hl4zg99.fsf@igel.home> <20100710091517.GA27323@book.hvoigt.net> <7vk4p1fdlg.fsf@alter.siamese.dyndns.org> <20100713112316.GA758@book.hvoigt.net> <4C3D4802.2010707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 13:54:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ0Xt-0008Ph-Bt
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 13:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755334Ab0GNLyZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 07:54:25 -0400
Received: from darksea.de ([83.133.111.250]:48014 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755233Ab0GNLyY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 07:54:24 -0400
Received: (qmail 18446 invoked from network); 14 Jul 2010 13:54:22 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 14 Jul 2010 13:54:22 +0200
Content-Disposition: inline
In-Reply-To: <4C3D4802.2010707@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150981>

On Tue, Jul 13, 2010 at 10:15:46PM -0700, Stephen Boyd wrote:
> Can you squash this in too? I know we duplicate the wording, but rebase.stat has set some precedence here on that one.
>
> ---->8-------
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 79d54e5..9e3c48b 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1533,6 +1533,9 @@ rebase.stat::
>         Whether to show a diffstat of what changed upstream since the last
>         rebase. False by default.
>
> +rebase.autosquash::
> +       If set to true enable '--autosquash' option by default.
> +
>  receive.autogc::
>         By default, git-receive-pack will run "git-gc --auto" after
>         receiving data from git-push and updating refs.  You can stop

Thanks for noticing. Will do. I find it helpful to have an overview of
all configuration variables in one place.

cheers Heiko
