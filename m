From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Need to change old commit (and regenerate tree)
Date: Fri, 21 May 2010 00:09:19 +0200
Message-ID: <m2sk5mtecw.fsf@igel.home>
References: <AANLkTilTAknKPFv5AZBrwsITPsRlVSnsuX8TDXlUTWmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Antriksh Pany <antriksh.pany@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 21 00:09:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFDvk-0000WG-IX
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 00:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755109Ab0ETWJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 18:09:23 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:34497 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754945Ab0ETWJW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 18:09:22 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 429291C002BD;
	Fri, 21 May 2010 00:09:21 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 3E6B690226;
	Fri, 21 May 2010 00:09:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan1.mnet-online.de [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id Np4qSJpVBfdF; Fri, 21 May 2010 00:09:20 +0200 (CEST)
Received: from igel.home (ppp-88-217-96-104.dynamic.mnet-online.de [88.217.96.104])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Fri, 21 May 2010 00:09:20 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 27A2ECA297; Fri, 21 May 2010 00:09:20 +0200 (CEST)
X-Yow: By MEER biz doo SCHOIN..
In-Reply-To: <AANLkTilTAknKPFv5AZBrwsITPsRlVSnsuX8TDXlUTWmw@mail.gmail.com>
	(Antriksh Pany's message of "Thu, 20 May 2010 20:17:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147416>

Antriksh Pany <antriksh.pany@gmail.com> writes:

> Instead of (what I initially expected):
>
> A--------o--------o--------o--------o(old B)--------o--------o--------o(old C)
>
> A2--------o--------o--------o--------B--------o--------o--------C
>
>
> So what I am missing here? Aren't the new commits B~1, B~2, B~3
> identical to C~4, C~5, C~6 (respectively) in all ways so as to have
> gotten them the same SHA1 and hence appear as what I expected them to
> appear?

No, they have a different commit time, which is also part of the hash.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
