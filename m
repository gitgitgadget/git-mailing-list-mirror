From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] prompt: fix tracked files for zsh
Date: Sun, 21 Apr 2013 10:21:15 +0200
Message-ID: <m2fvyk8fb8.fsf@igel.home>
References: <1366531890-19899-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 10:21:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTpWd-00083d-Mo
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 10:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509Ab3DUIV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 04:21:27 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:46300 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432Ab3DUIVY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 04:21:24 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3ZtkQh6hNFz3hhcx;
	Sun, 21 Apr 2013 10:21:16 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3ZtkQh6QRpzbcxj;
	Sun, 21 Apr 2013 10:21:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id ZM3KGbTOeJaS; Sun, 21 Apr 2013 10:21:15 +0200 (CEST)
X-Auth-Info: ckBkrjQI6hEMrvF/uYgg7PmbcMsqkafRMruVuKkJJds=
Received: from igel.home (ppp-88-217-114-237.dynamic.mnet-online.de [88.217.114.237])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sun, 21 Apr 2013 10:21:15 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 68FC7CA2B6; Sun, 21 Apr 2013 10:21:15 +0200 (CEST)
X-Yow: LOOK!!!  I'm WALKING in my SLEEP again!!
In-Reply-To: <1366531890-19899-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sun, 21 Apr 2013 03:11:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221920>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> +				if [ -n "${ZSH_VERSION-}" ]; then
> +					u="%%"
> +				else
> +					u="%"
> +				fi

aka u="%${ZSH_VERSION:+%}"

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
