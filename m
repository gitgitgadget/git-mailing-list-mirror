From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 10/18] rebase -i: Improve consistency of commit count
 in generated commit messages
Date: Thu, 14 Jan 2010 08:54:06 +0100
Message-ID: <4B4ECD9E.5000707@viscovery.net>
References: <cover.1263447037.git.mhagger@alum.mit.edu> <1e03c6ff51ca0e6da4c19da014523f01a27b1579.1263447038.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jan 14 08:54:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVKWz-0006JE-V3
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 08:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756224Ab0ANHyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 02:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756179Ab0ANHyJ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 02:54:09 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:53485 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756161Ab0ANHyI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 02:54:08 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NVKWt-0002Wp-5s; Thu, 14 Jan 2010 08:54:07 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D3AA81660F;
	Thu, 14 Jan 2010 08:54:06 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1e03c6ff51ca0e6da4c19da014523f01a27b1579.1263447038.git.mhagger@alum.mit.edu>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136962>

Michael Haggerty schrieb:
> Use the numeral "2" instead of the word "two" when two commits are
> being interactively squashed.  This makes the treatment consistent
> with that for higher numbers of commits.

Huh? This is just code churn: consistency is not an advantage here.

Oh...wait... The next patch needs it this way. Couldn't you have justified
it with "In a subsequent change, we will extract the numeral and use it in
an expression."

-- Hannes
