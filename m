From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Many different remote branch sources
Date: Fri, 2 Mar 2007 23:18:36 +0100
Message-ID: <81b0412b0703021418y6ff084d1r9eaf72aeac4eb51@mail.gmail.com>
References: <81b0412b0703020253i3e1478a9pf505c0d95442536c@mail.gmail.com>
	 <Pine.LNX.4.63.0703021645200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 02 23:18:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNG5L-0000PH-0n
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 23:18:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030614AbXCBWSj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 17:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030621AbXCBWSj
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 17:18:39 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:58251 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030614AbXCBWSi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 17:18:38 -0500
Received: by ug-out-1314.google.com with SMTP id 44so831236uga
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 14:18:37 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JkSg7zTMq7d8sda+XQ+vzsY4y//Fwr+NH8rp/GlyCEnTSRP8Ilwr7cpQfUKIL1M09NhkPoFv+q7SMgY0LMwXkUgMNBbkNFGMOn5dgCpNdXxE7Suvau3rs/LvT0UmVnbMBzDA9jgHs7kOKQpGO2sQUY4Li7TJQejVeDmp/sstKyU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eTg+yY+7X736/5qVK0hvabfJ3mpP3IvCfTPq8qX1gLhTJlMEdCuZFxDZGYSn3hI20ICJcrqcyCYJ4yZwuWpKpw/4woTqBZrAQrUG9/+Od/BavW2GqXsCCiZhgIUniD+WAqNY5dcGb0aqAQDcgAw3+Gopze5MHoB1UcvlLFWMFfA=
Received: by 10.78.142.14 with SMTP id p14mr316748hud.1172873916866;
        Fri, 02 Mar 2007 14:18:36 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Fri, 2 Mar 2007 14:18:36 -0800 (PST)
In-Reply-To: <Pine.LNX.4.63.0703021645200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41253>

On 3/2/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Rather, add a "fetch = refs/heads/topic1" at the _top_ of the remotes.dev1
> section, and say "git pull dev1" when you want to pull from dev1.

This is exactly what I wanted. I just somehow believed that
git pull uses only references configured in branch sections,
never the references in "remote" sections. Am a bit confused.
