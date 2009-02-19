From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 1/2] Introduce the function strip_path_suffix()
Date: Thu, 19 Feb 2009 21:26:55 +0100
Message-ID: <499DC08F.3030106@kdbg.org>
References: <499C63E7.5040306@kdbg.org> <f6344cbba22e049806796f4920e229fb2e539d5c.1235070304u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 19 21:28:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaFVl-0002y2-0Y
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 21:28:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757320AbZBSU1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 15:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755576AbZBSU1G
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 15:27:06 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:40723 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754213AbZBSU1F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 15:27:05 -0500
Received: from [77.118.143.182] (77.118.143.182.wireless.dyn.drei.com [77.118.143.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 2533ACDF86;
	Thu, 19 Feb 2009 21:26:59 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <f6344cbba22e049806796f4920e229fb2e539d5c.1235070304u.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110745>

Johannes Schindelin schrieb:
> +/* sets prefix if the suffix matches */

/*
  * If path ends with suffix (complete path components), returns the
  * part before suffix (sans trailing directory separators).
  * Otherwise returns NULL.
  */

> +char *strip_path_suffix(const char *path, const char *suffix)

Looks good otherwise.

-- Hannes
