From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 09/14] daemon: use run-command api for async serving
Date: Fri, 15 Jan 2010 23:42:34 +0100
Message-ID: <201001152342.35081.j6t@kdbg.org>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com> <1263591033-4992-10-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	"Erik Faye-Lund" <kusmabite@gmail.com>
To: "Erik Faye-Lund" <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 23:43:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVutG-0001gQ-NE
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 23:43:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758512Ab0AOWnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 17:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758299Ab0AOWnf
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 17:43:35 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:51931 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758189Ab0AOWne (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 17:43:34 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id DED8110014;
	Fri, 15 Jan 2010 23:43:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 30A1B19F5A6;
	Fri, 15 Jan 2010 23:42:35 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <1263591033-4992-10-git-send-email-kusmabite@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137148>

On Freitag, 15. Januar 2010, Erik Faye-Lund wrote:
> fork() is only available on POSIX, so to support git-daemon
> on Windows we have to use something else. Conveniently
> enough, we have an API for async operation already.

I had a huh?-moment when I read this statement. This patch does not use what 
we call 'async', but start_command().

-- Hannes
