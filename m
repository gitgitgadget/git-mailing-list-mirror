From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v4] gitk: Use git-difftool for external diffs
Date: Thu, 8 Apr 2010 02:02:14 -0700
Message-ID: <20100408090211.GA31594@gmail.com>
References: <201003281259.06947.markus.heidelberg@web.de> <1270001399-26031-1-git-send-email-davvid@gmail.com> <201004021332.53562.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Mackerras <paulus@samba.org>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 08 11:04:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzneq-0004TH-NJ
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 11:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756085Ab0DHJEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 05:04:12 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:58472 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904Ab0DHJEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 05:04:09 -0400
Received: by gwb19 with SMTP id 19so1068261gwb.19
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 02:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=UbgrkPNKh3UJtvhYT8smiYpfxlNzVKI3AiQnlDsyctI=;
        b=TPtFeHLt4qSEEyEgDCUkXVy2d2UE+ZUHO/XZXhLlG+zYvu3D4briGOdDT0pYK22PHu
         kfrGc6GeTKRXHjZzT4CjxpYSXsY7Y7Jjo6ezexsqW+1ox4DzjWembIjbRyxwFLVmJV0r
         QnSFRUk/Xi1X1L9tc6YOWeKb8eISssm0pgGwk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CSk0f2Kgt7836qiVQVX9kgWuPQYj5vUzGLHjnuHm7jOzsVAwHbdIx+C2HsFkAtirs1
         5ErpAhrfTU/wHT9YUddrmDPRF1ndSMMwAC4kj+q5qJcXDCLQujjz9mN8mzj6/pnotxa8
         t02qE6pnl3cFt7qpqGxzdLxrXuXngFCVk810o=
Received: by 10.100.243.36 with SMTP id q36mr19577421anh.68.1270717448276;
        Thu, 08 Apr 2010 02:04:08 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 4sm4105743ywi.51.2010.04.08.02.04.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Apr 2010 02:04:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201004021332.53562.markus.heidelberg@web.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144347>

On Fri, Apr 02, 2010 at 12:32:53PM +0100, Markus Heidelberg wrote:
> David Aguilar, 2010-03-31 04:09:
> > This teaches gitk about git-difftool.  A benefit of this change
> > is that gitk's external diff feature now works with read-only
> > repositories.
> > 
> > Signed-off-by: David Aguilar <davvid@gmail.com>
> 
> Tested-by: Markus Heidelberg <markus.heidelberg@web.de>

Paul, you haven't replied yet but I do remember you mentioning
that you like to keep gitk backwards-compat with older git.
I have a newer version of this patch that checks for the
existence of difftool --extcmd=<cmd> before trying to use it.
It'll be PATCH v5.

-- 
		David
