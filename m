From: Arup Rakshit <aruprakshit@rocketmail.com>
Subject: Re: untracked file deleted from the master branch, when checked out to it from a local branch
Date: Tue, 20 May 2014 22:33:55 +0630
Organization: CognitiveClouds
Message-ID: <1949847.AaDQEtxZHd@linux-wzza.site>
References: <2525467.KRXv8a3gWS@linux-wzza.site> <537B8959.7090100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 19:03:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmnRz-0001hl-VP
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 19:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667AbaETRDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 13:03:36 -0400
Received: from nm25-vm6.bullet.mail.sg3.yahoo.com ([106.10.151.101]:31305 "EHLO
	nm25-vm6.bullet.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752103AbaETRDf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 May 2014 13:03:35 -0400
Received: from [106.10.166.113] by nm25.bullet.mail.sg3.yahoo.com with NNFMP; 20 May 2014 17:03:33 -0000
Received: from [106.10.167.145] by tm2.bullet.mail.sg3.yahoo.com with NNFMP; 20 May 2014 17:03:33 -0000
Received: from [127.0.0.1] by smtp118.mail.sg3.yahoo.com with NNFMP; 20 May 2014 17:03:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s1024; t=1400605413; bh=7hyQXgrQ6frjp4iQaMUF8Ry146N5ga81XsI+9dj0xRM=; h=X-Yahoo-Newman-Id:X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:X-Rocket-Received:From:To:Subject:Date:Message-ID:Organization:User-Agent:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type; b=CZ5CoeJH033xnhKGmYUbtZFel6v3NSHJ1rFIfXZE9cr4STiLHOnxdjAtJCJZjFcBSaFad1jTPcno8rVgy1NYNuyQPOPh4etuOYPwJzo7ACfqeiL/8pIjrfQlSDHQNuJq2URLS5PonQ595GxgDGyiDtNi/kgeHQhMN2VA77Eii4s=
X-Yahoo-Newman-Id: 848490.98733.bm@smtp118.mail.sg3.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: 4Elzl3oVM1nYXamTWyZmys0k4dAWNQJK6RjDURFyJ1l8Sjw
 UXISq0Tj6bIPQM9NHX72XTHVkvzSi1YCLj1S2vvLciUNjzutqWg5JNPihAkg
 Oo1PZOHzUyROcsAS2qGh6Bu8KChZz67bv4J9xrTIyM5QW8xbyYhqpv2wfx9e
 VEDTZ.DzmsYq2aTt0vF3wLdGU1OwQxGVlbJtiUZN6ZBBioLVSpu7qELWIDqs
 TYVrjVyGKb81lzw.y5s2DojpuKV4ywIRxD0l1o7jVmqa3ZjlFV0NQabehBU3
 _LRiezjLJjZ2UHyv4qGGYE1AHwPsiU6wKYL2B2sT22yqbcdDNN7.gGIFiSRC
 AAPIOynSaWhkRdqAchC6VPv8ICHBYYPnOMTKJpkn.Q5gjFxP9c4h52BCx7MY
 8wyNaR1FLitT7xD0LlRu2JDfGhv5n8SbCw5JVOmf2QkXVOlpfYFpGP0j1GAk
 od.BOuKfgRX99V4ViYHpjK4BPnXLlMdWjUdIHsFdwigOo05Y7ujRs_nEJVss
 LlxQR6DitFM07x0M0kflV6IM5iCodm.A0w1MHFxLksGn9TD5fzX1.2619L0P
 vn2rvzWE64E_TOcI20RBmMUZ2bM6IJZEofcxOmsTjLJdw4q5IEJJdjmV647_
 yUHVDoDgOOb4J2g--
X-Yahoo-SMTP: _NAuC72swBDpdridK5c7mltfXc1K.nFhPY5jXEZ4Gfdya8Gn_0nN
X-Rocket-Received: from linux-wzza.site (aruprakshit@117.254.107.189 with plain [106.10.150.171])
        by smtp118.mail.sg3.yahoo.com with SMTP; 20 May 2014 10:03:33 -0700 PDT
User-Agent: KMail/4.11.5 (Linux/3.11.10-7-default; KDE/4.11.5; i686; ; )
In-Reply-To: <537B8959.7090100@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249701>

On Tuesday, May 20, 2014 11:56:57 AM you wrote:
> On 5/20/2014 10:38 AM, Arup Rakshit wrote:
> > I was following some tutorial (http://gitref.org/branching/#merge) - and
> > doing it in my console :

> 
> Because you never committed the original file to the master branch
> before you created and switched to the change_class branch.
> 
> You're missing
>      git add test.rb
>      git commit -m "initial version of test.rb"
> before you switch branches the first time.

Hum, But when I create a new branch from master, then it came to the new 
branch, but deleted from the master. Shouldn't it also not come to the new 
local branch also. That's how I expected.

-- 
===============
Regards,
Arup Rakshit
