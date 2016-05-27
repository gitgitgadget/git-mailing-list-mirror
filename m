From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] log: document the --decorate=auto option
Date: Fri, 27 May 2016 14:35:18 -0400
Message-ID: <57489366.507@xiplink.com>
References: <57486E12.7030907@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 20:35:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6Mbl-00048Q-4f
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 20:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756573AbcE0Sf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 14:35:27 -0400
Received: from smtp106.iad3a.emailsrvr.com ([173.203.187.106]:53902 "EHLO
	smtp106.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756370AbcE0SfZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2016 14:35:25 -0400
Received: from smtp14.relay.iad3a.emailsrvr.com (localhost.localdomain [127.0.0.1])
	by smtp14.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id 2EC28280376;
	Fri, 27 May 2016 14:35:19 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp14.relay.iad3a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 9C04F28020C;
	Fri, 27 May 2016 14:35:18 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.5.4);
	Fri, 27 May 2016 14:35:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <57486E12.7030907@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295784>

On 2016-05-27 11:56 AM, Ramsay Jones wrote:
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Junio,
>
> While reading an email from Linus earlier (RFC: dynamic "auto" date formats),
> I noticed that log.decorate was being set to 'auto'. Since I didn't recall
> that setting (even if it's easy to guess), I went looking for the documentation ...
>
> This should probably be marked RFC, since I haven't checked that the formatting
> is OK (I don't have the documentation toolchain installed these days).
>
> ATB,
> Ramsay Jones
>
>   Documentation/config.txt  | 5 ++++-
>   Documentation/git-log.txt | 8 +++++---
>   2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 53f00db..0707b3b 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1956,7 +1956,10 @@ log.decorate::
>   	command. If 'short' is specified, the ref name prefixes 'refs/heads/',
>   	'refs/tags/' and 'refs/remotes/' will not be printed. If 'full' is
>   	specified, the full ref name (including prefix) will be printed.
> -	This is the same as the log commands '--decorate' option.
> +	If 'auto' is specified, then if the output is going to a terminal,
> +	the ref names are shown as if 'short' were given, otherwise no ref
> +	names are shown. This is the same as the log commands '--decorate'

s/commands/command's/

		M.
