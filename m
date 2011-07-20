From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] pull: remove extra space from reflog message
Date: Thu, 21 Jul 2011 00:22:15 +0200
Message-ID: <m2livssico.fsf@igel.home>
References: <4e2747c1.c6cae30a.0ff2.29e0@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ori Avtalion <ori@avtalion.name>
X-From: git-owner@vger.kernel.org Thu Jul 21 00:22:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qjf9s-0007RC-Aa
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 00:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691Ab1GTWWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 18:22:19 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:41277 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536Ab1GTWWT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 18:22:19 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3B6F51C1DA0E;
	Thu, 21 Jul 2011 00:22:17 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 0F4CF1C00049;
	Thu, 21 Jul 2011 00:22:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id rD1+7OHqfmOV; Thu, 21 Jul 2011 00:22:16 +0200 (CEST)
Received: from igel.home (ppp-88-217-112-117.dynamic.mnet-online.de [88.217.112.117])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Thu, 21 Jul 2011 00:22:16 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 0B287CA293; Thu, 21 Jul 2011 00:22:16 +0200 (CEST)
X-Yow: Three attractive BANK ROBBERS are discussing RELIGIOUS DIFFERENCES and
 MAKE-UP TECHNIQUE with them!!
In-Reply-To: <4e2747c1.c6cae30a.0ff2.29e0@mx.google.com> (Ori Avtalion's
	message of "Thu, 21 Jul 2011 00:19:03 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177556>

Ori Avtalion <ori@avtalion.name> writes:

> -set_reflog_action "pull $*"
> +if [ $# -gt 0 ]; then
> +	set_reflog_action "pull $*"
> +else
> +	set_reflog_action "pull"
> +fi

Or more tersely:

set_reflog_action "pull${1+ $*}"

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
