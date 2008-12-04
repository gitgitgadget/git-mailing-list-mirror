From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: How to update the tag to Git server?
Date: Wed, 3 Dec 2008 21:35:22 -0500
Message-ID: <eaa105840812031835ofe7d9cck67f4bc58ce5ad0d7@mail.gmail.com>
References: <84437.20577.qm@web37903.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: garyyang6@yahoo.com
X-From: git-owner@vger.kernel.org Thu Dec 04 03:36:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8454-0001ar-RX
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 03:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075AbYLDCfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 21:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754016AbYLDCfZ
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 21:35:25 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:41223 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753954AbYLDCfY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 21:35:24 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1618131yxm.1
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 18:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=KY7G8rMgEHoU6oNBn9UIWrFhlXV9oBZcDSUDPeMU6rg=;
        b=aXr9WYp972aOx9Vh87rM2ADHOTik/rnXlUI74nSbxA5CswARtVD8l3WXvNgcvn7RsY
         MAO+Y9RrmrXVPmWerWBEhX1rftNtoAfFoV+3jnJL3u24PQ8dAmibFY2nPi+mW/uIqx+e
         G5RfJdjd/w7nAUwLAwfVjUHiaRHVEctZ9xe+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=rX0dU8gTefV/93jabUK3b1IB/QW8o3CP+UQhrSClm8oBw3yOAjz7kOIi9NhssZLLgC
         F/XcLwMYVcyBcBy+vyofdOIN8YK1gVdZdo8gEPFueZC1Y7AqRO0ZucZ3BMElrNyS9QkQ
         CSdNG4Kc/yz69o1jguDCCeo045L0UXCuZJomE=
Received: by 10.64.208.8 with SMTP id f8mr13659823qbg.44.1228358122441;
        Wed, 03 Dec 2008 18:35:22 -0800 (PST)
Received: by 10.65.230.19 with HTTP; Wed, 3 Dec 2008 18:35:22 -0800 (PST)
In-Reply-To: <84437.20577.qm@web37903.mail.mud.yahoo.com>
Content-Disposition: inline
X-Google-Sender-Auth: da152accd571f0fd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102323>

On Wed, Dec 3, 2008 at 9:16 PM, Gary Yang wrote:
>
> I pushed code from my local repository to Git Server.
> git push git.company.com:/pub/git/training.git
>
> I, then tagged my local repository.
> git tag -u gyang@company.com RELEASE_2
>
> I want to update the Git server so that I can have the tag at my Git server, I did:
> git push git.company.com:/pub/git/training.git
> Everything up-to-date

Did you try "git push git.company.com:/pub/git/training.git tag
RELEASE_2" or "git push git.company.com:/pub/git/training.git --tags",
as it suggests in "git help push"?

Peter Harris
