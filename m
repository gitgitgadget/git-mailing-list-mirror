From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Introduce an exponential-backoff-retry in unlink on mingw.
Date: Mon, 15 Feb 2010 23:06:38 +0100
Message-ID: <4B79C56E.2040207@kdbg.org>
References: <loom.20100215T213606-594@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ludvig Strigeus <ludde@spotify.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 23:06:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nh95f-0008OC-Gc
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 23:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072Ab0BOWGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 17:06:46 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:43188 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756101Ab0BOWGp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 17:06:45 -0500
Received: from [77.119.192.246] (77.119.192.246.wireless.dyn.drei.com [77.119.192.246])
	by bsmtp.bon.at (Postfix) with ESMTP id 55CF210014;
	Mon, 15 Feb 2010 23:06:42 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <loom.20100215T213606-594@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140036>

Ludvig Strigeus schrieb:
> A backoff is introduced that retries the unlink a few times with a
> small delay in between.

Thanks. Did you notice that there is already a similar strategy 
implemented in mingw_rename? It starts with Sleep(0).

A similar patch was floated recently on the msysgit mailing list. Please 
research the archives.

-- Hannes
