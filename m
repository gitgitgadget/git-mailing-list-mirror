From: David Kastrup <dak@gnu.org>
Subject: Re: Help a sed noob
Date: Sat, 04 Aug 2007 16:06:22 +0200
Message-ID: <85abt7gzs1.fsf@lola.goethe.zz>
References: <fcaeb9bf0708031622w25ab6e9ev61372169cfc0bd98@mail.gmail.com>
	<20070804103126.GA28402@lapse.madduck.net>
	<20070804115003.GA9716@coredump.intra.peff.net>
	<20070804121811.GA1605@lapse.madduck.net>
	<46B4705D.2010208@fs.ei.tum.de>
	<20070804135630.GC1605@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Sat Aug 04 16:06:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHKGy-0005nB-3b
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 16:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761409AbXHDOGZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 10:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760778AbXHDOGZ
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 10:06:25 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:59869 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759392AbXHDOGY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2007 10:06:24 -0400
Received: from mail-in-07-z2.arcor-online.net (mail-in-07-z2.arcor-online.net [151.189.8.19])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 2848131F124;
	Sat,  4 Aug 2007 16:06:23 +0200 (CEST)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-07-z2.arcor-online.net (Postfix) with ESMTP id 054D22C6A17;
	Sat,  4 Aug 2007 16:06:23 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-010-037.pools.arcor-ip.net [84.61.10.37])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id B9C062BAA21;
	Sat,  4 Aug 2007 16:06:22 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 208381C4F932; Sat,  4 Aug 2007 16:06:22 +0200 (CEST)
In-Reply-To: <20070804135630.GC1605@lapse.madduck.net> (martin f. krafft's message of "Sat\, 4 Aug 2007 15\:56\:30 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3854/Sat Aug  4 06:49:48 2007 on mail-in-05.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54851>

martin f krafft <madduck@madduck.net> writes:

> also sprach Simon 'corecode' Schubert <corecode@fs.ei.tum.de> [2007.08.04.1426 +0200]:
>> s// is "match last regexp, so s/// is "match last regexp and replace with 
>> empty string.
>
> This fact is not in the manpage, AFAICT, at least not on Debian
> systems.

IIRC, this is a traditional _ed_ feature.  I don't think it has ever
been a traditional part of _sed_, but maybe some implementations have
adopted this usage.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
