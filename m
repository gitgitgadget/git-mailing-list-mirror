From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT RFC PATCH] Activate rename detection by default.
Date: Tue, 15 May 2007 16:41:47 +0100
Message-ID: <b0943d9e0705150841l6fe05baajab67a16eb78e411d@mail.gmail.com>
References: <20070504235413.29479.13640.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Tue May 15 17:42:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnzA3-0008NA-JH
	for gcvg-git@gmane.org; Tue, 15 May 2007 17:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755023AbXEOPlu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 11:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754985AbXEOPlu
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 11:41:50 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:55331 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754497AbXEOPlu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 11:41:50 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1606090uga
        for <git@vger.kernel.org>; Tue, 15 May 2007 08:41:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Mnu5BzF8KdtZ06CEFPQ+KkMIV4nAJCDDrTkNecEY01H536dSVp5zM9k2AcBeKXSAQ1EBb2Dnj09yENsWF2ZSXGYTBmY5FIh4SG3TZp0YexxOcEPNvempTCmReXRzyneBFQ/ykmn0vOabghT+OKgoJ51Yjl9zhw4mMTGEWw7hHIM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K3dLhdR/cWltD54fGFk4qVcR6D/usWxBdeppjNZxbaAncQyawmp+iN1FYjw/3yyNlwSxw8fY7bd8WJKmpCN510lkFYKXjk0jHr9NtG4mCHrVUclTthLluP8KFUzilGUNVqsqAppifDp1iIkAucFm8zF04X0gns/iuGc1kEtnSZ8=
Received: by 10.78.200.3 with SMTP id x3mr2732261huf.1179243708368;
        Tue, 15 May 2007 08:41:48 -0700 (PDT)
Received: by 10.67.27.11 with HTTP; Tue, 15 May 2007 08:41:47 -0700 (PDT)
In-Reply-To: <20070504235413.29479.13640.stgit@gandelf.nowhere.earth>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47351>

On 05/05/07, Yann Dirson <ydirson@altern.org> wrote:
> This patch uses -M when generating diffs, which then looks fine, just
> like any other git-generated diff.

I think we should only use -M for "files", "status", "show", "diff"
but not for "export" and "mail", maybe by adding an extra parameter to
git.diff() (or we could have this configurable or with an cmd line
option). The reason is that I send patches that might not be applied
with GIT.

-- 
Catalin
