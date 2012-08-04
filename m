From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git cvsimport: new tags not imported on second cvsimport
Date: Sun, 05 Aug 2012 00:20:16 +0200
Message-ID: <m2lihuuwnz.fsf@igel.home>
References: <1123570348.20120804133108@gmail.com>
	<m2lihvt2gi.fsf@linux-m68k.org> <9510482012.20120804170149@gmail.com>
	<m2pq76vecd.fsf@igel.home> <7v7gte9una.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ilya Basin <basinilya@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 00:21:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxmiY-0005RT-59
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 00:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754055Ab2HDWUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Aug 2012 18:20:49 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:36656 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754034Ab2HDWUU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2012 18:20:20 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3WqKLm5nkyz4KK37;
	Sun,  5 Aug 2012 00:20:16 +0200 (CEST)
X-Auth-Info: 9ArjN0iOBtz8PprmBR0WReHbX/Dk16FZll/P//Rzv0g=
Received: from igel.home (ppp-93-104-128-70.dynamic.mnet-online.de [93.104.128.70])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3WqKLm5MZlzbbbq;
	Sun,  5 Aug 2012 00:20:16 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 63D06CA2A3; Sun,  5 Aug 2012 00:20:16 +0200 (CEST)
X-Yow: Then, it's off to RED CHINA!!
In-Reply-To: <7v7gte9una.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 04 Aug 2012 15:09:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202896>

Junio C Hamano <gitster@pobox.com> writes:

> Andreas Schwab <schwab@linux-m68k.org> writes:
>
>> Reset the branch back to before the import.
>
> Does the resulting history created by cvsimport after resetting a
> branch back to an older point exactly match the history before
> resetting (obviously modulo the tag that has been added since the
> original import)?

Usually it does.

> I recall that cvsimport tried hard to be reproducible and it should
> work, but I haven't run cvsimport myself for a long time, so...

As long as cvsps detects the same changesets.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
