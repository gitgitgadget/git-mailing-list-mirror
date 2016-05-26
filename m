From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH 2/2] submodule update: learn `--[no-]recommend-shallow`
 option
Date: Thu, 26 May 2016 11:07:35 +0200 (CEST)
Message-ID: <135840520.44198.1464253655936.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <20160526000633.27223-1-sbeller@google.com> <20160526000633.27223-3-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 26 10:57:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5r6X-0004Wh-7W
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 10:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbcEZI5P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 May 2016 04:57:15 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:47365 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750776AbcEZI5O convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 04:57:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id D05A520F4;
	Thu, 26 May 2016 10:57:11 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HecfdiNtPBFy; Thu, 26 May 2016 10:57:11 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id BA2EF20F0;
	Thu, 26 May 2016 10:57:11 +0200 (CEST)
In-Reply-To: <20160526000633.27223-3-sbeller@google.com>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF39 (Linux)/8.0.9_GA_6191)
Thread-Topic: submodule update: learn `--[no-]recommend-shallow` option
Thread-Index: 97zxUwFIliMTWT7tXOtgdnREQ8xwuA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295640>

You forgot to update from recommend-depth to recommend-shallow

Stefan Beller <sbeller@google.com> writes:
> [...]
>  'git submodule' [--quiet] init [--] [<path>...]
>  'git submodule' [--quiet] deinit [-f|--force] (--all|[--] <path>...)
>  'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
> -              [-f|--force] [--rebase|--merge] [--reference <reposito=
ry>]
> -              [--depth <depth>] [--recursive] [--jobs <n>] [--] [<pa=
th>...]
> +              [--[no-]recommended-depth] [-f|--force] [--rebase|--me=
rge]

Here...

> +--[no-]recommended-depth::
> +        This option is only valid for the update command.
> +        The initial clone of a submodule will use the recommended
> +        `submodule.<name>.depth` as provided by the .gitmodules file=
=2E
> +

=2E.. and here.

Thanks,
R=C3=A9mi
