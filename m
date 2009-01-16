From: "Anders Melchiorsen" <mail@cup.kalibalik.dk>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit 
     state
Date: Fri, 16 Jan 2009 11:27:46 +0100 (CET)
Message-ID: <49548.bFoQE3daRhY=.1232101666.squirrel@webmail.hotelhot.dk>
References: <87ab9th0rh.fsf@cup.kalibalik.dk>
    <8035E52E-D202-4C42-BDFD-DC7A925580A3@wincent.com>
    <76718490901151226l704d119bh297db4e91a4da05b@mail.gmail.com>
    <200901161050.13971.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Jay Soffian" <jaysoffian@gmail.com>,
	"Wincent Colaiuta" <win@wincent.com>,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Sverre Rabbelier" <srabbelier@gmail.com>,
	"Johannes Sixt" <j.sixt@viscovery.net>
To: "Johan Herland" <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Jan 16 11:29:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNlxY-0001gE-KQ
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 11:29:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758228AbZAPK22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 05:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757462AbZAPK21
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 05:28:27 -0500
Received: from mail.hotelhot.dk ([77.75.163.100]:42740 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756787AbZAPK21 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 05:28:27 -0500
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id D95EC30B1F;
	Fri, 16 Jan 2009 11:27:46 +0100 (CET)
Received: from webmail.hotelhot.dk (mail.hotelhot.dk [192.168.0.190])
	by mail.hotelhot.dk (Postfix) with ESMTP id A416930AFF;
	Fri, 16 Jan 2009 11:27:46 +0100 (CET)
X-Squirrel-UserHash: NQYRRTwcNktTVUlTWFZaWRRVWg==
X-Squirrel-FromHash: bFoQE3daRhY=
In-Reply-To: <200901161050.13971.johan@herland.net>
User-Agent: SquirrelMail/1.4.13
X-Priority: 3 (Normal)
Importance: Normal
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105935>

Johan Herland wrote:

> 	edit e8902c1 Foo
>
> we should consider something like
>
> 	pick e8902c1 Foo
> 	halt

Of all the suggestions, I like this one the most. Also, when placed like
this, I am suddenly no longer opposed to the word "halt".


> 	amend e8902c1 Foo
>
> does a "pick" followed by "commit --amend" (for editing the commit
> message), followed by "rebase --continue".

I do not think that "amend" is the best word for editing only the commit
message. A "commit --amend" can also make a new tree, so reusing the word
with a different meaning could be bad.

As for alternatives, however, I can only come up with "copyedit", and that
is so horrible that I will not even propose it :-)


Cheers,
Anders.
