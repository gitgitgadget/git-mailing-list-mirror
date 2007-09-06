From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 1/7] Rework strbuf API and semantics.
Date: Thu, 06 Sep 2007 16:43:36 +0200
Message-ID: <85bqcfdfc7.fsf@lola.goethe.zz>
References: <20070902224213.GB431@artemis.corp>
	<11890776114037-git-send-email-madcoder@debian.org>
	<118907761140-git-send-email-madcoder@debian.org>
	<Pine.LNX.4.64.0709061506330.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 06 16:44:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITIaC-0000ds-87
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 16:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754159AbXIFOnl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 10:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754012AbXIFOnl
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 10:43:41 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:46680 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753876AbXIFOnk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2007 10:43:40 -0400
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 8B03C1F5BA6;
	Thu,  6 Sep 2007 16:43:39 +0200 (CEST)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id 6CBB123D320;
	Thu,  6 Sep 2007 16:43:39 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-055-071.pools.arcor-ip.net [84.61.55.71])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 1F3B01C3684;
	Thu,  6 Sep 2007 16:43:39 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id BBC7C1CAD71B; Thu,  6 Sep 2007 16:43:36 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0709061506330.28586@racer.site> (Johannes Schindelin's message of "Thu\, 6 Sep 2007 15\:09\:28 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4170/Thu Sep  6 06:30:09 2007 on mail-in-05.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57884>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> let me thank you for this very nicely done patch series.  Except for 5/7, 
> they look pretty much obvious changes to me.  I'll review that in detail 
> later.
>
> On Thu, 6 Sep 2007, Pierre Habouzit wrote:
>
>> +#define STRBUF_INIT  { 0, 0, 0, NULL }
>
> Would not "struct strbuf sb = { 0 };" have the same effect?  (I am not so 
> standards-keen as other people, who I have no doubt will gladly answer 
> this one.)

AFAIR, non-specified static memory areas are initialized to zero bits,
and NULL resp (void *)0 is not guaranteed to be represented by zero
bits.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
