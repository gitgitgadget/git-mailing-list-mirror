From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: bare vs non-bare <1.7 then >=1.7 ?
Date: Sat, 10 Nov 2012 10:37:33 -0000
Organization: OPDS
Message-ID: <CAC80649467C483086BB0C33A0BF2747@PhilipOakley>
References: <e4dc73e8-69f9-4695-b8f7-cbc0f04e8197@zcs>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git Issues" <git@vger.kernel.org>
To: "Enrico Weigelt" <enrico.weigelt@vnc.biz>,
	"Mihamina Rakotomandimby" <mihamina@rktmb.org>
X-From: git-owner@vger.kernel.org Sat Nov 10 11:37:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TX8Rk-0007s3-95
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 11:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201Ab2KJKhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 05:37:33 -0500
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:2522 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751069Ab2KJKhc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2012 05:37:32 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArANAIItnlBcHm+W/2dsb2JhbABEhhmFP7Z4AQECgQCBCYIZBQEBBAEIAQEZFR4BASEFBgIDBQIBAxUBBAIFIQICFAEEGgYHFwYBEggCAQIDAYdzCqp+kkCBIopzAk4xHDWDZTJhA410mEqCbw
X-IronPort-AV: E=Sophos;i="4.80,751,1344207600"; 
   d="scan'208";a="390438941"
Received: from host-92-30-111-150.as13285.net (HELO PhilipOakley) ([92.30.111.150])
  by out1.ip04ir2.opaltelecom.net with SMTP; 10 Nov 2012 10:37:30 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209269>

From: "Enrico Weigelt" <enrico.weigelt@vnc.biz> Sent: Saturday, November 
10, 2012 8:23 AM

> Wait, there *is* an usecase for such things, deploying trees (eg. 
> webapps)
> some server:
>
> * application is developed in git
> * the final production-system tree is maintained in certian branch
> * a post-update hook acts on a specific production branch and does
>   something like git checkout --detach <treeish>
>
I have an alternative use-case for un-trained collegues :

The network shared drive has master checked out, and the .git directory 
is hidden. Untrained colleagues don't know I have it as a git remote. 
Even if they show hidden directories they will tend to ignore it as 
being just another spurious directory.

I develop on my own box (local directory) on my own branch 'Philip' and 
features therefrom. I push my development history back to the network 
remote to act as a backup. Because I don't touch master I can normally 
push to it quite happily.

When I have some finished work I can change to 'working' on the network 
drive, and merge or rebase my 'Philip' branch into master, and update 
the network's working tree. The untrained folk now see the new updated 
files as if I'd simply worked on / copied into the network share and 
they are non the wiser (yet) that I do have proper (micro managed) 
history.

I can also capture any changes they made to the network share so can go 
back to a point in history when required. It's in matlab and is not a 
big code base.

Philip 
