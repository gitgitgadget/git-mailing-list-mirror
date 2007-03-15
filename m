From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/5] diff --quiet
Date: Thu, 15 Mar 2007 09:19:19 +0100
Message-ID: <81b0412b0703150119l705eefb6h6af44b9452db83e2@mail.gmail.com>
References: <7vwt1j8z0e.fsf@assigned-by-dhcp.cox.net>
	 <7vodmv7bza.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0703141614m70f4a565qc001e06e60b0ffd5@mail.gmail.com>
	 <7v8xdz5qn0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 15 09:19:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRlBI-0004Cw-LW
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 09:19:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933430AbXCOITX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 04:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933386AbXCOITX
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 04:19:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:14530 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933430AbXCOITV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 04:19:21 -0400
Received: by ug-out-1314.google.com with SMTP id 44so229804uga
        for <git@vger.kernel.org>; Thu, 15 Mar 2007 01:19:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i7BqVb7llRpER8mGZdPoZ/tphJ7ht51d9OX8lzN+e2vHOp3NZWY3W0Zmt/kvKy87J/rKH6Z7OoL/1IZWjzPtdUlQGEjZTqRxJW/zCtsSkPE2SPgthbN7Y+9Vt0jT0XT4jnDobuDRGjvP8wrnCjOMjYCwrW9+Tzij1oKlK5tcfns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q+VWqNwAgAqp+auYYNR/s8aLZGrp0olyQgfq5cYiO7nZe/3bSP6Swa+PS5oPOARUlhwgGCbCqCABWkjMgM7ef0Yi2whfXQkDPcnROlu+RsVPgu7Tf42ejFpdlrcqNia0JLPel8nWkZgAmW2u9SiWScRQlW5GNQ3fWPXc7SvnKUs=
Received: by 10.78.150.7 with SMTP id x7mr217320hud.1173946759758;
        Thu, 15 Mar 2007 01:19:19 -0700 (PDT)
Received: by 10.78.138.5 with HTTP; Thu, 15 Mar 2007 01:19:19 -0700 (PDT)
In-Reply-To: <7v8xdz5qn0.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42272>

On 3/15/07, Junio C Hamano <junkio@cox.net> wrote:
> > Now I'm happy :)
> >
> > ~/linux$ time git diff-tree -r -s v2.6.16 v2.6.20
> >
> > real    0m0.137s
> > user    0m0.117s
> > sys     0m0.020s
> > ~/linux$ time ~/projects/git-diff/git-diff-tree -r --quiet v2.6.16 v2.6.20
> >
> > real    0m0.006s
> > user    0m0.000s
> > sys     0m0.007s
>
> You do not need diff-tree --quiet to do that!
>
>         $ git-rev-parse v2.6.16^{tree} v2.6.20^{tree}
>

Why would I want to benchmark --quiet with rev-parse?
