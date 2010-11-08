From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Rebase problems
Date: Mon, 08 Nov 2010 20:30:36 +0100
Message-ID: <m2vd47iper.fsf@igel.home>
References: <loom.20101108T190513-206@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Mon Nov 08 20:30:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFXQS-0004uw-PE
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 20:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343Ab0KHTaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 14:30:39 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:56733 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231Ab0KHTai (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 14:30:38 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 7F1DD1C15F49;
	Mon,  8 Nov 2010 20:30:36 +0100 (CET)
Received: from igel.home (ppp-93-104-144-153.dynamic.mnet-online.de [93.104.144.153])
	by mail.mnet-online.de (Postfix) with ESMTP id 739051C0043E;
	Mon,  8 Nov 2010 20:30:36 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 424B6CA2A0; Mon,  8 Nov 2010 20:30:36 +0100 (CET)
X-Yow: Look!!  Karl Malden!
In-Reply-To: <loom.20101108T190513-206@post.gmane.org> (Maaartin's message of
	"Mon, 8 Nov 2010 18:19:09 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160973>

Maaartin <grajcar1@seznam.cz> writes:

> There's a file containing the timestamp which gets compiled in, so the 
> executable can show it's version. Sometimes, I need to set it couple of times a 
> day, sometimes only once a week. For each such timestamp I create a tag, so I 
> can track it to the source easily. The timestamp is an important piece of 
> information, so I put the containing file under version control. The downside is 
> that I often get a conflict in this file halting my rebase. Is there a way how 
> to ignore or automatically resolve all conflicts in this file (any resolution 
> strategy is fine, as it will be overwritten anyway).

If you already have a tag for every timestamp, why not autogenerate the
timestamp from the tag?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
