From: Kristian Amlie <kristian.amlie@nokia.com>
Subject: Re: How can i find the origin of a branch?
Date: Mon, 15 Jun 2009 15:10:34 +0200
Message-ID: <4A36484A.3040207@nokia.com>
References: <2f3bf9a60906150437v765c2cecva61307ae9cf0cec7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Cc: Dotan Barak <dotanba@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: ext Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 15:10:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGBxY-0000wa-26
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 15:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758644AbZFONKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 09:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757480AbZFONKe
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 09:10:34 -0400
Received: from hoat.troll.no ([62.70.27.150]:57500 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796AbZFONKd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 09:10:33 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 9563E20E3C;
	Mon, 15 Jun 2009 15:10:35 +0200 (CEST)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 8A1CE20BC3;
	Mon, 15 Jun 2009 15:10:35 +0200 (CEST)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id n5FDAZZD014670;
	Mon, 15 Jun 2009 15:10:35 +0200
Received: from [172.24.90.99] ( [172.24.90.99])
    by sx01.troll.no (Scalix SMTP Relay 11.4.1.11929)
    via ESMTP; Mon, 15 Jun 2009 15:10:35 +0200 (CEST)
In-Reply-To: <81b0412b0906150548m69abc1bax785a4743119804c6@mail.gmail.com>
References: <4A363741.9030604@nokia.com>
References: <81b0412b0906150548m69abc1bax785a4743119804c6@mail.gmail.com>
x-scalix-Hops: 1
User-Agent: Thunderbird 2.0.0.21 (X11/20090609)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121605>

ext Alex Riesen wrote:
> 2009/6/15 Kristian Amlie <kristian.amlie@nokia.com>:
>> ext Dotan Barak wrote:
>>> Is it possible to find the origin of a branch?
>>> (the remote repository that this branch was cloned and checked out from)
>> git config -l
>>
>> Assuming you're on the master branch, branch.master.remote and
>> branch.master.merge will tell you which remote and which branch you are
>> tracking. Assuming that the remote is origin, you can check
>> remote.origin.url to see the URL of the repo.
> 
> Except when it is just happen to have the same name.
> IOW, it is a BIG oversimplification.

Probably, but why make the simple case overcomplicated? It should give
you the answer in 90% of the cases.

--
Kristian
