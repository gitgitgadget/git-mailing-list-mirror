From: David Kastrup <dak@gnu.org>
Subject: Re: Shell script cleanups/style changes?
Date: Fri, 03 Aug 2007 08:06:02 +0200
Message-ID: <85lkctw3sl.fsf@lola.goethe.zz>
References: <86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<85odhpzmbo.fsf@lola.goethe.zz>
	<7vsl71tyyq.fsf@assigned-by-dhcp.cox.net>
	<86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<85odhpzmbo.fsf@lola.goethe.zz>
	<20070802214103.GT29424@schiele.dyndns.org>
	<85vebxy47e.fsf@lola.goethe.zz>
	<7vwswdsfjp.fsf@assigned-by-dhcp.cox.net>
	<85ps25y1ac.fsf@lola.goethe.zz>
	<7vk5sdscfr.fsf@assigned-by-dhcp.cox.net>
	<85wswdwjll.fsf@lola.goethe.zz>
	<7vabt9sasl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Schiele <rschiele@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 08:06:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGqIp-0002TQ-Hi
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 08:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755551AbXHCGGO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 02:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755382AbXHCGGO
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 02:06:14 -0400
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:52324 "EHLO
	mail-in-11.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753986AbXHCGGL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Aug 2007 02:06:11 -0400
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id 2D31812FEC;
	Fri,  3 Aug 2007 08:06:10 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id 18557212FA9;
	Fri,  3 Aug 2007 08:06:10 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-000-210.pools.arcor-ip.net [84.61.0.210])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id CD8A536E863;
	Fri,  3 Aug 2007 08:06:09 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id A2A621C4F931; Fri,  3 Aug 2007 08:06:02 +0200 (CEST)
In-Reply-To: <7vabt9sasl.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Thu\, 02 Aug 2007 17\:48\:26 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54671>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>>> I happen to feel ${parameter#word} is more esoteric than $(cmd).
>>> If a system does not even do the latter, then avoiding the
>>> former to help such a system is a futile effort.
>>
>> The situation is that we currently don't avoid the former.  Robert
>> said that he had prepared a patch that would do so.
>> ...
>> But "only a little bit of ${parameter#word}, please" seems pointless.
>
> Absolutely.  And we started to adopt #/% substititions some time
> ago.  Undoing them just feels going backwards, and we need to judge
> what the merits of going backwards are.

Ok, seems like the sort of cleanups I proposed would not clash with
current git policies.  I'll readily agree that the timing of their
adoption might not really fit with a rc4, but posting them for the
queue does not seem outrageous.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
