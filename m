From: David Greaves <david@dgreaves.com>
Subject: Re: Why /usr/bin/env in scripts
Date: Mon, 25 Apr 2005 10:42:45 +0100
Message-ID: <426CBB95.9040203@dgreaves.com>
References: <426C9E63.4050907@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 11:38:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ02G-0007Em-5t
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 11:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262559AbVDYJmt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 05:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbVDYJmt
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 05:42:49 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:50885 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262559AbVDYJmr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 05:42:47 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 5EA02E6D7B; Mon, 25 Apr 2005 10:40:33 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 25655-02; Mon, 25 Apr 2005 10:40:33 +0100 (BST)
Received: from oak.dgreaves.com (modem-1721.lemur.dialup.pol.co.uk [217.135.134.185])
	by mail.ukfsn.org (Postfix) with ESMTP
	id C72E3E6D63; Mon, 25 Apr 2005 10:40:32 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DQ073-0002am-Ts; Mon, 25 Apr 2005 10:42:45 +0100
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
To: Philip Pokorny <ppokorny@mindspring.com>
In-Reply-To: <426C9E63.4050907@mindspring.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Philip Pokorny wrote:
> I notice that the first line of the pasky shell scripts is
> 
> #!/usr/bin/env bash

> So what am I missing?  Is this a portability aid?
man env:

The first remaining argument specifies the program name to invoke;
it is searched for according to the `PATH' environment variable.  Any
remaining arguments are passed as arguments to that program.

It's a trick to do a PATH search for a script interpreter rather than 
hard coding the path.
Now all we have to do is make sure every distro on the planet has 
/usr/bin/env - and they do.

David
