From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: non-US-ASCII file names (e.g. Hiragana) on Windows
Date: Tue, 01 Dec 2009 11:08:46 +0100
Message-ID: <4B14EB2E.9020906@viscovery.net>
References: <4B1168D4.5010902@syntevo.com> <200911282100.23000.j6t@kdbg.org> <4B14DA78.70906@syntevo.com> <4B14DC20.6040808@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Singer <thomas.singer@syntevo.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 11:09:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFPfB-00075j-Pa
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 11:08:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754010AbZLAKIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 05:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753982AbZLAKIm
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 05:08:42 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:12953 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753930AbZLAKIl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 05:08:41 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NFPf5-0000dH-BP; Tue, 01 Dec 2009 11:08:47 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 1A3401660F;
	Tue,  1 Dec 2009 11:08:47 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4B14DC20.6040808@syntevo.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134193>

Thomas Singer schrieb:
> To be more precise: Who is interpreting the bytes in the file names as
> characters? Windows, Git or Java?

In the case of git: Windows does it, using the console's codepage to
convert between bytes and Unicode.

I don't know about Java, but I guess that no conversion is necessary
because Java is Unicode-aware.

-- Hannes
