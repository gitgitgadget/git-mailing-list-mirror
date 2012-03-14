From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH v3 1/3] Demonstrate a bug in --word-diff where diff.*.wordregex
 is "sticky"
Date: Wed, 14 Mar 2012 22:03:04 +0100
Message-ID: <4F610788.3090604@gmail.com>
References: <3bb99e938624ae674674b304c24c48b9dc05871b.1331749299.git.trast@student.ethz.ch> <7vsjhboujp.fsf@alter.siamese.dyndns.org> <4F60F67D.9050003@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Mar 14 22:03:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7vLo-0001so-DK
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 22:03:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761514Ab2CNVDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 17:03:12 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:40600 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761456Ab2CNVDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 17:03:09 -0400
Received: by bkcik5 with SMTP id ik5so1628559bkc.19
        for <git@vger.kernel.org>; Wed, 14 Mar 2012 14:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=/dFHZJeocyFSHwjiwe1V5e45i/dhE2g6VXo08A3NxrU=;
        b=pP/V34TAVfVXLq1GEPCNEe+XkyLMkDMs59lDMF10eSUTBONeaIg8rKXE1/2vT7n0WQ
         eTRYHaF1x6D3LZf/2SYNuCSPNUUHWqEYQkpYRLHoltSnACgjPoyTDCOKF95IEoKeEKXT
         EiuqNvnBEY0IQWdRFnhK1PL5l8JDbJA+RAfxkyrrkhQ+kiqjsxcV0d8/CRf9Q7mSOjkR
         vR68lnl0vnC9XzcVhqAcHv+L6dKNUtp3jTuC/KAbntCeKKV3EY+P2+iJRpIdRSYQHZfe
         vRqLGG4aAEwEfTz07xB78sZVAc3uaq/y9AJaAlQaAvZbKUwDNa7jtVZ3y0fBhGORrpGb
         BTJA==
Received: by 10.205.136.12 with SMTP id ii12mr1485119bkc.98.1331758988064;
        Wed, 14 Mar 2012 14:03:08 -0700 (PDT)
Received: from [87.2.95.143] (host143-95-dynamic.2-87-r.retail.telecomitalia.it. [87.2.95.143])
        by mx.google.com with ESMTPS id s16sm10275645bkt.3.2012.03.14.14.03.05
        (version=SSLv3 cipher=OTHER);
        Wed, 14 Mar 2012 14:03:06 -0700 (PDT)
In-Reply-To: <4F60F67D.9050003@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193163>

On 03/14/2012 08:50 PM, Johannes Sixt wrote:
> The test case applies a custom wordRegex to one file in a diff, and expects
> that the default word splitting applies to the second file in the diff.
> But the custom wordRegex is also incorrectly used for the second file.
> 
> Helped-by: Thomas Rast <trast@student.ethz.ch>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> Changes in this round, where I do not resend 2/3 and 3/3:
> 
> - Use test_unconfig.
> - Use compare_diff_patch to check the result.
> - Fix a broken && chain at the end of the last test.
> - Name the files a.tex and z.tex as per your suggestion.
>
But Junio suggested using 'z.txt' (not 'z.tex'); quoting his last message:

  The use of files "a" and "z" as an example of pair of a tex and non tex
  input makes the test look overly artificial (why not a.tex vs z.txt or
  something?), but other than that, looks cleanly done.

Regards,
  Stefano
