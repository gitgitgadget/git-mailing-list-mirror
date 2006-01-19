From: Mathias Waack <Mathias.Waack@rantzau.de>
Subject: Re: Joining Repositories
Date: Thu, 19 Jan 2006 12:36:58 +0100
Organization: IFU
Message-ID: <200601191236.58725.Mathias.Waack@rantzau.de>
References: <200601181325.59832.Mathias.Waack@rantzau.de> <200601181501.38791.Mathias.Waack@rantzau.de> <20060118141442.GP28365@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jan 19 12:38:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzY7M-0002yh-Im
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 12:38:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161166AbWASLiN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 06:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161187AbWASLiN
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 06:38:13 -0500
Received: from mail1.Rantzau.de ([193.100.124.142]:52953 "EHLO
	mail1.Rantzau.de") by vger.kernel.org with ESMTP id S1161166AbWASLiN
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2006 06:38:13 -0500
Received: from [172.28.19.207] (helo=[192.168.48.128])
	by mail1.Rantzau.de with asmtp (TLSv1:RC4-MD5:128)
	(some SMTP-Gateway)
	id 1EzY74-0000gm-00
	for git@vger.kernel.org; Thu, 19 Jan 2006 12:37:59 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.7.2
In-Reply-To: <20060118141442.GP28365@pasky.or.cz>
Content-Disposition: inline
X-Scanner: exiscan *1EzY74-0000gm-00*opmz9xU.GVg* (Rantzau ///// Gruppe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14899>

Hello Petr, 

On Wednesday 18 January 2006 03:14 pm, Petr Baudis wrote:
> > ...git-read-tree doesn't know the parameter --prefix (just downloaded and
> > tried it on 0.99.9i). What version shall I use?
>
>   oops, it seems this is only in the latest pu branch of git. If you are
> not brave enough for that, 

I think I am;) 

> you will need to use the prefix facility of 
> checkout-index instead, and it'll take much longer:
>
> 	git-read-tree $commit
> 	git-checkout-index -a --prefix=r1/
> 	rm .git/index
> 	cg-add -r r1/
> 	rm -rf r1
> 	.. then proceed with git-cat-file etc ..

Time doesn't matter (in this case). This solution seems to work. 

>   Note that I'm not sure when which feature was introduced. Your best
> bet is to just use the latest stable GIT/Cogito versions.

Thanks for your suggestions, I've got a working solution. Now I'm going to 
spend the remaining days of this week by trying to understand why it works. 

Mathias
