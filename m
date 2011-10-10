From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 1/2] submodule: whitespace fix
Date: Mon, 10 Oct 2011 20:52:15 +0200
Message-ID: <4E933EDF.6020909@web.de>
References: <1317978295-4796-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 10 20:52:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDKxZ-00015W-Me
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 20:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633Ab1JJSwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 14:52:18 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:46802 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760Ab1JJSwR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 14:52:17 -0400
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate02.web.de (Postfix) with ESMTP id CBB6E1B0620F1;
	Mon, 10 Oct 2011 20:52:15 +0200 (CEST)
Received: from [79.247.240.43] (helo=[192.168.178.43])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #2)
	id 1RDKxT-0007C1-00; Mon, 10 Oct 2011 20:52:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <1317978295-4796-1-git-send-email-rctay89@gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+cgLUnyfxjdkf5rZPaR0RiNmYk18Uoe1/ZaLRk
	88oHCEIDR++DN3rdUo9k6s9NEOoh9EWOqSDrhJkmiA0qiwrF72
	BX+meDC+iCNRz0FOeVoA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183250>

Am 07.10.2011 11:04, schrieb Tay Ray Chuan:
> Replace SPs with TAB.

As these are the only lines where spaces are used for indentation in this
file this might be a worthwhile cleanup, but I really don't care that much.
Junio, what do you think?

> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> ---
>  git-submodule.sh |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 928a62f..ebea35b 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -104,9 +104,9 @@ module_name()
>  	re=$(printf '%s\n' "$1" | sed -e 's/[].[^$\\*]/\\&/g')
>  	name=$( git config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
>  		sed -n -e 's|^submodule\.\(.*\)\.path '"$re"'$|\1|p' )
> -       test -z "$name" &&
> -       die "$(eval_gettext "No submodule mapping found in .gitmodules for path '\$path'")"
> -       echo "$name"
> +	test -z "$name" &&
> +	die "$(eval_gettext "No submodule mapping found in .gitmodules for path '\$path'")"
> +	echo "$name"
>  }
>  
>  #
