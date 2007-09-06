From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 1/7] Rework strbuf API and semantics.
Date: Thu, 06 Sep 2007 16:44:42 +0200
Message-ID: <857in3dfad.fsf@lola.goethe.zz>
References: <20070902224213.GB431@artemis.corp>
	<11890776114037-git-send-email-madcoder@debian.org>
	<118907761140-git-send-email-madcoder@debian.org>
	<Pine.LNX.4.64.0709061506330.28586@racer.site>
	<20070906142155.GB3002@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 06 16:45:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITIbQ-0001E4-OU
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 16:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754549AbXIFOot (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 10:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754012AbXIFOot
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 10:44:49 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:47050 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752359AbXIFOos (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2007 10:44:48 -0400
Received: from mail-in-13-z2.arcor-online.net (mail-in-13-z2.arcor-online.net [151.189.8.30])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 4EC7B31ED26;
	Thu,  6 Sep 2007 16:44:47 +0200 (CEST)
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net [151.189.21.50])
	by mail-in-13-z2.arcor-online.net (Postfix) with ESMTP id 3C5C41B8DFE;
	Thu,  6 Sep 2007 16:44:47 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-055-071.pools.arcor-ip.net [84.61.55.71])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id B28C026D362;
	Thu,  6 Sep 2007 16:44:42 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 4AEDC1CAD71B; Thu,  6 Sep 2007 16:44:42 +0200 (CEST)
In-Reply-To: <20070906142155.GB3002@coredump.intra.peff.net> (Jeff King's message of "Thu\, 6 Sep 2007 10\:21\:55 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4170/Thu Sep  6 06:30:09 2007 on mail-in-10.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57885>

Jeff King <peff@peff.net> writes:

> On Thu, Sep 06, 2007 at 03:09:28PM +0100, Johannes Schindelin wrote:
>
>> let me thank you for this very nicely done patch series.  Except for 5/7, 
>> they look pretty much obvious changes to me.  I'll review that in detail 
>> later.
>
> I second that; I am glad somebody is taking an interest in this area
> (though I haven't closely reviewed the patches yet).
>
>> > +#define STRBUF_INIT  { 0, 0, 0, NULL }
>> 
>> Would not "struct strbuf sb = { 0 };" have the same effect?  (I am not so 
>> standards-keen as other people, who I have no doubt will gladly answer 
>> this one.)
>
> Yes, it would, according to the standard.

Have a citation for that?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
