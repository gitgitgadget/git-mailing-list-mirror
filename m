From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Updated Kernel Hacker's guide to git
Date: Thu, 21 Dec 2006 20:04:27 +1300
Message-ID: <46a038f90612202304uabdffacld857cfcb90ec3e76@mail.gmail.com>
References: <4589F9B1.2020405@garzik.org> <4589FD9E.2010000@bellsouth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jeff Garzik" <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Thu Dec 21 08:04:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxHyh-0001jT-Jq
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 08:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422778AbWLUHE3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 02:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422781AbWLUHE3
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 02:04:29 -0500
Received: from wx-out-0506.google.com ([66.249.82.224]:46637 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422778AbWLUHE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 02:04:28 -0500
Received: by wx-out-0506.google.com with SMTP id i28so2335909wxd
        for <git@vger.kernel.org>; Wed, 20 Dec 2006 23:04:27 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kxk1ZbqdvSv5igmhnQZg+JzXGeXAWAq3CvVE4V5mblV3ghCXXNzt8c4TEDsfkpWGSchtYloGqaNYQ7WTc0Cs+7agxbyN4gzJQeqe7V5VwWGdLQKlQQUKC/1rYLklcEiqqhxFHCtbTfLvVyNJxj025xZxjseeDn9y4gbUjryoE/o=
Received: by 10.90.52.18 with SMTP id z18mr8268890agz.1166684667926;
        Wed, 20 Dec 2006 23:04:27 -0800 (PST)
Received: by 10.90.96.19 with HTTP; Wed, 20 Dec 2006 23:04:27 -0800 (PST)
To: "Jay Cliburn" <jacliburn@bellsouth.net>
In-Reply-To: <4589FD9E.2010000@bellsouth.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35021>

On 12/21/06, Jay Cliburn <jacliburn@bellsouth.net> wrote:
> $ git diff $(git merge-base master driver)..driver

There is a nicer way to do it with 1.4.x git -- note the 3 dots:

$ git diff master...driver

cheers,


martin
