From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 04/13] contrib/subtree: Fix Synopsis
Date: Fri, 02 Aug 2013 10:20:12 +0200
Message-ID: <877gg45wsj.fsf@igel.home>
References: <1360064219-28789-1-git-send-email-greened@obbligato.org>
	<1360064219-28789-5-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Fri Aug 02 10:20:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5Ab3-0001zm-F3
	for gcvg-git-2@plane.gmane.org; Fri, 02 Aug 2013 10:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757990Ab3HBIUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 04:20:19 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:59894 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755681Ab3HBIUP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 04:20:15 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3c61Wy65k6z3hhbx;
	Fri,  2 Aug 2013 10:20:13 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3c61Wx6YDLzbbmb;
	Fri,  2 Aug 2013 10:20:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id ZqYf5gs7FfTl; Fri,  2 Aug 2013 10:20:12 +0200 (CEST)
X-Auth-Info: T49XMspAdGv0Xpz/IwFUT/te8v9279WV641VIYJBNFA=
Received: from igel.home (ppp-88-217-110-98.dynamic.mnet-online.de [88.217.110.98])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Fri,  2 Aug 2013 10:20:12 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id C534D2C0045; Fri,  2 Aug 2013 10:20:12 +0200 (CEST)
X-Yow: I want a VEGETARIAN BURRITO to go..  with EXTRA MSG!!
In-Reply-To: <1360064219-28789-5-git-send-email-greened@obbligato.org> (David
	A. Greene's message of "Tue, 5 Feb 2013 05:36:50 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231520>

"David A. Greene" <greened@obbligato.org> writes:

> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 771f39d..8a23f58 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -9,6 +9,7 @@ if [ $# -eq 0 ]; then
>  fi
>  OPTS_SPEC="\
>  git subtree add   --prefix=<prefix> <commit>
> +git subtree add   --prefix=<prefix> <repository> <commit>
>  git subtree merge --prefix=<prefix> <commit>
>  git subtree pull  --prefix=<prefix> <repository> <refspec...>
>  git subtree push  --prefix=<prefix> <repository> <refspec...>

> diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
> index c5bce41..7ba853e 100644
> --- a/contrib/subtree/git-subtree.txt
> +++ b/contrib/subtree/git-subtree.txt
> @@ -9,7 +9,8 @@ git-subtree - Merge subtrees together and split repository into subtrees
>  SYNOPSIS
>  --------
>  [verse]
> -'git subtree' add   -P <prefix> <commit>
> +'git subtree' add   -P <prefix> <refspec>
> +'git subtree' add   -P <prefix> <repository> <refspec>

<refspec> or <ommit>?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
