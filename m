From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: gitk pays too much attention to file timestamps
Date: Wed, 7 Apr 2010 01:15:27 +0200
Message-ID: <201004070115.27285.markus.heidelberg@web.de>
References: <l2hc6c947f61004061557x8085600fif5e973077d9eb4f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexander Gladysh <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 01:13:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzHxa-00007C-Le
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 01:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757637Ab0DFXN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 19:13:26 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:44977 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757084Ab0DFXNY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 19:13:24 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id B22F015520ABB;
	Wed,  7 Apr 2010 01:13:23 +0200 (CEST)
Received: from [91.19.11.36] (helo=pluto.localnet)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #4)
	id 1NzHxT-0001kE-00; Wed, 07 Apr 2010 01:13:23 +0200
User-Agent: KMail/1.12.4 (Linux/2.6.30-gentoo-r8; KDE/4.3.5; i686; ; )
In-Reply-To: <l2hc6c947f61004061557x8085600fif5e973077d9eb4f3@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX195lf4YedJQjFJNJJr0iK+IG6z9odtj070jGqE8
	y4kQEJgTy2f16z7kFlVx+4xtfbIUbgNQS9NayYJlA3LbxKjQ43
	rI2j2pRr983xccDVX5tw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144177>

Alexander Gladysh, 2010-04-07 00:57:
> Hi, list!
> 
> OS X 10.6.3
> Git 1.7.0.4
> 
> When I "touch" a file, gitk lists it in "local uncommitted changes,
> not checked in to index" (without a difference, just a name). I
> believe that it should not.
> 
> Git status, and git commit do ignore such files.
> 
> After git reset --hard, gitk stops seeing changes as expected.

The problem is that gitk doesn't invoke "git update-index --refresh",
I guess it should on Update (F5) and Reload (Ctrl-F5).

Markus
