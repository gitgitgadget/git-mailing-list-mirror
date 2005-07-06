From: John Ellson <ellson@research.att.com>
Subject: Re: BUG: cg-clone accepts '_' in git_ssh: URI's, but cg-push does
 not.
Date: Wed, 06 Jul 2005 14:26:04 -0400
Message-ID: <42CC223C.90706@research.att.com>
References: <john.ellson@comcast.net> <200507061658.j66Gw7Me014155@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 06 20:28:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqEbm-00059E-8q
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 20:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbVGFS03 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 14:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbVGFS03
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 14:26:29 -0400
Received: from mail-dark.research.att.com ([192.20.225.112]:38829 "EHLO
	mail-yellow.research.att.com") by vger.kernel.org with ESMTP
	id S262170AbVGFS0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 14:26:16 -0400
Received: from [135.207.24.103] (ellson.research.att.com [135.207.24.103])
	by bigmail.research.att.com (8.13.3+Sun/8.11.6) with ESMTP id j66IUkY2023162;
	Wed, 6 Jul 2005 14:30:47 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0.2-7 (X11/20050623)
X-Accept-Language: en-us, en
Newsgroups: gmane.comp.version-control.git
To: Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: <200507061658.j66Gw7Me014155@laptop11.inf.utfsm.cl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Horst von Brand wrote:
> John Ellson <john.ellson@comcast.net> wrote:
> 
>>BUG: cg-clone accepts '_' in git+ssh: URI's, but cg-push does not.
> 
> 
> Right. '_' is illegal in domain names...


OK, but its legal in the path part of URI's, I believe, and I'm more 
bothered by the assymetry between cg-clone and cg-push.  It allowed me 
to clone a project but not to push updates back.

I was experimenting with git+ssh between two machines locally using:

  git+ssh://ontap/home/ellson/FIX/Linux.x86_64/build/cogito/.git

John
