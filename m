From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/4] MSVC: Fix an "unresolved symbol" linker error on
 cygwin
Date: Tue, 03 Nov 2009 08:21:06 +0100
Message-ID: <4AEFD9E2.6060004@viscovery.net>
References: <4AE74408.7080103@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:21:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5Dha-0004eM-I7
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 08:21:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553AbZKCHVD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 02:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753778AbZKCHVC
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 02:21:02 -0500
Received: from lilzmailmt02.liwest.at ([212.33.55.12]:4815 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752579AbZKCHVC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 02:21:02 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N5DhR-00067n-25; Tue, 03 Nov 2009 08:21:05 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id CF9726D9; Tue,  3 Nov 2009 08:21:04 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4AE74408.7080103@ramsay1.demon.co.uk>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131947>

Ramsay Jones schrieb:
> When the NO_MMAP build variable is set, which is the case by
> default on cygwin, the msvc linker complains:
> 
>     error LNK2001: unresolved external symbol _getpagesize

Make up your mind: use the cygwin configuration or use the MSVC
configuration. MSVC doesn't define NO_MMAP for a reason. Where is the problem?

I understand that you run into this error if you define NO_MMAP in your
config.mak. I don't know whether we support NO_MMAP as a knob for to tweak
the builds on all platforms. If this is the case (Junio?), then your
justification must be updated.

-- Hannes
