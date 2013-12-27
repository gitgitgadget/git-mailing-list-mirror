From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git:// protocol over SSL/TLS
Date: Fri, 27 Dec 2013 14:29:51 +0100
Message-ID: <87r48y4e28.fsf@igel.home>
References: <CAErtv27qUMo9LsGAZtk5Zv9qnZRB_YAXhtskvrrNbWGqadQh7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Sergey Sharybin <sergey.vfx@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 27 14:30:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwXUn-0000ar-Hy
	for gcvg-git-2@plane.gmane.org; Fri, 27 Dec 2013 14:30:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241Ab3L0N36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Dec 2013 08:29:58 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:41785 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065Ab3L0N36 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Dec 2013 08:29:58 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3drTRP6ys2z4KK4G;
	Fri, 27 Dec 2013 14:29:53 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3drTRP6rWrzbblG;
	Fri, 27 Dec 2013 14:29:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id F3IDs3orhX39; Fri, 27 Dec 2013 14:29:51 +0100 (CET)
X-Auth-Info: 2TvmryKvhgD2/4J29xFaRhCp8Tm4Vmzx0DSri++PoC4=
Received: from igel.home (ppp-46-244-233-18.dynamic.mnet-online.de [46.244.233.18])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Fri, 27 Dec 2013 14:29:51 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 3922D2C1C8F; Fri, 27 Dec 2013 14:29:51 +0100 (CET)
X-Yow: Is this an out-take from the ``BRADY BUNCH''?
In-Reply-To: <CAErtv27qUMo9LsGAZtk5Zv9qnZRB_YAXhtskvrrNbWGqadQh7Q@mail.gmail.com>
	(Sergey Sharybin's message of "Fri, 27 Dec 2013 18:59:00 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239724>

Sergey Sharybin <sergey.vfx@gmail.com> writes:

> Quick question is, is it possible to use git:// protocol over
> SSL/TLS/other secure transport?

The git protocol itself performs no encryption or authentication by
design.  This is the job of the transport protocol.

> Or the recommended way to do secure anonymous checkout is to simply
> use https:// ?

Yes.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
