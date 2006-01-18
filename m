From: Mathias Waack <Mathias.Waack@rantzau.de>
Subject: Re: Joining Repositories
Date: Wed, 18 Jan 2006 15:01:38 +0100
Organization: IFU
Message-ID: <200601181501.38791.Mathias.Waack@rantzau.de>
References: <200601181325.59832.Mathias.Waack@rantzau.de> <20060118125158.GN28365@pasky.or.cz> <20060118125857.GO28365@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jan 18 15:02:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzDsx-0006mL-ON
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 15:02:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbWAROB7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 09:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030228AbWAROB7
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 09:01:59 -0500
Received: from mail1.Rantzau.de ([193.100.124.142]:35457 "EHLO
	mail1.Rantzau.de") by vger.kernel.org with ESMTP id S1030226AbWAROB7
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 09:01:59 -0500
Received: from [172.28.19.207] (helo=[192.168.48.128])
	by mail1.Rantzau.de with asmtp (TLSv1:RC4-MD5:128)
	(some SMTP-Gateway)
	id 1EzDsg-0006RY-00
	for git@vger.kernel.org; Wed, 18 Jan 2006 15:01:46 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.7.2
In-Reply-To: <20060118125857.GO28365@pasky.or.cz>
Content-Disposition: inline
X-Scanner: exiscan *1EzDsg-0006RY-00*qwFGxa5ndEA* (Rantzau ///// Gruppe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14825>

Hello Petr, 

thanks for your quick answer, but...

On Wednesday 18 January 2006 01:58 pm, Petr Baudis wrote:
> Dear diary, on Wed, Jan 18, 2006 at 01:51:58PM CET, I got a letter
> where Petr Baudis <pasky@suse.cz> said that...
>
> >   But if you want r1/a, r2/b to turn to r/r1/a, r/r2/b, you will have
> > to rewrite the history of each (and then do the above). One rough
> > and untested sketch...
> >
> > 	mkdir r1-rewritten
> > 	cd r1-rewritten
> > 	cp -a ../r1/.git .
>
> 	mkdir commitmap
>
> > 	for commit in $(git-rev-list --topo-order HEAD | tac); do
> > 		git-read-tree --prefix=r1/ $commit

...git-read-tree doesn't know the parameter --prefix (just downloaded and 
tried it on 0.99.9i). What version shall I use?

Mathias
