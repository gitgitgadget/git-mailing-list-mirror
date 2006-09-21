From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 1/2] gitweb: Always use git-peek-remote in git_get_references
Date: Thu, 21 Sep 2006 11:07:35 +0200
Message-ID: <45125657.4010001@op5.se>
References: <200609191430.51252.jnareb@gmail.com> <200609191431.49641.jnareb@gmail.com> <7v64fijz90.fsf@assigned-by-dhcp.cox.net> <200609202013.38457.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 11:08:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQKXD-0000Di-BS
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 11:07:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWIUJHj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 05:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWIUJHj
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 05:07:39 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:58591 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751077AbWIUJHh
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 05:07:37 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id 42C636BD3F; Thu, 21 Sep 2006 11:07:36 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00 autolearn=ham 
	version=3.1.4
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 4D4196BCF1; Thu, 21 Sep 2006 11:07:35 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200609202013.38457.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27467>

Jakub Narebski wrote:
> 
> If there were post-commit hook, and it's contents was the default 
> post-update hook, info/refs would be never stale. And we could read
> from into/refs, and fallback to git-peek-remote if it doesn't exist...
> but we don't know if info/refs has current info.

ls -l .git/hooks/post-commit
-rw-r----- 1 exon exon 152 Sep 21 10:54 .git/hooks/post-commit


My post-update hook doesn't maintain info/refs for me. I'm sure that if 
someone set it up to do so they would also set the post-commit hook up 
to do the same.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
