From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 1/2] gitweb: Show snapshot links for tree entries in tree listing
Date: Sat, 7 Oct 2006 18:04:24 -0700 (PDT)
Message-ID: <20061008010424.85913.qmail@web31812.mail.mud.yahoo.com>
References: <20061007191552.GG20017@pasky.or.cz>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 08 03:09:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWN5s-00066i-OW
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 03:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbWJHBEZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 21:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbWJHBEZ
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 21:04:25 -0400
Received: from web31812.mail.mud.yahoo.com ([68.142.207.75]:63320 "HELO
	web31812.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751842AbWJHBEY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Oct 2006 21:04:24 -0400
Received: (qmail 85915 invoked by uid 60001); 8 Oct 2006 01:04:24 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=dlp2m2j17J0Tkov4oj8I9VvHCZiN7/rWRnF8Kw2LC1aMn/rCfwmZDcxBPFhEpq14VEY8TMdHlZxK5AkD7Jvu732+7U52AEv0saQ/Xk7rg2oWbayrBN8gsK3a2fcSdpY4mtz+5hGt0y+zpvhgb9unGxpsM17uz7izZOLubApBhXM=  ;
Received: from [71.80.233.118] by web31812.mail.mud.yahoo.com via HTTP; Sat, 07 Oct 2006 18:04:24 PDT
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061007191552.GG20017@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28518>

--- Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Sat, Oct 07, 2006 at 08:52:53PM CEST, I got a letter
> where Luben Tuikov <ltuikov@yahoo.com> said that...
> > Another thing is that currently tree/directory entries' third (links)
> > column to be shortest of all, and this gives my eyes another indication
> > that this is a tree.
> 
> What would people think about first listing all the trees, then all the
> blobs? Just like LANG=C ls does, as well as cvsweb and overally most of
> the rest of the relevant world.

I don't like it and the reason is that when I'm searching for something
I expect the listing to be alphabetically sorted, period.
Not type-then-alphabetical, which is greatly distracting and only makes
me lose 3-10 seconds looking for the item I'm looking at.

Bunching up the directories at the top and then listing the files at
the bottom is one of those great annoyances.

But, if you do implement that, please make it configurable, because
I'll resort to the current listing order.

    Luben
