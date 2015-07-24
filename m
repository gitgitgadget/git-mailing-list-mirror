From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git history in a file
Date: Fri, 24 Jul 2015 14:46:49 +0200
Message-ID: <87wpxp4tae.fsf@igel.home>
References: <CA+5PVA6S69ZU5Q432PK3DiPGkT=00tAtgSzJaYHyXLkHkg9FHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Josh Boyer <jwboyer@fedoraproject.org>
X-From: git-owner@vger.kernel.org Fri Jul 24 14:46:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIcNN-0003Ag-PQ
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 14:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901AbbGXMqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 08:46:54 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:52937 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbbGXMqw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 08:46:52 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3md9Jp6R4gz3hj9M;
	Fri, 24 Jul 2015 14:46:50 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3md9Jp3JfLzvhL1;
	Fri, 24 Jul 2015 14:46:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id h6szPlhQA79r; Fri, 24 Jul 2015 14:46:49 +0200 (CEST)
X-Auth-Info: upFhcH5XjE1Ilcb0KjK/TwuITHnFA5LItCiEjSBY0Zne/ws19QK9ANxmAsl0jnrP
Received: from igel.home (host-188-174-219-252.customer.m-online.net [188.174.219.252])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Fri, 24 Jul 2015 14:46:49 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 2FAE12C4218; Fri, 24 Jul 2015 14:46:49 +0200 (CEST)
X-Yow: I request a weekend in Havana with Phil Silvers!
In-Reply-To: <CA+5PVA6S69ZU5Q432PK3DiPGkT=00tAtgSzJaYHyXLkHkg9FHw@mail.gmail.com>
	(Josh Boyer's message of "Fri, 24 Jul 2015 08:16:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274566>

Josh Boyer <jwboyer@fedoraproject.org> writes:

> I'm trying to figure out how to generate a file that contains the git
> history and changes from one revision to another, such that when the
> file is applied to a different tree starting at the same ancestor, the
> resulting tree is identical.

See git-bundle(1).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
