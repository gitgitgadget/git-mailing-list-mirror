From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: [PATCH] git-compat-util.h: use apparently more common __sgi
 macro to detect SGI IRIX
Date: Wed, 2 Jun 2010 08:43:31 +0000
Message-ID: <20100602084331.GA1782@thor.il.thewrittenword.com>
References: <20100514093838.421864000@mlists.thewrittenword.com>
 <4gJWLBIdRVtK7gq22o-LadCixyvOA-9FlEvk-ZrCHyUsGwArvR9oPkV-qlez-T-Nsn0v6UO633Y@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, drafnel@gmail.com
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Jun 02 10:43:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJjY2-00052K-5r
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 10:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752459Ab0FBInd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 04:43:33 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:60649 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059Ab0FBInc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 04:43:32 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id BFC2E5CCE;
	Wed,  2 Jun 2010 09:01:10 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com BFC2E5CCE
Received: from thor.il.thewrittenword.com (thor.il.thewrittenword.com [10.191.57.1])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 7490FE1B;
	Wed,  2 Jun 2010 08:43:31 +0000 (UTC)
Received: by thor.il.thewrittenword.com (Postfix, from userid 1048)
	id 64AD1BAB6; Wed,  2 Jun 2010 08:43:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4gJWLBIdRVtK7gq22o-LadCixyvOA-9FlEvk-ZrCHyUsGwArvR9oPkV-qlez-T-Nsn0v6UO633Y@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96.1 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148230>

Hi Brandon,

On Tue, Jun 01, 2010 at 08:55:36PM -0500, Brandon Casey wrote:
> From: Gary V. Vaughan <git@mlists.thewrittenword.com>
> 
> IRIX 6.5.26m does not define the 'sgi' macro, but it does define an '__sgi'
> macro.  Since later IRIX versions (6.5.29m) define both macros, and since
> an underscore prefixed macro is preferred anyway, use '__sgi' to detect
> compilation on SGI IRIX.
> 
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>

Signed-off-by: Gary V. Vaughan <gary@thewrittenword.com>

> Here's a resubmit of your patch with an updated commit message.  Since the
> __sgi macro seems to be more common than the sgi macro, I modified your
> patch to check for only the __sgi macro.  I know Junio suggested checking
> for both macros, but I'm the one that Junio was talking about when he made
> his comments, and __sgi works for me.

Sure, that's fine.  I only need the __sgi part for git to compile
correctly on my IRIX machines, so if you feel that the non-underscore
flavour is superfluous then I won't miss it! ;)

> It's such a simple little patch, but still I removed your signed-off-by line
> since I modified the patch, and I am not you.  Please do reply to this message
> with a signed-off-by if you sign off on the patch.  Junio will add it to the
> patch when he applies the it.

Done.

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
