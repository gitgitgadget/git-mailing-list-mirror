From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Unexpected error: short SHA1 is ambiguous
Date: Sun, 27 Jun 2010 21:02:56 +0200
Message-ID: <m2lja0wb6n.fsf@igel.home>
References: <AANLkTikSUBgySbxtKO1iB-GYFgxaL5lY0mfbb5f_xxMS@mail.gmail.com>
	<alpine.LFD.2.00.1006262323310.24097@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Jun 27 21:03:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSx8G-0000jC-QR
	for gcvg-git-2@lo.gmane.org; Sun, 27 Jun 2010 21:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755193Ab0F0TC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jun 2010 15:02:59 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:52121 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754598Ab0F0TC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jun 2010 15:02:58 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 44EBD1C00208;
	Sun, 27 Jun 2010 21:02:57 +0200 (CEST)
Received: from igel.home (ppp-88-217-122-223.dynamic.mnet-online.de [88.217.122.223])
	by mail.mnet-online.de (Postfix) with ESMTP id 0E6071C00134;
	Sun, 27 Jun 2010 21:02:57 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id B2EF1CA297; Sun, 27 Jun 2010 21:02:56 +0200 (CEST)
X-Yow: Just imagine you're entering a state-of-the-art CAR WASH!!
In-Reply-To: <alpine.LFD.2.00.1006262323310.24097@xanadu.home> (Nicolas
	Pitre's message of "Sat, 26 Jun 2010 23:35:24 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149799>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Sat, 26 Jun 2010, Jay Soffian wrote:
>> 1. Since I restricted to commits with ^0, and there's only one such
>> commit, shouldn't rev-list give me what I want? (rev-parse similarly
>> fails).
>
> No, the ^0 is not restricting anything.  It merely says you want to walk 
> through zero parents from the specified commit, but the commit 
> specification is ambiguous (3 possibilities exist).

But ^0 can only be applied to a commit, and only one commit matches
aabb.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
