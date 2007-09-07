From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and make stat use that implementation too.
Date: Fri, 07 Sep 2007 08:36:08 +0200
Message-ID: <85ir6n7zjb.fsf@lola.goethe.zz>
References: <46DACD93.9000509@trolltech.com>
	<200709022228.00733.robin.rosenberg.lists@dewire.com>
	<Pine.LNX.4.64.0709022133190.28586@racer.site>
	<200709022342.42733.robin.rosenberg.lists@dewire.com>
	<46DBB2BE.8030505@eudaptics.com>
	 =?ISO-8859-1?Q?=20<20070903112110.?= =?ISO-8859-1?Q?GE148=0453@genesis?= =?ISO-8859-1?Q?.fruga?=
	=?ISO-8859-1?Q?lware.org>?=
	<86y7fohtmw.fsf@lola.quinscape.zz>
	<20070905160206.GY14853@genesis.frugalware.org>
	<85abs1hr6t.fsf@lola.goethe.zz>
	<20070906162657.GF2329@genesis.frugalware.org>
	<85bqcfbvpe.fsf@lola.goethe.zz> <46E08DE9.4060701@11011.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Douglas Stockwell <doug@11011.net>
X-From: git-owner@vger.kernel.org Fri Sep 07 08:36:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITXRy-0003X2-9e
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 08:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbXIGGgN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 02:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbXIGGgN
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 02:36:13 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:38935 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932342AbXIGGgM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Sep 2007 02:36:12 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 76D4131E7AE;
	Fri,  7 Sep 2007 08:36:11 +0200 (CEST)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 6A7212D3788;
	Fri,  7 Sep 2007 08:36:11 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-044-151.pools.arcor-ip.net [84.61.44.151])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 44F991BF3D9;
	Fri,  7 Sep 2007 08:36:11 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id E2E241CAD71B; Fri,  7 Sep 2007 08:36:08 +0200 (CEST)
In-Reply-To: <46E08DE9.4060701@11011.net> (Douglas Stockwell's message of "Fri\, 07 Sep 2007 08\:31\:53 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4175/Thu Sep  6 22:16:54 2007 on mail-in-04.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57987>

Douglas Stockwell <doug@11011.net> writes:

> David Kastrup wrote:
>> If anybody is as fortunate as to actually have Vista available, it
>> would be nice if he corroborated that relative links under Vista are
>> indeed (as Microsoft appears to claim) relative with regard to the
>> current work directory rather than the directory containing the link.
>
> I believe the wording "resolves the path relative to the current
> directory" actually refers to the creation of links, not to their use.
>
> C:\stest>ver
>
> Microsoft Windows [Version 6.0.6000]

[Examples]

Good.  So we will ultimately be able to support symlinks on some
Windows versions.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
