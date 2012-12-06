From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] RFC Optionally handle symbolic links as copies
Date: Thu, 06 Dec 2012 07:59:33 +0100
Message-ID: <50C04255.8050209@viscovery.net>
References: <1354747575-89277-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 08:00:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgVR5-0005wQ-VI
	for gcvg-git-2@plane.gmane.org; Thu, 06 Dec 2012 07:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754607Ab2LFG7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2012 01:59:39 -0500
Received: from so.liwest.at ([212.33.55.24]:3406 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753366Ab2LFG7i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2012 01:59:38 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TgVQk-0001tP-6Y; Thu, 06 Dec 2012 07:59:34 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E9EDA1660F;
	Thu,  6 Dec 2012 07:59:33 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <1354747575-89277-1-git-send-email-robin.rosenberg@dewire.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211154>

Am 12/5/2012 23:46, schrieb Robin Rosenberg:
> - git status - when do we report a diff. 
> 	- After checkout we should probably not

Are you saying that it should be ignored that the index records a symbolic
link, but the worktree contains a regular file and that the regular file
does not even contain the value of the symbolic link (like it would in the
core.symlinks=false case)?

-- Hannes
