From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 2/2] system_path(): simplify using strip_path_suffix(),
 and add suffix "git"
Date: Thu, 19 Feb 2009 21:39:17 +0100
Message-ID: <499DC375.60105@kdbg.org>
References: <499C63E7.5040306@kdbg.org> <b91ca090ef4eed9e457b579df2e3fbede3d26299.1235070304u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 19 21:41:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaFhW-0007xB-6y
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 21:40:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028AbZBSUj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 15:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753762AbZBSUjZ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 15:39:25 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:46568 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752219AbZBSUjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 15:39:25 -0500
Received: from [77.118.143.182] (77.118.143.182.wireless.dyn.drei.com [77.118.143.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 0E62D1001C;
	Thu, 19 Feb 2009 21:39:20 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <b91ca090ef4eed9e457b579df2e3fbede3d26299.1235070304u.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110747>

Johannes Schindelin schrieb:
> The real change is to add the suffix "git", so that a runtime prefix will
> be computed correctly even when the executable was called in /git/ as is
> the case in msysGit (Windows insists to search the current directory
> before the PATH when looking for an executable).

msysgit is important enough to be supported by upstream git, in 
particular since it is *the* user of RUNTIME_PREFIX, so that this 
special-casing is warranted. Therefore:

Acked-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes
