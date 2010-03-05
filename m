From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: gitignore broken in git 1.7.0.1: slash checks leading dirs
Date: Fri, 05 Mar 2010 10:05:56 +0100
Message-ID: <4B90C974.2050405@viscovery.net>
References: <4B90C701.3070308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Jiri Slaby <jirislaby@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 05 10:06:29 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnTUK-0007ny-KT
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 10:06:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667Ab0CEJGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Mar 2010 04:06:08 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:61607 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753980Ab0CEJGA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 04:06:00 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NnTTp-00056v-8j; Fri, 05 Mar 2010 10:05:57 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id C26FC1660F;
	Fri,  5 Mar 2010 10:05:56 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4B90C701.3070308@gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141566>

Jiri Slaby schrieb:
> having 'linux' line in .gitignore makes 'include/linux/vga_switcheroo.h'
> to be ignored

That's the behavior that I would expect.

> though the documentation says:
> ***
> If the pattern does not contain a slash /, git treats it as a shell
> glob pattern and checks for a match against the pathname without
> leading directories.
> ***

and this citation confirms my expectation. Note that it says "pathname",
not "filename". 'include/linux' is a "pathname".

-- Hannes
