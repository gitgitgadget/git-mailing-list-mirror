From: David Greaves <david@dgreaves.com>
Subject: Re: Add + Status patches
Date: Mon, 18 Apr 2005 23:18:12 +0100
Message-ID: <42643224.60407@dgreaves.com>
References: <42641AE4.9050700@dgreaves.com> <7v64yju7er.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 00:15:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNeVp-0007zv-7D
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 00:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVDRWSg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 18:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVDRWSg
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 18:18:36 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:32412 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261193AbVDRWSO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 18:18:14 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id C1D1FE6D81; Mon, 18 Apr 2005 23:16:39 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 08274-11; Mon, 18 Apr 2005 23:16:39 +0100 (BST)
Received: from oak.dgreaves.com (modem-3514.leopard.dialup.pol.co.uk [217.135.157.186])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 2ED96E6D7A; Mon, 18 Apr 2005 23:16:39 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DNeZI-0005KP-Jh; Mon, 18 Apr 2005 23:18:12 +0100
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64yju7er.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

>DG> It allows:
>DG>  find src -type f | git add -
>
>I am slow today, but have you considered using xargs?
>
>  
>
yep thanks :)
I know you _could_ do it with xargs - but you _could_ use the raw git 
commands too. This is a "be nice to the user" layer and I was 
'surprised' that neither
git add .
nor
git add -r .
worked.

That meant that I had to fix it so I started with the ability to handle 
a list and, since I got a friendly response, I can hopefully move on to 
help make git nicer to use for mere mortals.

David
