From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: how to hide some branches
Date: Sun, 30 Nov 2008 12:09:33 -0800
Message-ID: <4932F2FD.9030603@pcharlan.com>
References: <493261C9.4040608@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Sun Nov 30 21:10:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6sd2-0003Ne-Dv
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 21:10:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbYK3UJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 15:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752834AbYK3UJf
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 15:09:35 -0500
Received: from lax-green-bigip-5.dreamhost.com ([208.113.200.5]:59507 "EHLO
	swarthymail-a4.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752786AbYK3UJe (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Nov 2008 15:09:34 -0500
Received: from [192.168.0.101] (031.132-78-65.ftth.swbr.surewest.net [65.78.132.31])
	by swarthymail-a4.g.dreamhost.com (Postfix) with ESMTP id E057E129A83;
	Sun, 30 Nov 2008 12:09:33 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081125)
In-Reply-To: <493261C9.4040608@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101984>

Pascal Obry wrote:
> Hello everyone,
> 
> I create a new branch for every new feature/fix I work on. After some
> time I have many (too much) branch listed when doing:
> 
>    $ git branch
> 
> I'd like to hide some (not removing them).
> 
> Is there a solution for this?

>From a suggestion by Jakub Narebski, I use an alias "lb" that shows
the most recently-active 8 branches:

  for-each-ref --format='%(refname:short)' \
       --sort=-authordate --count=8 refs/heads/

--Pete
