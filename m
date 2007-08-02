From: David Kastrup <dak@gnu.org>
Subject: Re: Shell script cleanups/style changes?
Date: Fri, 03 Aug 2007 01:17:15 +0200
Message-ID: <85ps25y1ac.fsf@lola.goethe.zz>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Schiele <rschiele@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 01:17:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGjv6-0004tq-CW
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 01:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755622AbXHBXRZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 19:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755551AbXHBXRZ
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 19:17:25 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:38330 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755425AbXHBXRY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Aug 2007 19:17:24 -0400
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 0A4421F5520;
	Fri,  3 Aug 2007 01:17:23 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id E822B345C03;
	Fri,  3 Aug 2007 01:17:22 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-049-245.pools.arcor-ip.net [84.61.49.245])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id BEED636E867;
	Fri,  3 Aug 2007 01:17:22 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 107F21D0344E; Fri,  3 Aug 2007 01:17:15 +0200 (CEST)
In-Reply-To: <7vwswdsfjp.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Thu\, 02 Aug 2007 16\:05\:46 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54639>

Junio C Hamano <gitster@pobox.com> writes:

> However, there is a line we need to draw when bending bacwards for
> compatibility, and I think a system that does not have a working
> command substitution $( ... )  is on the other side of that line.

Not an issue.  But apparently, ${parameter#word} is for Solaris.  I'd
still like to get confirmation that it is indeed /bin/sh, but if it
is, the current code is not good for Solaris.

So the line of compatibility is much more interesting for this one.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
