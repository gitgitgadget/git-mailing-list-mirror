From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 1/9] Define a structure for object IDs.
Date: Mon, 05 May 2014 13:05:09 +0200
Message-ID: <87r4485vve.fsf@igel.home>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
	<1399147942-165308-2-git-send-email-sandals@crustytoothpaste.net>
	<5365D91E.70207@alum.mit.edu> <536606AB.1020803@kdbg.org>
	<m2mwexke34.fsf@linux-m68k.org> <5366A09E.6030802@kdbg.org>
	<87ppjt6xjv.fsf@igel.home> <87lhugu7iw.fsf@fencepost.gnu.org>
	<87vbtk60lh.fsf@igel.home> <87d2fstuzw.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue May 06 18:58:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whhxs-0005Yp-3R
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389AbaEELFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 07:05:13 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:41501 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323AbaEELFM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 07:05:12 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3gMh6t2SG0z4KK7F;
	Mon,  5 May 2014 13:05:10 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3gMh6t1nBFzbbhm;
	Mon,  5 May 2014 13:05:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id ipLEl0GRxYYj; Mon,  5 May 2014 13:05:09 +0200 (CEST)
X-Auth-Info: KkKLtV+zwoKyIzbWmaPB7STlVEBJejvO2DniRClTE5M=
Received: from igel.home (ppp-188-174-147-7.dynamic.mnet-online.de [188.174.147.7])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Mon,  5 May 2014 13:05:09 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 46CA42C05AB; Mon,  5 May 2014 13:05:09 +0200 (CEST)
X-Yow: Can I have an IMPULSE ITEM instead?
In-Reply-To: <87d2fstuzw.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Mon, 05 May 2014 11:50:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248163>

David Kastrup <dak@gnu.org> writes:

> Your premise is _not_ assumed in my statement.  My premise was "a
> pointer to something of the same type of [the struct's] first member".
> That does quite explicitly _not_ state that an object of struct type is
> in existence.

So you are not taking about struct object_id, and it's irrelevant to
this thread.

This thread is about objects of type struct object_id, and their address
is always the same as the address of its first member.  Nothing else is
relevant.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
