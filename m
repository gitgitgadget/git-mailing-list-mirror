From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git gc expanding packed data?
Date: Sun, 09 Aug 2009 09:43:22 +0200
Message-ID: <m2k51dzb39.fsf@linux-m68k.org>
References: <m2tz0j154o.fsf@igel.home>
	<alpine.LFD.2.00.0908082246020.440@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hin-Tak Leung <hintak.leung@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Aug 09 09:44:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ma351-00010E-FP
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 09:44:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbZHIHnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 03:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752595AbZHIHnY
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 03:43:24 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:42340 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbZHIHnW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 03:43:22 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 786B71C153BD;
	Sun,  9 Aug 2009 09:43:22 +0200 (CEST)
X-Auth-Info: HjfJqqINpJdtfkd8OSYWXfCU63k9z8vRZquE1qIMkk0=
Received: from whitebox.home (DSL01.83.171.164.123.ip-pool.NEFkom.net [83.171.164.123])
	by mail.mnet-online.de (Postfix) with ESMTP id 3321F901F1;
	Sun,  9 Aug 2009 09:43:22 +0200 (CEST)
Received: by whitebox.home (Postfix, from userid 501)
	id 1B1091E5370; Sun,  9 Aug 2009 09:43:22 +0200 (CEST)
X-Yow: BELA LUGOSI is my co-pilot..
In-Reply-To: <alpine.LFD.2.00.0908082246020.440@xanadu.home> (Nicolas Pitre's
	message of "Sat, 08 Aug 2009 22:56:57 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125328>

Nicolas Pitre <nico@cam.org> writes:

> If you do a clone using the git:// protocol and the server sends you 
> only the ref for the trunk branch,

A clone will fetch all branches from refs/heads/*.

> then it should send you only objects reachable from that branch.

Apparantly this does not work.  I'd guess the extra objects are needed
due to the delta compression.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
