From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 00/14] daemon-win32
Date: Fri, 15 Jan 2010 23:27:23 +0100
Message-ID: <201001152327.23189.j6t@kdbg.org>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	"Erik Faye-Lund" <kusmabite@gmail.com>
To: "Erik Faye-Lund" <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 23:28:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVuem-00042y-TT
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 23:28:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758285Ab0AOW2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 17:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758280Ab0AOW2Y
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 17:28:24 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:47486 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758273Ab0AOW2X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 17:28:23 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 21EC010011;
	Fri, 15 Jan 2010 23:28:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 415A219F5EB;
	Fri, 15 Jan 2010 23:27:23 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137140>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137140>

A very nicely done series. Thank you very much!

On Freitag, 15. Januar 2010, Erik Faye-Lund wrote:
> Here's the long overdue v2 of my daemon-win32 attempt. A lot
> has happened since v1. Most importantly, I abandoned using
> the async API to replace fork(), and went for explicitly
> spawning child process that handle the connection.

IOW, you run git-daemon recursively in inetd mode (almost). Let's see what 
people say about this approach.

-- Hannes
