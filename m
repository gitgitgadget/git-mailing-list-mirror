From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC] Clean way to disable pager
Date: Mon, 20 Aug 2007 00:37:10 +0200
Message-ID: <85ps1jp2w9.fsf@lola.goethe.zz>
References: <vpq1wdz307k.fsf@bauges.imag.fr>
	<7vodh3bbmx.fsf@gitster.siamese.dyndns.org>
	<vpq643bz4vx.fsf@bauges.imag.fr>
	<325563A3-050A-4830-9ACB-9ED15322F038@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 00:37:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMtOi-0005H5-Kb
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 00:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268AbXHSWhY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 18:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751581AbXHSWhX
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 18:37:23 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:55853 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751188AbXHSWhX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Aug 2007 18:37:23 -0400
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id C5AA497BA4;
	Mon, 20 Aug 2007 00:37:21 +0200 (CEST)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by mail-in-05-z2.arcor-online.net (Postfix) with ESMTP id 7BAF32DABE0;
	Mon, 20 Aug 2007 00:37:21 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-025-172.pools.arcor-ip.net [84.61.25.172])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 48E66312764;
	Mon, 20 Aug 2007 00:37:13 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id E610A1C36605; Mon, 20 Aug 2007 00:37:10 +0200 (CEST)
In-Reply-To: <325563A3-050A-4830-9ACB-9ED15322F038@apple.com> (Adam Roben's message of "Sun\, 19 Aug 2007 14\:59\:16 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/4004/Sun Aug 19 22:38:24 2007 on mail-in-03.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56157>

Adam Roben <aroben@apple.com> writes:

> On Aug 19, 2007, at 12:44 PM, Matthieu Moy wrote:
>
>> +    [-p|--paginate] [--no-pager]
>
>   I think that [-p|--[no-]paginate] would be more consistent with the
> way negatable options are normally specified.

Disregard previously existing code, I'd vote for using an option set
like the following:

--pager
--pager=less
--pager=cat
--no-pager

"--paginate" is rather artificial in contrast.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
