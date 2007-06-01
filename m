From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Fetch from remote A, push to remote B
Date: Fri, 1 Jun 2007 12:37:51 +1200
Message-ID: <46a038f90705311737u7e9a118v9b9865f63a4c6951@mail.gmail.com>
References: <46a038f90705302253s68b70311h3feac7404fa23933@mail.gmail.com>
	 <46a038f90705310028y6f180214s9018f8af5e71d0ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 01 02:38:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Htv9V-00016w-7B
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 02:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756780AbXFAAhx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 20:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756998AbXFAAhx
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 20:37:53 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:64188 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756424AbXFAAhw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 20:37:52 -0400
Received: by wr-out-0506.google.com with SMTP id i21so322829wra
        for <git@vger.kernel.org>; Thu, 31 May 2007 17:37:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ErmEiyQJ8bSElB01XkGN0KxQ6sGgCYrjGVqP9MrtFk0ia1+uUK2+MoKdWCqf+RI2si1MWqx/gDKwkuDt5xIVlCFnLbahZjDyzGK+UVAl6uILLVv2hngIjrm1xVMaUYv9YbjHd09A985S1+/BFHtbizmAB2Q/h+fpDc91IXNcOaY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dSVxsJ0aBBQ97ttBtR3/anDPVRqy66JzSgdk2+L4q6298w9mZBYsjQKMOlb98gnU5PVIxbl7oyEQ7SZNeDdx9IMsPSnxwMlzgtVbZFmR0tu3quyg+dShxHrxjEn3q482kHg9uGwsB3IU8Qd5v5/Q6UaDR0BDhfSb11V0Pbd/hwg=
Received: by 10.90.74.1 with SMTP id w1mr1317397aga.1180658271889;
        Thu, 31 May 2007 17:37:51 -0700 (PDT)
Received: by 10.90.53.18 with HTTP; Thu, 31 May 2007 17:37:51 -0700 (PDT)
In-Reply-To: <46a038f90705310028y6f180214s9018f8af5e71d0ed@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48835>

On 5/31/07, Martin Langhoff <martin.langhoff@gmail.com> wrote:
>   # on cron do
>   GIT_DIR=bla-transfer.git git-fetch git+ssh://host-a/bla.git
>   GIT_DIR=bla-transfer.git git-push --all git+ssh://host-b/bla.git

Actually -- this doesn't quite work - the fetch grabs the new objects
properly but doesn't update the local heads on a bare repo.

cheers,



m
