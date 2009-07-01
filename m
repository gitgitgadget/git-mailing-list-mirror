From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/2] git-send-email.perl: Don't add header
 "In-Reply-To:" when --no-chain-reply-to set
Date: Wed, 01 Jul 2009 10:25:15 -0700
Message-ID: <1246469115.28915.21.camel@Joe-Laptop.home>
References: <cover.1246404999.git.joe@perches.com>
	 <200907010818.57050.markus.heidelberg@web.de>
	 <1246429653.6259.111.camel@Joe-Laptop.home>
	 <200907011900.00131.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Wed Jul 01 19:25:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MM3Yo-0003qQ-26
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 19:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022AbZGARZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 13:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754873AbZGARZQ
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 13:25:16 -0400
Received: from 136-022.dsl.LABridge.com ([206.117.136.22]:2063 "EHLO
	mail.perches.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755309AbZGARZP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 13:25:15 -0400
Received: from [192.168.1.158] ([192.168.1.158])
	by mail.perches.com (8.9.3/8.9.3) with ESMTP id KAA30208;
	Wed, 1 Jul 2009 10:25:05 -0700
In-Reply-To: <200907011900.00131.markus.heidelberg@web.de>
X-Mailer: Evolution 2.26.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122586>

On Wed, 2009-07-01 at 18:59 +0200, Markus Heidelberg wrote:
> Joe Perches, 01.07.2009:
> > On Wed, 2009-07-01 at 08:18 +0200, Markus Heidelberg wrote:
> > > Joe Perches, 01.07.2009:
> > > > using
> > > >   git format-patch --thread=shallow -o <foo>
> > > > and
> > > >   git send-email --no-thread --no-chain-reply-to <foo>
> > > I guess you meant --thread here.
> > Actually, I did mean --no-thread.
> But --no-thread doesn't duplicate, --thread does.
> 
> According to the last line of your patch, you are using an old version
> 1.6.3.1. After this version two threading bugs were fixed, so you may
> encounter a wrong behaviour with your old version.

Great, I'm glad the bug was fixed already and apologies
for the noise, I don't generally track the git list.

Reading the archives, I see you're responsible, thanks.

cheers, Joe
