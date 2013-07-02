From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v3] [submodule] Add --depth to submodule update/add
Date: Tue, 02 Jul 2013 19:10:16 +0200
Message-ID: <87fvvwga6f.fsf@igel.home>
References: <1372729167-23200-1-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: gitster@pobox.com, jens.lehmann@web.de, hvoigt@hvoigt.net,
	git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 19:10:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu461-0004VT-59
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 19:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084Ab3GBRKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 13:10:23 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:59247 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754064Ab3GBRKV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 13:10:21 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3blBls6wwXz3hhc1;
	Tue,  2 Jul 2013 19:10:17 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3blBls5T3xzbbmd;
	Tue,  2 Jul 2013 19:10:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id AGZ_F9F3H5-7; Tue,  2 Jul 2013 19:10:16 +0200 (CEST)
X-Auth-Info: U+JV2UW1IBVOtVa4eMfc32K6QRdZR4z88MB3lu1DLzY=
Received: from igel.home (ppp-88-217-100-28.dynamic.mnet-online.de [88.217.100.28])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Tue,  2 Jul 2013 19:10:16 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 1A31EE3BF2; Tue,  2 Jul 2013 19:10:16 +0200 (CEST)
X-Yow: Yow!  Those people look exactly like Donnie and Marie Osmond!!
In-Reply-To: <1372729167-23200-1-git-send-email-iveqy@iveqy.com> (Fredrik
	Gustafsson's message of "Tue, 2 Jul 2013 03:39:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229403>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> This was actually a bit tricky. When I changed
> git clone $depth
> to
> git clone "$depth"
>
> git clone dies with the error "too many arguments".

... when $depth is empty.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
