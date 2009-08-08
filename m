From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git gc expanding packed data?
Date: Sat, 08 Aug 2009 15:25:27 +0200
Message-ID: <m21vnm8mk8.fsf@igel.home>
References: <m2tz0j154o.fsf@igel.home>
	<3ace41890908080605k4ec6661bmcb4c87e10bc5fd87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Hin-Tak Leung <hintak.leung@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 15:25:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZlvZ-000531-U1
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 15:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbZHHNZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 09:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656AbZHHNZc
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 09:25:32 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:40606 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbZHHNZc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 09:25:32 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id B2A2E1C1547D;
	Sat,  8 Aug 2009 15:25:30 +0200 (CEST)
Received: from localhost (dynscan2.mnet-online.de [192.168.1.215])
	by mail.m-online.net (Postfix) with ESMTP id 4C42690275;
	Sat,  8 Aug 2009 15:25:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.1.215]) (amavisd-new, port 10024)
	with ESMTP id dhhvoX0maqOa; Sat,  8 Aug 2009 15:25:28 +0200 (CEST)
Received: from igel.home (DSL01.83.171.176.2.ip-pool.NEFkom.net [83.171.176.2])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Sat,  8 Aug 2009 15:25:28 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id A1CA510C0D1; Sat,  8 Aug 2009 15:25:27 +0200 (CEST)
X-Yow: I HIJACKED a 747 to get here!!  I hope those fabulous CONEHEADS are at HOME!!
In-Reply-To: <3ace41890908080605k4ec6661bmcb4c87e10bc5fd87@mail.gmail.com>
	(Hin-Tak Leung's message of "Sat, 8 Aug 2009 14:05:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125277>

Hin-Tak Leung <hintak.leung@gmail.com> writes:

> Thanks... It is a difference between svn and git mentality probably -

It is just that the remote is a git-svn tree, with only a few branches
created as local branches.

> The case with gcc is probably quite extreme - many user branches, and
> very large code base - but is there anything on the git side with git
> gc which can lessen this kind of pathological behavior (expanding
> packs)?

If you fetch all refs, not only refs/heads/*, all objects will be
referenced.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
