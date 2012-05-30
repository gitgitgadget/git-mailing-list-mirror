From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git 1.7.10.msysgit.1: different behaviour in ".gitignore" and
 ".git/info/exclude"
Date: Wed, 30 May 2012 12:28:49 +0200
Message-ID: <4FC5F661.6090105@viscovery.net>
References: <96434119.20120530104356@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git-mailing <git@vger.kernel.org>
To: Thomas Wichern <nordertom@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 30 12:29:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZg9G-0003MC-TK
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 12:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035Ab2E3K26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 06:28:58 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:4639 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512Ab2E3K25 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 06:28:57 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SZg9z-0006nL-I3; Wed, 30 May 2012 12:29:52 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 6C79B1660F;
	Wed, 30 May 2012 12:28:49 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <96434119.20120530104356@gmx.de>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198794>

Am 5/30/2012 10:43, schrieb Thomas Wichern:
> If you have a ".gitignore" - file that contains the pattern "/(*)/", a
> directory that matches the pattern is ignored completely.
> 
> If you put the same pattern into the ".git/info/exclude" - file, the
> pattern does not work - these directories still show up.
> 
> I expected that all directories anywhere the repository that match the
> pattern to be ignored.

The first slash in the pattern means: Match only in this directory, not in
subdirectories. For patterns in .git/info/exclude, "this directory" is the
top-level of the repository.

> Am I doing something wrong? Is the pattern not correct?

Perhaps you need "(*)/", i.e., without the first slash.

-- Hannes
