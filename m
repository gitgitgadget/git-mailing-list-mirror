From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] [PATCH/RFC 08/11] daemon: use explicit file descriptor
Date: Fri, 27 Nov 2009 21:28:48 +0100
Message-ID: <200911272128.48974.j6t@kdbg.org>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com> <40aa078e0911270746x55946f52qd76dc4f9443aebc6@mail.gmail.com> <200911272123.45163.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: kusmabite@gmail.com, git@vger.kernel.org, dotzenlabs@gmail.com
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Fri Nov 27 21:29:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE7RE-0000op-V7
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 21:29:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbZK0U25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 15:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbZK0U25
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 15:28:57 -0500
Received: from [93.83.142.38] ([93.83.142.38]:63761 "EHLO dx.sixt.local"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750738AbZK0U25 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 15:28:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 0FAED19F610;
	Fri, 27 Nov 2009 21:28:49 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <200911272123.45163.j6t@kdbg.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133934>

On Freitag, 27. November 2009, Johannes Sixt wrote:
> On Freitag, 27. November 2009, Erik Faye-Lund wrote:
> > When I think more about it, I might've broken the inetd-mode as it
> > should communicate over stdin and stdout (not just stdin as it would
> > try to do now)... I don't know the inetd internals, but this frightens
> > me a bit.
>
> Do we need inetd mode on Windows? At one time a looked for a inetd-like
> service, but couldn't find one.

How foolish of me. This affects all platforms. Of course it is an important to 
keep inetd mode.

-- Hannes
