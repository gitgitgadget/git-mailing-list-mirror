From: Franck Bui-Huu <franck.bui-huu@innova-card.com>
Subject: Re: git rebase conflict help?
Date: Fri, 18 Nov 2005 09:04:28 +0100
Organization: Innova Card
Message-ID: <437D8B0C.3010608@innova-card.com>
References: <33D6F7FB-7864-471B-A111-9991C768577A@desertsol.com>
Reply-To: franck.bui-huu@innova-card.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 09:10:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ed1GT-0002eP-Ra
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 09:06:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbVKRIGP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 03:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932610AbVKRIGP
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 03:06:15 -0500
Received: from smtp9.clb.oleane.net ([213.56.31.31]:12695 "EHLO
	smtp9.clb.oleane.net") by vger.kernel.org with ESMTP
	id S932511AbVKRIGO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 03:06:14 -0500
Received: from smtp.innova-card.com ([194.3.162.233]) (authenticated)
	by smtp9.clb.oleane.net with ESMTP id jAI85Z20020672;
	Fri, 18 Nov 2005 09:05:39 +0100
Received: by smtp.innova-card.com (Postfix, from userid 100)
	id F24F83800B; Fri, 18 Nov 2005 09:05:30 +0100 (CET)
Received: from [192.168.0.24] (spoutnik.innova-card.com [192.168.0.24])
	by smtp.innova-card.com (Postfix) with ESMTP
	id B61923800A; Fri, 18 Nov 2005 09:05:30 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Kevin Geiss <kevin@desertsol.com>
In-Reply-To: <33D6F7FB-7864-471B-A111-9991C768577A@desertsol.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12214>

Kevin Geiss wrote:

> I fetched my origin branch, then tried to run 'git rebase origin'.  
> one of my commits from master which is not yet in origin got a  
> conflict, so git rebase origin told me that the Simple cherry-pick  
> failed, and the Automatic cherry-pick got conflicts. and it saved the  
> commit message for me in .msg and my offending commit's id in .rebase- 
> tmp32409.
>
> I'm not sure how to proceed from here. actually, I know what the  
> offending changes are, and I could re-do the changes by hand and  
> commit them again, but I'd like to know what git tools I'm supposed  
> to use in this case...
>
You can take a look at this:
http://www.gelato.unsw.edu.au/archives/git/0508/7789.html

              Franck
