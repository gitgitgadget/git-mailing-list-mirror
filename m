From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 1/7] Rework strbuf API and semantics.
Date: Thu, 06 Sep 2007 17:06:52 +0200
Message-ID: <85tzq7bzoz.fsf@lola.goethe.zz>
References: <20070902224213.GB431@artemis.corp>
	<11890776114037-git-send-email-madcoder@debian.org>
	<118907761140-git-send-email-madcoder@debian.org>
	<Pine.LNX.4.64.0709061506330.28586@racer.site>
	<20070906142155.GB3002@coredump.intra.peff.net>
	<857in3dfad.fsf@lola.goethe.zz>
	<20070906145035.GA3546@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 06 17:07:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITIx3-0000rT-Qw
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 17:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755025AbXIFPHA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 11:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755984AbXIFPHA
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 11:07:00 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:58966 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754947AbXIFPG6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2007 11:06:58 -0400
Received: from mail-in-06-z2.arcor-online.net (mail-in-06-z2.arcor-online.net [151.189.8.18])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id D1DE631F0FC;
	Thu,  6 Sep 2007 17:06:57 +0200 (CEST)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-06-z2.arcor-online.net (Postfix) with ESMTP id 90154ABAC1;
	Thu,  6 Sep 2007 17:06:57 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-055-071.pools.arcor-ip.net [84.61.55.71])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 2D6C08C463;
	Thu,  6 Sep 2007 17:06:53 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id C2D021CAD71B; Thu,  6 Sep 2007 17:06:52 +0200 (CEST)
In-Reply-To: <20070906145035.GA3546@coredump.intra.peff.net> (Jeff King's message of "Thu\, 6 Sep 2007 10\:50\:35 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4170/Thu Sep  6 06:30:09 2007 on mail-in-12.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57890>

Jeff King <peff@peff.net> writes:

> On Thu, Sep 06, 2007 at 04:44:42PM +0200, David Kastrup wrote:
>
>> >> Would not "struct strbuf sb = { 0 };" have the same effect?  (I am not so 
>> >> standards-keen as other people, who I have no doubt will gladly answer 
>> >> this one.)
>> >
>> > Yes, it would, according to the standard.
>> 
>> Have a citation for that?
>
> Of course.
>
> See ISO 9899:1999, section 6.7.8.
>
> Paragraph 10:
>
>   If an object that has automatic storage duration is not initialized
>   explicitly, its value is indeterminate. If an object that has static
>   storage duration is not initialized explicitly, then:
>
>   -- if it has pointer type, it is initialized to a null pointer;

That's actually a new one to me.  I don't think that it has been
always the case in ANSI C.

Thanks.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
