From: David Greaves <david@dgreaves.com>
Subject: Re: How to add new tree?
Date: Thu, 12 May 2005 13:03:15 +0100
Message-ID: <42834603.1080604@dgreaves.com>
References: <200505121544.23902.snake@penza-gsm.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 13:56:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWCIF-000319-AX
	for gcvg-git@gmane.org; Thu, 12 May 2005 13:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVELMDc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 08:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVELMDc
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 08:03:32 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:18619 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261498AbVELMD1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2005 08:03:27 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 2ABCBE6DBF; Thu, 12 May 2005 13:02:07 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 12059-14; Thu, 12 May 2005 13:02:07 +0100 (BST)
Received: from oak.dgreaves.com (unknown [217.135.145.229])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 97C46E6D67; Thu, 12 May 2005 13:02:06 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DWCPL-0004FR-HQ; Thu, 12 May 2005 13:03:15 +0100
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Alexey Nezhdanov <snake@penza-gsm.ru>
In-Reply-To: <200505121544.23902.snake@penza-gsm.ru>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Alexey Nezhdanov wrote:

>Hello.
>Probably a lame question but I can figure out how to add new directory to repo 
>neither with cogito nor with git.
>
>a simple example:
>=========
>$mkdir newdir
>$cg-add newdir
>cg-add: newdir does not exist
>$
>==========
>How can this be resolved?
>
>  
>
git (and so cogito) manage content.
Directories have no content

Add a file within it
cg-add newdir/file

and it will create a tree as needed.

David

-- 

