From: Tomash Brechko <tomash.brechko@gmail.com>
Subject: Re: [PATCH (resend)] Pass -C1 to git-apply in StGIT's apply_diff() and apply_patch().
Date: Wed, 11 Apr 2007 11:51:33 +0400
Message-ID: <20070411075133.GA5329@moonlight.home>
References: <20070409112422.GE11593@moonlight.home> <b0943d9e0704100948k2b505916w5485b99e72d36c10@mail.gmail.com> <20070410192130.GE4946@moonlight.home> <20070410193214.GF4946@moonlight.home> <b0943d9e0704101538p3de0bf56m7906cfe2f5fc157e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 14:59:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbXcJ-0004bn-Hu
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 09:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbXDKHvo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 03:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbXDKHvo
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 03:51:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:31530 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbXDKHvn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 03:51:43 -0400
Received: by ug-out-1314.google.com with SMTP id 44so62489uga
        for <git@vger.kernel.org>; Wed, 11 Apr 2007 00:51:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:date:from:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Wb//6ISKaR78OCTXbQT1rJDju1CdD0GEPClPlGkDJ/pCZ4IDH64HfVIdR7aJZxUdT4cCSfblwj3zHZXREDIcH1idUGg6kv3JGwssoK5j5wVrdIXTKrA5/M/Pn3Z5mYj+gwEOjRwcEnh7tic+/GYTEZUsdeguNV3JWaP1T+ItJyw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=sxhI/HlgKVHpwEofzdsOd5qVC86K49ulpul7F/WErL2xtuM+eFyvd1I+Us+PZLj0HRgtu3Y7Sk4qE472pjNK9mYIP/1gy6XNit4hrOx5jzzgyLZ8mOXZmjndih6OhiDfbvvvwz30r3tVuQ7NzXSzcOkdKUerZSSP928fqgwjC68=
Received: by 10.67.88.17 with SMTP id q17mr262174ugl.1176277902154;
        Wed, 11 Apr 2007 00:51:42 -0700 (PDT)
Received: from moonlight.home ( [80.246.71.156])
        by mx.google.com with ESMTP id 32sm1759467ugf.2007.04.11.00.51.39;
        Wed, 11 Apr 2007 00:51:41 -0700 (PDT)
Received: from moonlight.home (localhost.localdomain [127.0.0.1])
	by moonlight.home (Postfix) with ESMTP id 0C5BC3A7C2;
	Wed, 11 Apr 2007 11:51:34 +0400 (MSD)
Received: (from tomash@localhost)
	by moonlight.home (8.13.1/8.13.1/Submit) id l3B7pXU3005725;
	Wed, 11 Apr 2007 11:51:33 +0400
Mail-Followup-To: git@vger.kernel.org,
	Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <b0943d9e0704101538p3de0bf56m7906cfe2f5fc157e@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44215>

On Tue, Apr 10, 2007 at 23:38:55 +0100, Catalin Marinas wrote:
> When something has changed in the surrounding code (not touched by
> your patch), the automatic three-way merge should, in general, be able
> to solve the issue as it uses the ancestor information. Is the
> automatic three-way merge failing as well in your case?

OK, maybe I was pushing too much.  Indeed, three-way merge will solve
it, I just don't have a setup where it runs automatically, and I
thought the mege could be avoided alltogether.  But I agree the
problem is easily managable.

And as you agree that the option would be nice we are on the same
page.  Thanks you!


-- 
   Tomash Brechko
