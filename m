From: Andreas Ericsson <ae@op5.se>
Subject: Re: Rework a patch serie
Date: Tue, 27 Jun 2006 10:53:11 +0200
Message-ID: <44A0F1F7.9010503@op5.se>
References: <20060627084130.28886.qmail@web25814.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 27 10:53:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fv9KP-0006I4-Lf
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 10:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932660AbWF0IxO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 04:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932800AbWF0IxO
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 04:53:14 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:10929 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932660AbWF0IxN
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 04:53:13 -0400
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 078B86BCBC; Tue, 27 Jun 2006 10:53:12 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
To: moreau francis <francis_moreau2000@yahoo.fr>
In-Reply-To: <20060627084130.28886.qmail@web25814.mail.ukl.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22716>

moreau francis wrote:
> Hello
> 
> Several times I have a topic branch that contains several commits like
> this:
> 
>             "master"
>         o---o
>              \                    "topic"
>               o---o---o---o---o---o
> 
> 
> When I think everything is in a good shape I generate several patches to
> submit them. For that, I do:
> 
>         $ git checkout topic
>         $ git-format-patch -s -k -n master
>         001-aaa.patch
>         002-bbb.patch
>         [...]
>         006-fff.patch
> 
> Then I submit these patches for reviewing. Unfortunately, they're not perfect,
> so after some feedbacks from the communauty it appears that I need to make
> small modifications in the second commit in the topic branch for example...
> 
> What is the best and fastest way to do that ? Should I create a new topic branch
> and cherry pick from the old one ?
> 

It really depends on what the problem is. If it's a thinko in the design 
I usually find it worth keeping to avoid falling in the same trap again. 
  I do the same for bugfixes, although some don't like that (I'm lazy, 
they're anal). In this case, patches go on top of topic. Typos and stuff 
can usually be changed inside the patch-file, in which case you can just 
apply them to a new topic-branch.

It all boils down to how lazy you are, how much of your f***ups you want 
to preserve (they *are* useful sometimes) and what you prefer, really.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
