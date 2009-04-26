From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Add core.trustlowlevelstat for diffs in dev,ino,uid and gid
Date: Sun, 26 Apr 2009 13:06:15 +0200
Message-ID: <200904261306.15448.robin.rosenberg.lists@dewire.com>
References: <1240743317-10117-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, spearce@spearce.org
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Apr 27 12:54:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ly2EG-0004e7-7L
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 13:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645AbZDZLGj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Apr 2009 07:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbZDZLGj
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 07:06:39 -0400
Received: from mail.dewire.com ([83.140.172.130]:13447 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752486AbZDZLGi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Apr 2009 07:06:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9889E8030D6;
	Sun, 26 Apr 2009 13:06:37 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WjhyT3sACcIb; Sun, 26 Apr 2009 13:06:37 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 0AF0B800253;
	Sun, 26 Apr 2009 13:06:36 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <1240743317-10117-1-git-send-email-robin.rosenberg@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117650>

s=F6ndag 26 april 2009 12:55:17 skrev Robin Rosenberg:
> This reason we may want to ignore these fields is that the Java imple=
mentation=20
> of Git cannot set these fields properly. To mark this JGit sets these=
 fields
> to to UINT_MAX (all bits set).

Oopps, you won't be able to apply this one, I'll resend a complete patc=
h later. It's probably possible to comment on
the goal of the patch anyway.

-- robin
