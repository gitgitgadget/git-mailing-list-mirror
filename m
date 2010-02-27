From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCHv5 2/5] rev-parse: --local-env-vars option
Date: Sat, 27 Feb 2010 22:07:04 +0100
Message-ID: <20100227210701.GE33000@book.hvoigt.net>
References: <1267054458-11877-1-git-send-email-giuseppe.bilotta@gmail.com> <1267054458-11877-3-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 22:07:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlTsd-0001Yl-2P
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 22:07:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030874Ab0B0VHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 16:07:10 -0500
Received: from darksea.de ([83.133.111.250]:57872 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030861Ab0B0VHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 16:07:09 -0500
Received: (qmail 2182 invoked from network); 27 Feb 2010 22:07:05 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 27 Feb 2010 22:07:05 +0100
Content-Disposition: inline
In-Reply-To: <1267054458-11877-3-git-send-email-giuseppe.bilotta@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141225>

On Thu, Feb 25, 2010 at 12:34:15AM +0100, Giuseppe Bilotta wrote:
> This prints the list of repo-local environment variables.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
[...]
> diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
> index a8c5043..ab7b520 100644
> --- a/builtin-rev-parse.c
> +++ b/builtin-rev-parse.c
[...]
>  	if (argc > 1 && !strcmp("-h", argv[1]))
> +
>  		usage(builtin_rev_parse_usage);

You probably forgot to remove that empty line there.

cheers Heiko
