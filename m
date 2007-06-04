From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 4/4] Add new --diff-opts/-O flag to diff- and status-related commands.
Date: Mon, 4 Jun 2007 23:15:23 +0100
Message-ID: <b0943d9e0706041515l6114a015ye45d40478cc0e3ef@mail.gmail.com>
References: <20070531222920.6005.74481.stgit@gandelf.nowhere.earth>
	 <20070531223438.6005.76115.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Tue Jun 05 00:15:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvKq1-0008VU-ED
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 00:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882AbXFDWPf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 18:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756311AbXFDWPf
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 18:15:35 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:32756 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756474AbXFDWPf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 18:15:35 -0400
Received: by ug-out-1314.google.com with SMTP id j3so893549ugf
        for <git@vger.kernel.org>; Mon, 04 Jun 2007 15:15:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PEIv5j7/6h5MD1FkiY2OCVl7s+lqO3qgEgluWv6pmuvPSE/r9I+mh0aoPzF2rtWtvQtqwmSjIfZDXUW5s7p0/9FHeF10SE7ej+mRR36vWybt6My19Nstwj0lRsNXaCdnuwxneiXGUsEHdGAKF6Iy2fyDOhJQYVOdFAqYbtjtbAI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t5epRjUq5fc7Xnz/yog2d6d0O8bQ0zd3QMD77lxSFiJxovGmm7TSHIJkbHu3DZb4Ct7OJvVNW66iupbCNEBFJC3sA0HrISQXbI1atDAHAtJ+l/Sypr4jmgnSkuh1JKv7m27c0UMC4jli9czbaKFzLP8TmsC1AfmovnRo7rygiw4=
Received: by 10.67.115.14 with SMTP id s14mr3403275ugm.1180995323536;
        Mon, 04 Jun 2007 15:15:23 -0700 (PDT)
Received: by 10.67.27.11 with HTTP; Mon, 4 Jun 2007 15:15:23 -0700 (PDT)
In-Reply-To: <20070531223438.6005.76115.stgit@gandelf.nowhere.earth>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49134>

On 31/05/07, Yann Dirson <ydirson@altern.org> wrote:
> This new flag allows to pass arbitrary flags to the git-diff calls
> underlying several StGIT commands.  It can be used to pass flags
> affecting both diff- and status-generating commands (eg. -M or -C), or
> flags only affecting diff-generating ones (eg. --color, --binary).
>
> It supercedes --binary for commands where it was allowed,
> '-O --binary' is now available for the same functionality.

BTW, should we add --binary by default to export and mail? Do you see
any problem with this?

Another idea would be to add support for a [stgit "options"] section
with entries like "mail = -O --binary".

-- 
Catalin
