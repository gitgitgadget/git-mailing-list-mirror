From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] [PATCH 09/11] Add MSVC porting header files.
Date: Mon, 17 Aug 2009 21:21:43 +0200
Message-ID: <200908172121.43430.j6t@kdbg.org>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com> <1250525103-5184-3-git-send-email-lznuaa@gmail.com> <1250525103-5184-4-git-send-email-lznuaa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Mon Aug 17 21:22:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md7mF-0000nI-Fs
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 21:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483AbZHQTVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 15:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752477AbZHQTVp
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 15:21:45 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:13701 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750831AbZHQTVp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 15:21:45 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id C6D70CDF83;
	Mon, 17 Aug 2009 21:21:43 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 858BB453F7;
	Mon, 17 Aug 2009 21:21:43 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1250525103-5184-4-git-send-email-lznuaa@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126255>

On Montag, 17. August 2009, Frank Li wrote:
> diff --git a/compat/msvc.h b/compat/msvc.h
> new file mode 100644
> index 0000000..6071565
> --- /dev/null
> +++ b/compat/msvc.h
> @@ -0,0 +1,95 @@
> +#ifndef __MSVC__HEAD
...
> +#endif
> \ No newline at end of file

Please fix these "No newline at end of file" an all cases (I quoted only one 
instance where I saw this).

-- Hannes
