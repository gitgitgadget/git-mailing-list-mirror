From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Fix segfault in diff-delta.c when FLEX_ARRAY is 1
Date: Tue, 18 Dec 2007 12:15:04 +0100
Message-ID: <85ir2wjltz.fsf@lola.goethe.zz>
References: <1197941997-11421-1-git-send-email-madcoder@debian.org>
	<20071218014455.GB14981@artemis.madism.org>
	<alpine.LFD.0.9999.0712172032090.21557@woody.linux-foundation.org>
	<alpine.LFD.0.9999.0712172146070.21557@woody.linux-foundation.org>
	<7vwsrc1idm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Pierre Habouzit <madcoder@debian.org>, spearce@spearce.org,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 12:15:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4aPb-0006SO-IL
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 12:14:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281AbXLRLOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 06:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753429AbXLRLOh
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 06:14:37 -0500
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:52995 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753028AbXLRLOg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Dec 2007 06:14:36 -0500
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 897F94C509;
	Tue, 18 Dec 2007 12:14:34 +0100 (CET)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 711052D37E7;
	Tue, 18 Dec 2007 12:14:34 +0100 (CET)
Received: from lola.goethe.zz (dslb-084-061-004-197.pools.arcor-ip.net [84.61.4.197])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 366E71C72CA;
	Tue, 18 Dec 2007 12:14:20 +0100 (CET)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 3BDE71C4CE33; Tue, 18 Dec 2007 12:15:04 +0100 (CET)
In-Reply-To: <7vwsrc1idm.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 18 Dec 2007 01:07:01 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/5164/Tue Dec 18 10:56:45 2007 on mail-in-04.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68731>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>>  - diff-delta.c:250        memsize = sizeof(*index)
>
> I haven't studied this codepath.

My proposed patch should have addressed this as well.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
