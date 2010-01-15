From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 08/14] daemon: use explicit file descriptor
Date: Fri, 15 Jan 2010 23:36:20 +0100
Message-ID: <201001152336.20662.j6t@kdbg.org>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com> <1263591033-4992-9-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	"Erik Faye-Lund" <kusmabite@gmail.com>
To: "Erik Faye-Lund" <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 23:37:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVunF-0007it-QK
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 23:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137Ab0AOWhT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 17:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758296Ab0AOWhT
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 17:37:19 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:50176 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758290Ab0AOWhS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 17:37:18 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 712FCCDF88;
	Fri, 15 Jan 2010 23:37:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id BB4C119F5A6;
	Fri, 15 Jan 2010 23:36:20 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <1263591033-4992-9-git-send-email-kusmabite@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137146>

On Freitag, 15. Januar 2010, Erik Faye-Lund wrote:
> This patch adds support to specify an explicit file
> descriotor for communication with the client, instead
> of using stdin/stdout.
>
> This will be useful for the Windows port, because it
> will use threads instead of fork() to serve multiple
> clients, making it impossible to reuse stdin/stdout.

This statement is a bit outdated.

-- Hannes
