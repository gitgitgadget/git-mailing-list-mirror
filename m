From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Sun, 3 Sep 2006 14:18:33 +0200
Message-ID: <e5bfff550609030518o5e78bb05w4df4235a4931c2dd@mail.gmail.com>
References: <44fac1ee.308dbbaf.574b.08a5@mx.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 03 14:18:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJqw9-0000xf-JO
	for gcvg-git@gmane.org; Sun, 03 Sep 2006 14:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWICMSo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Sep 2006 08:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWICMSo
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Sep 2006 08:18:44 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:40881 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750908AbWICMSo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Sep 2006 08:18:44 -0400
Received: by py-out-1112.google.com with SMTP id n25so2144799pyg
        for <git@vger.kernel.org>; Sun, 03 Sep 2006 05:18:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SioaRpEMbZ3CowG621KJKkdAAp3/t+7jRknsItw51+BWEP2wMcodcvls6+sGCfhoTk6/dD7URj8f3KE94aZXNBvXeUZ987Uha4y7h6OOglLRJ2Cd8SNgtv6EoZUDjAA/gvTU6qJc1fiSLr7rqQ3hMAaOwSVHFg1KbK9l9V/1Hio=
Received: by 10.35.74.1 with SMTP id b1mr7564508pyl;
        Sun, 03 Sep 2006 05:18:33 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Sun, 3 Sep 2006 05:18:33 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <44fac1ee.308dbbaf.574b.08a5@mx.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26372>

>
> By the way, do you known any common Perl modules for generating PNG
> (graphs)?
>

No, I don't. sorry. Anyway, from my experience with qgit I can say
that one thing is to produce a revision graph, another thing is to
produce a _fast_ and (perhaps more important) no memory hogger
revision graph.

Both qgit and gitk implement heavy optimizations and a lot of tricks
to make that happen. IMHO this is almost mandatory with long and
complex histories like Linux tree. I'm not sure a generic graph
builder is up to the task.

More, gitweb is designed to be used by many people at the same time,
while qgit and gitk are for personal use only, and this adds burden
from the performance/resources  point of view.


  Marco

-- 
VGER BF report: U 0.807973
