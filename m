From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Test for windows format absolute paths on cygwin too
Date: Fri, 31 Aug 2007 23:07:07 +0200
Message-ID: <200708312307.07930.robin.rosenberg.lists@dewire.com>
References: <xMhwifY1.1188551240.4001640.roro@localhost> <46D7DFE0.6040606@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 23:05:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRDgR-0006Rb-O1
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 23:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761087AbXHaVFg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 17:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761029AbXHaVFg
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 17:05:36 -0400
Received: from [83.140.172.130] ([83.140.172.130]:28071 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1760523AbXHaVFf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 17:05:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 3B2C080286F;
	Fri, 31 Aug 2007 22:57:43 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 10121-03; Fri, 31 Aug 2007 22:57:42 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id D8AEB8026E8;
	Fri, 31 Aug 2007 22:57:42 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <46D7DFE0.6040606@eudaptics.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57208>

fredag 31 augusti 2007 skrev Johannes Sixt:
> Robin Rosenberg schrieb:
> > ---
> > 
> > Requires cherry-picking 6397c3119ecaa258b5185315c64062bec29bcd86
> 
> ... which you find in mingw.git.

> 
> However, that commit is not signed-off for a reason: It is going to be 
> rewritten mostly because it doesn't yet use the is_absolute_path() from 
> git-compat-util.h.

Ah, yes. It can probably wait. I needed this for the Eclipse Git plugin to work
nicely wth shared cloned repos under cygwin. With full clones there is no such
problem. Before the patch I created two references, one for cygwin and one
for EGIT, but cygwin was very noisy with that workaround and git-gui/gitk didn't
work reliably when they did work at all.

-- robin
