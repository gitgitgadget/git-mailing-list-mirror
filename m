From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: cherry picking several patches at once
Date: Sun, 24 Jan 2010 12:52:34 +0200
Message-ID: <1264330354.14140.1.camel@gandalf>
References: <20100121161157.GA3628@gandalf>
	 <94a0d4531001221557n7a892f03u5e5d1c5e5ba5fea0@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 11:52:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZ05K-0001eV-7g
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 11:52:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753487Ab0AXKwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 05:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753451Ab0AXKwk
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 05:52:40 -0500
Received: from ns1.siteground211.com ([209.62.36.12]:47664 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611Ab0AXKwj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 05:52:39 -0500
Received: from [91.154.126.168] (port=18302 helo=[192.168.1.101])
	by serv01.siteground211.com with esmtpa (Exim 4.69)
	(envelope-from <me@felipebalbi.com>)
	id 1NZ055-0007k2-TN; Sun, 24 Jan 2010 04:52:36 -0600
In-Reply-To: <94a0d4531001221557n7a892f03u5e5d1c5e5ba5fea0@mail.gmail.com>
X-Mailer: Evolution 2.28.2 
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground211.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - felipebalbi.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137891>

Hi,

On Sat, 2010-01-23 at 01:57 +0200, Felipe Contreras wrote:
> Have you tried something like:
> git format-patch old-base --full-diff -- /path
> git am -3 *.patch

yes, sure that can be done, but the idea is to avoid having
format-patch, switch branches and git am those patches ;-)

> I think that would not be possible because of the challenges when
> dealing with conflicts.

there shouldn't be any. I have the same driver internally and publicly
and would be cherry-picking only the patches for that particular driver.

-- 
balbi
