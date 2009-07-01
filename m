From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 1/2] git-send-email.perl: Don't add header "In-Reply-To:" when --no-chain-reply-to set
Date: Wed, 1 Jul 2009 18:59:59 +0200
Message-ID: <200907011900.00131.markus.heidelberg@web.de>
References: <cover.1246404999.git.joe@perches.com> <200907010818.57050.markus.heidelberg@web.de> <1246429653.6259.111.camel@Joe-Laptop.home>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 19:00:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MM3AV-0000sF-VR
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 19:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977AbZGARAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 13:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753496AbZGARAF
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 13:00:05 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:51125 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456AbZGARAE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 13:00:04 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id C0D931065BAC8;
	Wed,  1 Jul 2009 18:59:28 +0200 (CEST)
Received: from [89.59.114.130] (helo=.)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MM39c-000635-00; Wed, 01 Jul 2009 18:59:28 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1246429653.6259.111.camel@Joe-Laptop.home>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18zXbdUHjn/CCyAHUqwKDEGhhdnRVqBXYPjpxc3
	1VzFGpojAlUTk0K7K4pYH2tqLao/JagMJOhAH2x4bNGetoI9Ms
	AvTK2bY9TaEkG3FRjdAg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122584>

Joe Perches, 01.07.2009:
> On Wed, 2009-07-01 at 08:18 +0200, Markus Heidelberg wrote:
> > Joe Perches, 01.07.2009:
> > > using
> > >   git format-patch --thread=shallow -o <foo>
> > > and
> > >   git send-email --no-thread --no-chain-reply-to <foo>
> > 
> > I guess you meant --thread here.
> 
> Actually, I did mean --no-thread.

But --no-thread doesn't duplicate, --thread does.

According to the last line of your patch, you are using an old version
1.6.3.1. After this version two threading bugs were fixed, so you may
encounter a wrong behaviour with your old version.

> If format-patch does the threading, send-email shouldn't.

If the user wants format-patch to do the threading, he shouldn't want
send-email to do it as well.

Markus
