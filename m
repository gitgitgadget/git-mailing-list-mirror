From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Fetch from remote A, push to remote B
Date: Fri, 1 Jun 2007 13:52:21 +1200
Message-ID: <46a038f90705311852n136a2bfbwa943a65a43257a6e@mail.gmail.com>
References: <46a038f90705302253s68b70311h3feac7404fa23933@mail.gmail.com>
	 <46a038f90705310028y6f180214s9018f8af5e71d0ed@mail.gmail.com>
	 <46a038f90705311737u7e9a118v9b9865f63a4c6951@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 01 03:52:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtwJZ-0003fH-HP
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 03:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbXFABwW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 21:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbXFABwW
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 21:52:22 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:46205 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbXFABwV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 21:52:21 -0400
Received: by wx-out-0506.google.com with SMTP id t15so348062wxc
        for <git@vger.kernel.org>; Thu, 31 May 2007 18:52:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mTp/N2SujT4pzx1y/wsuMudcoAD8A6Vq7yPJzkYEZhWcJ09IMaY19r1Zu/9rN7DU6DM30cvt298eGt664fdy5XpBYOMadlMntbNfWmp38DRxb7YxnFN7Za2vH//op87SWIkzqRvqL63ScMA1gk3TYcAmWhs9y29aAafboTCoM9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VGL88IthxeSx6x9cH5Uzl1+ICIgjOQv1OGPmuQpdnX09A66yCF+oasiylbwjZzL08cnxXYhqxouMqd75/waJDesZQ1w6oJRjsyW01jMA4T5PbkV1QC/ELlAItkw7OjnVzw+fGlJJfM8ALIXGJIu09cuAmciJX727evGcsf33FKk=
Received: by 10.90.90.16 with SMTP id n16mr1342821agb.1180662741260;
        Thu, 31 May 2007 18:52:21 -0700 (PDT)
Received: by 10.90.53.18 with HTTP; Thu, 31 May 2007 18:52:21 -0700 (PDT)
In-Reply-To: <46a038f90705311737u7e9a118v9b9865f63a4c6951@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48837>

On 6/1/07, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On 5/31/07, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> >   # on cron do
> >   GIT_DIR=bla-transfer.git git-fetch git+ssh://host-a/bla.git
> >   GIT_DIR=bla-transfer.git git-push --all git+ssh://host-b/bla.git
>
> Actually -- this doesn't quite work - the fetch grabs the new objects
> properly but doesn't update the local heads on a bare repo.

Should this work?

GIT_DIR=bla-transfer.git git-fetch git+ssh://host-a/bla.git
+refs/heads/*:refs/heads/*

Earlier discussions about mirroring tools (and Pasky's git-mirror)
finished with this being the recommended technique. Only - it does on
me with

* refusing to create funny ref 'heads/*' locally

cheers,



martin
