From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH] Better diagnostic for wrong branch configuration.
Date: Sun, 7 Oct 2007 22:04:21 +0100
Message-ID: <b0943d9e0710071404i549f4290u4f5ba7ada355bb54@mail.gmail.com>
References: <20071005204452.30902.60246.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sun Oct 07 23:04:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IedIj-0000wD-9n
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 23:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbXJGVEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 17:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752054AbXJGVEW
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 17:04:22 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:51305 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbXJGVEV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 17:04:21 -0400
Received: by rv-out-0910.google.com with SMTP id k20so582054rvb
        for <git@vger.kernel.org>; Sun, 07 Oct 2007 14:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=IdTHni/kY+l56CFHp+QsggzuTdDwa0KP50waCypLtjg=;
        b=KgZNvu0s4RsVPgL6ohBFGV0uWtxQXcS8DOq0ihQXFSkA4UF6OrGKQwQRWW880wV0tTo25TRvMSf5G8jx4e8PnWfpi9Wr4Nuh7L9aGwMfPXszUcvsdkPHCWKwvPCPZLasVV5nFd4ikm9GIf+XtOwf4Jp4Fq/b9TVTeK0uBXhGglk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZZ2NHyv1k/RCmvREQkhNudJztaBiJw8Pe55JCZiKIlZs5NpWPgYy+lcn4JTMK3n/hZDsQ5aZtgO5oqN2MWvAW/uN596OqcyrKwX1Ap2ifKmxtr93czofUqSg9cibHYcF40iy9BHioYbWhhOfAK2JeFZK3LrjkeB7NRHdDqVU19k=
Received: by 10.140.226.14 with SMTP id y14mr2603217rvg.1191791061131;
        Sun, 07 Oct 2007 14:04:21 -0700 (PDT)
Received: by 10.140.187.15 with HTTP; Sun, 7 Oct 2007 14:04:21 -0700 (PDT)
In-Reply-To: <20071005204452.30902.60246.stgit@gandelf.nowhere.earth>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60216>

On 05/10/2007, Yann Dirson <ydirson@altern.org> wrote:
> If the branch.*.merge parameter does not name a valid remote head,
> stgit would not rebase after a fetch, and would write instead
> 'Rebasing to "None" ... done'.

Applied, thanks. I'll try it tomorrow with my StGIT over SVN
configuration as well (it works OK with the latter patches).

-- 
Catalin
