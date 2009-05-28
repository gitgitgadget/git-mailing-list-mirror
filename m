From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 1/2] compat: add a mkstemps() compatibility function
Date: Thu, 28 May 2009 02:31:53 -0700
Message-ID: <20090528093152.GA12566@gmail.com>
References: <1243491077-27738-1-git-send-email-davvid@gmail.com> <4A1E3834.3020502@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, markus.heidelberg@web.de,
	jnareb@gmail.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 28 11:32:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9byE-0008Gv-FY
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 11:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755220AbZE1JcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 05:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754312AbZE1JcJ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 05:32:09 -0400
Received: from mail-pz0-f177.google.com ([209.85.222.177]:42869 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbZE1JcI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 05:32:08 -0400
Received: by pzk7 with SMTP id 7so4122174pzk.33
        for <git@vger.kernel.org>; Thu, 28 May 2009 02:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=HwUwOVUWMk47D/B1o79McHrh6KfA3EBRldOJJGquk/s=;
        b=Z1G0m9WgXyBvShHZJSkSo+/8FAR7ROVw78crx+tkUojj87V+MVzYLpuMjS6lDxXJ9g
         xll9WBW0JB15xApWPApnIFED1xPepv5f2P2gHMf3hTVMEx+1ET0kfGB3v2lBPA8AHpWt
         94ckDW4hA056Pb1gJ325sKZiquPMAlB3HO9UM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SnTFkK+cZDOhx8LKf8DQt7APkyTjXYCbQifPR/uGCE3DTSwVScgTgRJkLnyK/LkMwt
         TvXrInjPRjVvJ7raNIuL4J3poaMaEfTcG6OmRelBoI1mGhME0B3XzwHUk+9Kq7FQdIP5
         BRG+/r5pGIbdFQoQKw9EyA1GOMRdrlD2hNiWg=
Received: by 10.114.122.5 with SMTP id u5mr969046wac.5.1243503130137;
        Thu, 28 May 2009 02:32:10 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id m6sm248113wag.14.2009.05.28.02.32.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 May 2009 02:32:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A1E3834.3020502@viscovery.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120175>

On Thu, May 28, 2009 at 09:07:32AM +0200, Johannes Sixt wrote:
> David Aguilar schrieb:
> 
> You should not include "random" system headers, nor has mkstemps any
> business deciding whether files are opened in binary mode. We are not
> using O_BINARY anywhere else (except in compat/mingw.c). With the patch
> below squashed in (I hope it won't be wrapped) you can add:
> 
> Tested-by: Johannes Sixt <j6t@kdbg.org> (Windows)
> 
> to both your patches. And, yes, I like them :-)
> 
> -- Hannes


Thanks.
I'll squash these in and resend 1/2 in a moment.


-- 

	David
