From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [msysGit] [PATCH 10/12] Add ANSI control code emulation for the Windows console
Date: Wed, 2 Jul 2008 21:17:38 +0200
Message-ID: <200807022117.38166.johannes.sixt@telecom.at>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-9-git-send-email-prohaska@zib.de> <1214987532-23640-10-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: msysGit <msysgit@googlegroups.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Peter <git@peter.is-a-geek.org>
To: prohaska@zib.de
X-From: git-owner@vger.kernel.org Wed Jul 02 21:18:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE7qh-0002Nh-3o
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 21:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbYGBTRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 15:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752639AbYGBTRk
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 15:17:40 -0400
Received: from smtp1.srv.eunet.at ([193.154.160.119]:35964 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185AbYGBTRj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 15:17:39 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id 6F95E33B52;
	Wed,  2 Jul 2008 21:17:38 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 42D681CA44;
	Wed,  2 Jul 2008 21:17:38 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1214987532-23640-10-git-send-email-prohaska@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87182>

On Mittwoch, 2. Juli 2008, Steffen Prohaska wrote:
> This adds only the minimum necessary to keep git pull/merge's diffstat from
> wrapping. Notably absent is support for the K (erase) operation, and
> support for POSIX write.

If I understand the patch correctly, it won't affect output that goes to the 
pager; only text that goes directly to the console would be colored. This is 
a start. I think I'll queue this in mingw.git.

-- Hannes
