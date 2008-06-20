From: "Alexander Gladysh" <agladysh@gmail.com>
Subject: Re: git svn: how to recover from checksum mismatch?
Date: Fri, 20 Jun 2008 15:36:39 +0400
Message-ID: <c6c947f60806200436q28e110fay7c11b15882c563c6@mail.gmail.com>
References: <c6c947f60806200356s285ac4s7a4affc108c7f311@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 13:37:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9evw-0003qK-Ch
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 13:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbYFTLgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 07:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751984AbYFTLgk
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 07:36:40 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:16730 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbYFTLgk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 07:36:40 -0400
Received: by rv-out-0506.google.com with SMTP id k40so5633480rvb.1
        for <git@vger.kernel.org>; Fri, 20 Jun 2008 04:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=BWh4wnmbyEKZDhE8gKjqCKkJ6K7i13eIhnVhm3Ch8PY=;
        b=MQAiTI/ZvH0IjzBT4WIZGppn/SHwIilgDwbTPN5vp0PqDZKfpCWK99q6KxxvP+s7m9
         pCwxkmaNQ3pJdAmzv12ViQCyL8wC3EbgST+6Imms/0SmH3FJpHmS1cFOm00DXckMVLgx
         RrEpL9/f32YDGFafVE3nRHfi5LeqVSUUOwCUE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=gTsQBnyNb97zYE6tfjpplZsx/gtHSC3YnFgZ6kxaeqWq3/eLd8FpUhr5f8wtLUgTIk
         bM9aQdQ46wcSMTq+1bP1UZF5d7g1jMgw7OU4OQ6gg9SfgChvzNZVmCwckJq32nasOyeW
         0CTqgnUv0fzoiIjH5dWuJ/3wYNFKQ3F9GUNJ4=
Received: by 10.140.250.14 with SMTP id x14mr7443773rvh.79.1213961799500;
        Fri, 20 Jun 2008 04:36:39 -0700 (PDT)
Received: by 10.141.48.15 with HTTP; Fri, 20 Jun 2008 04:36:39 -0700 (PDT)
In-Reply-To: <c6c947f60806200356s285ac4s7a4affc108c7f311@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85622>

> I have reverted back to git 1.5.5.1, but I still get that checksum
> error. I'm fetching a fresh git svn init+fetch from svn, but it takes
> a few hours, and I have to do it twice (for each of my two repos). Any
> advice on how can I recover less painlessly?

That is more painlessly of course, not less, sorry :)
