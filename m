From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] git-submodule.sh: Don't use $path variable in eval_gettext
 string
Date: Wed, 18 Apr 2012 20:11:19 +0200
Message-ID: <4F8F03C7.7000309@kdbg.org>
References: <4F8DAFDA.1020108@ramsay1.demon.co.uk> <4F8EA009.5080405@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	bwalton@artsci.utoronto.ca, avarab@gmail.com,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Apr 18 20:11:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKZLm-0000tH-MP
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 20:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753837Ab2DRSLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 14:11:24 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:27619 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753070Ab2DRSLX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 14:11:23 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id D495BA7EB7;
	Wed, 18 Apr 2012 20:12:38 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 9C81319F6BA;
	Wed, 18 Apr 2012 20:11:19 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.28) Gecko/20120306 SUSE/3.1.20 Thunderbird/3.1.20
In-Reply-To: <4F8EA009.5080405@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195876>

Am 18.04.2012 13:05, schrieb Jens Lehmann:
> Am 17.04.2012 20:00, schrieb Ramsay Jones:
>> In particular, when executing test #38 in t7400-submodule-basic.sh,
>> an 'git-sh-i18n-envsubst.exe - Unable To Locate Component' dialog
>> pops up saying that the application "failed to start because
>> libiconv2.dll was not found."

I also observed this error, and this patch fixes it (and at that also
passes the test suite).

Thanks, Ramsay!

-- Hannes
