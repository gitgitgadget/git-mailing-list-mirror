From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v3] git: make "git -C '' <cmd>" not to barf
Date: Fri, 06 Mar 2015 16:57:28 +0100
Message-ID: <87d24mnmon.fsf@igel.home>
References: <1425625534-11869-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 16:57:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTud7-0003Kq-WD
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 16:57:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753595AbbCFP5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 10:57:33 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:35322 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037AbbCFP5c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 10:57:32 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3kzD9P0GRhz3hmrq;
	Fri,  6 Mar 2015 16:57:29 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3kzD9N6vCXzvhMb;
	Fri,  6 Mar 2015 16:57:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id d8pfeNmhNiC7; Fri,  6 Mar 2015 16:57:28 +0100 (CET)
X-Auth-Info: bzNd668bIRyKl0E2n3+KmKbk+gyAgiN1rGWuvttzXNdCw/n0ICjQ1Q5DdtqNB6no
Received: from igel.home (ppp-88-217-108-54.dynamic.mnet-online.de [88.217.108.54])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Fri,  6 Mar 2015 16:57:28 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 093642C0682; Fri,  6 Mar 2015 16:57:28 +0100 (CET)
X-Yow: I want a WESSON OIL lease!!
In-Reply-To: <1425625534-11869-1-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Fri, 6 Mar 2015 12:35:34 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.90 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264932>

Karthik Nayak <karthik.188@gmail.com> writes:

> +			if (*((*argv)[1]) == 0)

IMHO (*argv)[1][0] is easier to understand.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
