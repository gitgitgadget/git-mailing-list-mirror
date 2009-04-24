From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2] Documentation: replace sha1 by SHA-1
Date: Fri, 24 Apr 2009 17:18:47 +0200
Message-ID: <49F1D857.7060100@viscovery.net>
References: <1240584575-5702-1-git-send-email-git@drmicha.warpmail.net> <1240584575-5702-2-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 24 17:21:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxND6-0000H5-RK
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 17:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700AbZDXPSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 11:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752513AbZDXPSx
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 11:18:53 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:9276 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956AbZDXPSw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 11:18:52 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LxNAs-0004Ki-Ee; Fri, 24 Apr 2009 17:18:46 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 290286C4; Fri, 24 Apr 2009 17:18:46 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1240584575-5702-2-git-send-email-git@drmicha.warpmail.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117451>

Michael J Gruber schrieb:
> diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
> index 287c4fc..73e1dc4 100644
> --- a/Documentation/git-fsck.txt
> +++ b/Documentation/git-fsck.txt

These hunks are in a section that talks about fsck's diagnostics.

> +missing SHA-1 directory '<dir>'::
> +	The directory holding the SHA-1 objects is missing.

This message does not present in the code anywhere; it could be removed
from this list.

> +SHA-1 mismatch <object>::

And this one occurs in the code, and so it should be changed as well.

> +	The database has an object who's SHA-1 doesn't match the

-- Hannes
