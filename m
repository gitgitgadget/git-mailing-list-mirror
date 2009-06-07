From: =?ISO-8859-1?Q?Andreas_F=E4rber?= <andreas.faerber@web.de>
Subject: mkstemps compat issue
Date: Sun, 7 Jun 2009 14:32:50 +0200
Message-ID: <ED882BBA-E0E7-4CCC-9C6B-72FEBED1C9E0@web.de>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 07 14:33:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDHYy-0005dv-JN
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 14:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645AbZFGMdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 08:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753531AbZFGMdP
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 08:33:15 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:59116 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335AbZFGMdO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 08:33:14 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 5BCE5104AE07B;
	Sun,  7 Jun 2009 14:33:16 +0200 (CEST)
Received: from [84.148.59.44] (helo=[10.0.0.2])
	by smtp05.web.de with asmtp (TLSv1:AES128-SHA:128)
	(WEB.DE 4.110 #277)
	id 1MDHYm-00077a-00; Sun, 07 Jun 2009 14:33:12 +0200
X-Mailer: Apple Mail (2.935.3)
X-Sender: Andreas.Faerber@web.de
X-Provags-ID: V01U2FsdGVkX1/DhThIa8WuEPBZijV3UzoLTkWwcXKkjgJ8nzWV
	r9Zr1/bu9O4hSGkrClE8OpcO61teGtEhZYxfkZJcd/80BSqQSC
	Jrqrx0pyANOgRtfTKZdw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120967>

Hello,

The merge commit b11cf09043f18b368ec0d988f064ea21247c843d introduced a  
git_mkstemps function in path.c, using mkstemps for the  
implementation. Unlike mkstemp that function is not part of POSIX, so  
we seem to need a NO_MKSTEMPS option and corresponding alternative  
code path.

Any suggestions how to best replace mkstemps?

Thanks,
Andreas

[Please keep me cc'ed.]
