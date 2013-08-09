From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git status resets permissions on index file -- Ubuntu 12.04 64b
Date: Fri, 09 Aug 2013 14:40:18 +0200
Message-ID: <8761vf3uml.fsf@igel.home>
References: <CACO0oR7a1-fUASQ+SJVbH1CU8d=NbHrK0MuMu+9Pr4_=7q85Vw@mail.gmail.com>
	<52040F27.4050908@googlemail.com> <20130808221807.GA8518@gmail.com>
	<C525FA0D-D22C-4C78-8C97-45819FD58DD7@gmail.com>
	<CACO0oR7tJNKWA=cynBA8R2kaGr2iKNCiCmXKLur9nub6pnBG0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	Andrew Ruder <andy@aeruder.net>, Git List <git@vger.kernel.org>
To: Justin Collum <jcollum@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 14:40:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7lzW-0001IQ-Qk
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 14:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756798Ab3HIMkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 08:40:23 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:52814 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754902Ab3HIMkW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 08:40:22 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3cBQyr1mg5z4KK3r;
	Fri,  9 Aug 2013 14:40:19 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3cBQyq6pb4zbbcM;
	Fri,  9 Aug 2013 14:40:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id gW30_GVgyNYK; Fri,  9 Aug 2013 14:40:18 +0200 (CEST)
X-Auth-Info: sXiBICtSLlVGOv0CLDW3OIYxhIBaAQEpppvyzSBOuDE=
Received: from igel.home (ppp-93-104-152-252.dynamic.mnet-online.de [93.104.152.252])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Fri,  9 Aug 2013 14:40:18 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 61C392C150B; Fri,  9 Aug 2013 14:40:18 +0200 (CEST)
X-Yow: I'm having a RELIGIOUS EXPERIENCE..  and I don't take any DRUGS
In-Reply-To: <CACO0oR7tJNKWA=cynBA8R2kaGr2iKNCiCmXKLur9nub6pnBG0g@mail.gmail.com>
	(Justin Collum's message of "Thu, 8 Aug 2013 16:58:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231975>

Justin Collum <jcollum@gmail.com> writes:

>      sudo chmod 644 ./.git/index

That doesn't make sense.  If you are the owner of the file, why do you
need sudo???

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
