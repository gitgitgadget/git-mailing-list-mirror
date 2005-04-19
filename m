From: David Greaves <david@dgreaves.com>
Subject: Re: Change "pull" to _only_ download, and "git update"=pull+merge?
Date: Tue, 19 Apr 2005 10:18:55 +0100
Message-ID: <4264CCFF.30400@dgreaves.com>
References: <20050416233305.GO19099@pasky.ji.cz> <Pine.LNX.4.21.0504161951160.30848-100000@iabervon.org> <20050419011206.GT5554@pasky.ji.cz> <42646967.9030903@dwheeler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 11:15:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNoop-0006ZW-1p
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 11:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVDSJTA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 05:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVDSJS7
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 05:18:59 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:12180 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261413AbVDSJS5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 05:18:57 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id EAA47E6D6F; Tue, 19 Apr 2005 10:17:19 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 08104-20; Tue, 19 Apr 2005 10:17:19 +0100 (BST)
Received: from oak.dgreaves.com (modem-2094.lemur.dialup.pol.co.uk [217.135.136.46])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 4E030E6D64; Tue, 19 Apr 2005 10:17:19 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DNosh-0006EA-CK; Tue, 19 Apr 2005 10:18:55 +0100
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
To: dwheeler@dwheeler.com
In-Reply-To: <42646967.9030903@dwheeler.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David A. Wheeler wrote:
> I propose changing "pull" to ONLY download, and "update" to pull AND merge.

> Why? It seems oddly inconsistent that "pull" sometimes merges
> in changes, but at other times it doesn't.
true

> I propose that there be two subcommands, "pull" and "update"
> (now that "update" isn't a reserved word again).
> A "git pull" ONLY downloads; a "git update" pulls AND merges.

What's the most common thing to do? pull or update?
which is easier to type?
what are people used to?

I'm not sure but I suggest that pull and get would be better choices.

git pull
git get

is it rare enough to justify:
git --download-only pull


David

-- 
